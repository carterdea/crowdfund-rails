require 'rails_helper'

describe 'Logging In' do
  it 'lets me log in with proper credentials' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'secret'
    click_button('Log In')
    expect(page).to_not have_text('Login')
    expect(page).to have_text(user.email)
  end

  it 'doesn\'t let me log in with improper credentials' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'letmein'
    click_button('Log In')
    expect(page).to have_text('Email or password was invalid. Try again.')
    expect(page).to_not have_text('john@example.com')
  end
end