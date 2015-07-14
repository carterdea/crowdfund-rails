require 'rails_helper'

describe 'Making a donation to a family' do
  it "makes the donation if the family data & user data is valid" do
    family = create(:family)
    visit new_family_donation_path(family)
    choose('$100')
    choose('10%')
    click_link('Next')
    fill_in 'Name', with: 'John Doe'
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    click_link('Next')
    fill_in 'Card number', with: '4242424242424242'
    fill_in 'Expiration date', with: '12/19'
    fill_in 'Security code', with: '123'
    click_link('Donate')

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thanks for your generous donation')
  end

  it "respects a donor's privacy settings" do
  end
end