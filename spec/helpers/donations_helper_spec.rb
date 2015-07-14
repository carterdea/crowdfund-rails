require 'rails_helper'

describe 'Making a donation to a family' do
  it "makes the donation if the family data & user data is valid" do
    visit new_family_donation_path
    choose('$100')
    choose('10%')

    click_link('Next')
    click_link('Next')
    fill_in 'Name', with: 'John Doe'

  end
end