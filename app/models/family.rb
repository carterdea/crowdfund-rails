# == Schema Information
#
# Table name: families
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  first_name           :string
#  last_name            :string
#  phone                :string
#  postal_code          :string
#  city                 :string
#  state                :string
#  cost                 :decimal(15, 2)   default(0.0)
#  country              :string
#  gender               :string
#  quantity             :integer
#  description          :text
#  status               :string
#  agency_name          :string
#  agency_site          :string
#  photo                :string
#  approved             :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  approval_letter_file :string
#  slug                 :string
#  address              :string
#  visible              :boolean          default(TRUE)
#  donations_count      :integer          default(0)
#  updates_count        :integer          default(0)
#  grants_count         :integer          default(0)
#

require 'elasticsearch/model'
require 'file_size_validator'

# app/models/family.rb
class Family < ActiveRecord::Base  
  VALID_URL_REGEX = %r{\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z}
  ADOPTION_STATUSES = [
    'Paperwork Not Started',
    'Paperwork Filed',
    'Homestudy Scheduled',
    'Homestudy Completed',
    'Awaiting Matching',
    'Matched',
    'Completed'
  ]

  belongs_to :user, touch: true, dependent: :destroy
  has_many :donations, as: :recipient, dependent: :destroy
  has_many :updates, dependent: :destroy
  has_many :grants, dependent: :destroy

  validates :first_name, :last_name, :postal_code, :user_cost, :cost, presence: true
  validates :photo, presence: true, file_size: { maximum: 2.megabytes.to_i }
  validates_length_of :description, maximum: 2000, message: 'Please keep your story to less than 2,000 characters.'
  validates :cost, numericality: { less_than: 1_000_000 }
  validates :country, presence: true, length: { is: 2 }
  validates :quantity, numericality: { greater_than: 0 }
  validates :slug, uniqueness: true, presence: true, exclusion: { in: EXCLUDED_SLUGS }
  validates :phone, :address, :city, :state, presence: true, on: :update
  validates :agency_site, format: VALID_URL_REGEX, allow_blank: true
  validates_associated :user, on: :create

  before_validation :generate_slug, on: :create
  before_validation :add_http

  mount_uploader :photo, ImageUploader
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  scope :approved, -> { where(approved: true).order('families.created_at DESC') }
  scope :unapproved, -> { where approved: false }

  scope :visible, -> { where(visible: true).order('families.created_at DESC') }
  scope :hidden, -> { where(visible: false) }

  scope :include_total_raised, -> { joins('LEFT OUTER JOIN donations ON families.id = donations.recipient_id').select('families.*, COALESCE(SUM(donations.amount), 0) AS total_raised').group('families.id') }

  def to_param
    slug
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # Using a virtual attribute (user cost for cost) to clean up the user input
  def user_cost
    cost if cost
  end

  def user_cost=(cost)
    self.cost = cost.delete('$,') if cost.present?
  end

  def funded?
  end

  def country_name
    Country["#{country}"].name
  end

  def pluralize_is
    if first_name.include?(' ' || 'and' || '&')
      'are'
    else
      'is'
    end
  end

  def number_of_children
    if quantity > 1
      "#{quantity} children"
    else
      'a child'
    end
  end

  def total_amount_donated_until(date)
    donations.where('date(created_at) <= ?', date).sum(:amount)
  end

  def donations_chart_data(start = 1.weeks.ago)
    (start.to_date.prev_day..Date.tomorrow).map do |date|
      {
        date: date.to_s,
        amount: total_amount_donated_until(date)
      }
    end
  end

  def self.to_csv(options = { headers: true })
    CSV.generate(options) do |csv|
      attributes = %w(id user_id first_name last_name quantity country status total_raised cost status approved visible phone address city state postal_code agency_name slug donations_count updates_count grants_count created_at updated_at)
      csv << attributes
      all.include_total_raised.each do |family|
        csv << attributes.map { |attr| family.send(attr) }
      end
    end
  end

  private

  def generate_slug
    self.slug ||= "the-#{last_name.pluralize.parameterize}"
    suffix = 1
    while Family.find_by_slug(self.slug)
      self.slug = "the-#{last_name.pluralize.parameterize}-#{suffix}"
      suffix += 1
    end
  end

  def add_http
    if agency_site.present?
      self.agency_site = "http://#{agency_site}" unless agency_site[%r{\Ahttp:\/\/}] || agency_site[%r{\Ahttps:\/\/}]
    end
  end
end

Family.__elasticsearch__.create_index! force: true
Family.import
Family.__elasticsearch__.refresh_index!
