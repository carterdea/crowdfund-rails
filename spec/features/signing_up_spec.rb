require 'rails_helper'

describe 'Signing Up' do
  it 'lets me sign up with proper email & password' do
    visit signup_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'secret'
    click_button('Sign Up')
    expect(page).to_not have_text('Sign Up')
    expect(page).to have_text('john@example.com')
    expect(page).to have_text('Thanks for signing up!')
  end

  it 'doesn\'t let me log in with improper email & password' do
    visit signup_path
    fill_in 'Email', with: 'john.com'
    fill_in 'Password', with: ''
    click_button('Sign Up')
    expect(page).to have_text('Login')
    expect(page).to have_text('Oops! The user could not be saved.')
    expect(page).to_not have_text('john.com')
  end
end