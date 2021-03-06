require 'rails_helper'

describe 'Editing a family profile' do
  it 'lets me update family profile if the family data is valid' do
    user = create(:user)
    family = user.create_family(attributes_for(:family))
    login_user(user)
    visit edit_family_path(family)
    fill_in 'First Name(s)', with: 'Jane'
    fill_in 'Last Name', with: 'Doess'
    fill_in 'Address', with: '1234 Main Street Blvd.'
    fill_in 'City', with: 'New York'
    select 'New York', from: 'State'
    fill_in 'Zip/Postal Code', with: '54321'
    fill_in 'Phone', with: '(123) 456-7890'
    fill_in 'Estimated Adoption Cost', with: '54321.00'
    select 'Angola', from: 'Country'
    select '1', from: 'How many children are you adopting?'
    fill_in 'Message to your visitors', with: 'Hi nobody, please don\'t give me money.'
    attach_file('family[photo]', File.absolute_path('./spec/support/test_family.jpg'))
    select 'Paperwork Not Started', from: 'Adoption Status'
    fill_in 'Adoption Agency', with: 'Holt & Cradle'
    fill_in 'Adoption Agency URL', with: 'http://www.holtandcradle.com'
    click_button('Save Changes to My Family Profile')

    expect(page).not_to have_text('John')
    expect(page).to have_text('Jane Doess')
    expect(page).to have_text('Your family profile has been updated')
  end

  it "doesn't let me edit the family profile if the family data is invalid" do
    user = create(:user)
    family = user.create_family(attributes_for(:family))
    login_user(user)
    visit edit_family_path(family)
    fill_in 'First Name(s)', with: ''
    fill_in 'Last Name', with: ''
    fill_in 'Address', with: ''
    fill_in 'City', with: ''
    fill_in 'Zip/Postal Code', with: ''
    fill_in 'Phone', with: ''
    fill_in 'Estimated Adoption Cost', with: ''
    fill_in 'Message to your visitors', with: ''
    fill_in 'Adoption Agency', with: ''
    fill_in 'Adoption Agency URL', with: ''
    click_button('Save Changes to My Family Profile')

    expect(page).not_to have_text('example@gmail.com')
    expect(page).not_to have_text('Your family profile is now live!')
    expect(page).to have_text('Oops! The family could not be saved.')
  end
end
