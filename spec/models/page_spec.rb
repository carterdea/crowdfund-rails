# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by      :string
#  seo_title       :string
#  seo_description :string
#  live            :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Page, type: :model do
end
