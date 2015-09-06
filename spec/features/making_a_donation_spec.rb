require 'rails_helper'

describe 'Making a donation to a family' do
  it 'makes the donation if the family data & user data is valid', :js => true do
    family = create(:family)
    visit family_path(family)
    expect(page).to have_text('John Doe')
    click_link('Give to this Adoption')
    expect(page).to have_text('Donate to a Family')
    page.find('label[for="donation_amount_100"]').click
    choose('10%')
    click_link('Donation Info')
    fill_in 'Name', with: 'John Smith'
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    click_link('Payment Info')
    # Masking messed with jquery Payment for some reason :/
    # fill_in 'Card number', with: '4242'
    page.execute_script '$("#card_number").val("4242424242424242");'
    # fill_in 'Expiration date', with: '12'
    page.execute_script '$("#expiration_date").val("12/19");'
    # fill_in 'Security code', with: '123'
    page.execute_script '$("#security_code").val("123");'
    click_button('Donate')

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thank you for your donation!')
  end

  it "respects a donor's privacy settings" do
  end
end
