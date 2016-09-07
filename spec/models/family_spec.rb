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

require 'rails_helper'

describe Family, '#full_name' do
  it 'concatenates first_name & last_name' do
    family = build_stubbed(:family, first_name: 'John', last_name: 'Doe')

    expect(family.full_name).to eq('John Doe')
  end
end

describe Family, '#pluralize_is' do
  it 'is "is" when the first_name is 1 name' do
    family = build_stubbed(:family, first_name: 'John')

    expect(family.pluralize_is).to eq('is')
  end

  it 'is "are" when the first_name is 2 names' do
    family = build_stubbed(:family, first_name: 'John and Jane')

    expect(family.pluralize_is).to eq('are')
  end
end

describe Family, '#number_of_children' do
  it 'says "a child" when the quantity is 1' do
    family = build_stubbed(:family, quantity: 1)

    expect(family.number_of_children).to eq('a child')
  end

  it 'says "X children" when the quantity is 2+' do
    family = build_stubbed(:family, quantity: 4)

    expect(family.number_of_children).to eq('4 children')
  end
end

describe Family, '#generate_slug' do
  it 'makes a slug from "the" plus the last_name pluralized' do
    family = create(:family, last_name: 'Doe')

    expect(family.slug).to eq('the-does')
  end

  it 'adds a number at the end if that slug already exists' do
    family = create(:family, last_name: 'Doe')
    family2 = create(:family, last_name: 'Doe')

    expect(family2.slug).to eq('the-does-1')
  end
end

describe Family, '#add_http' do
  it 'adds http to agency_site' do
    family = create(:family, agency_site: 'www.google.com')

    expect(family.agency_site).to eq('http://www.google.com')
  end

  it 'does not add http if it already starts with http' do
    family = create(:family, agency_site: 'http://www.google.com')

    expect(family.agency_site).not_to eq('http://http://www.google.com')
    expect(family.agency_site).to eq('http://www.google.com')
  end
end
