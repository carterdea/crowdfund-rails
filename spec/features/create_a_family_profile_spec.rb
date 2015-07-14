require 'rails_helper'

describe 'Creating a family profile' do
  it "makes an account and a family profile if the family data & user data is valid" do
    visit new_family_path
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'example@gmail.com'
    fill_in 'Password', with: 'secret'
    fill_in 'Phone', with: '(123) 456-2387'
    fill_in 'Zip/Postal Code', with: '12345'
    fill_in 'Estimated Adoption Cost', with: '12345.00'
    select 'Australia', from: 'Country'
    choose 'Either'
    select '1', from: 'How many children are you adopting?'
    fill_in 'Message to your visitors', with: 'Hi everyone, Please consider donating.'
    select 'Paperwork Not Started', from: 'Adoption Status'
    fill_in 'Adoption Agency', with: 'Holt & Cradle'
    fill_in 'Adoption Agency URL', with: 'http://www.holtandcradle.com'
    click_button('Apply for a Profile')

    expect(page).not_to have_text('Login')
    expect(page).to have_text('John Doe')
    expect(page).to have_text('Thanks for setting up your family profile')
  end

  it "doesn't make an account or a family profile if the family data is invalid & user data is valid" do
    visit new_family_path
    fill_in 'First Name', with: ''
    fill_in 'Last Name', with: ''
    fill_in 'Email', with: 'example@gmail.com'
    fill_in 'Password', with: 'secret'
    fill_in 'Phone', with: '(123) 456-2387'
    fill_in 'Zip/Postal Code', with: '12345'
    fill_in 'Estimated Adoption Cost', with: '12345.00'
    select 'Australia', from: 'Country'
    choose 'Either'
    select '1', from: 'How many children are you adopting?'
    fill_in 'Message to your visitors', with: 'Hi everyone, Please consider donating.'
    select 'Paperwork Not Started', from: 'Adoption Status'
    fill_in 'Adoption Agency', with: 'Holt & Cradle'
    fill_in 'Adoption Agency URL', with: 'http://www.holtandcradle.com'
    click_button('Apply for a Profile')

    expect(page).not_to have_text('example@gmail.com')
    expect(page).not_to have_text('John Doe')
    expect(page).not_to have_text('Thanks for setting up your family profile')
    expect(page).to have_text('Login')
  end

  it "doesn't make an account or a family profile if the family data is valid & user data is invalid" do
    visit new_family_path
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Phone', with: '(123) 456-2387'
    fill_in 'Zip/Postal Code', with: '12345'
    fill_in 'Estimated Adoption Cost', with: '12345.00'
    select 'Australia', from: 'Country'
    choose 'Either'
    select '1', from: 'How many children are you adopting?'
    fill_in 'Message to your visitors', with: 'Hi everyone, Please consider donating.'
    select 'Paperwork Not Started', from: 'Adoption Status'
    fill_in 'Adoption Agency', with: 'Holt & Cradle'
    fill_in 'Adoption Agency URL', with: 'http://www.holtandcradle.com'
    click_button('Apply for a Profile')

    expect(page).not_to have_text('example@gmail.com')
    expect(page).not_to have_text('John Doe')
    expect(page).not_to have_text('Thanks for setting up your family profile')
    expect(page).to have_text('Login')
  end
end
