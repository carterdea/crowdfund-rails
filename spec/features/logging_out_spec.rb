require 'rails_helper'

describe 'Logging Out' do
  it 'lets me log out', :js do
    VCR.use_cassette('log out') do
      user = create(:user)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'secret'
      click_button('Log In')
      expect(page).to_not have_text('Login')
      expect(page).to have_text(user.email)
      click_link(user.email)
      click_link('Log out')
      expect(page).to_not have_text(user.email)
      expect(page).to have_text('You are now logged out.')
      expect(page).to have_text('Login')
    end
  end
end
