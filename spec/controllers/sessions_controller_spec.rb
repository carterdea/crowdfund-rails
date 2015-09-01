require 'rails_helper'

describe SessionsController do
  describe 'when not logged in' do
    it 'requires an email' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors.any?).to eq(true)
    end

    it 'requires a password' do
      user = build(:user, password: '')
      user.valid?
      expect(user.errors.any?).to eq(true)
    end

    it 'requires a valid email' do
      user = build(:user, email: 'email.com')
      user.valid?
      expect(user.errors.any?).to eq(true)
    end

    it 'requires a valid password' do
      user = build(:user, password: '1234')
      user.valid?
      expect(user.errors.any?).to eq(true)
    end

    it 'accepts a valid email & password' do
      user = build(:user)
      user.valid?
      expect(user.errors.any?).to eq(false)
    end
  end

  # describe 'when logged in' do
  #   before do
  #     @user = create(:user)
  #     login(@user.email, @user.password)
  #   end

  #   it "doesn't let user see the login" do
  #     visit login_path
  #     expect(response).to redirect_to(root_url)
  #     expect(page).not_to have_text(login)
  #   end

  #   it 'lets user log out' do
  #     visit root_url
  #     click_link 'Logout'
  #     expect(response).to redirect_to(root_url)
  #     expect(page).to have_text('You are now logged out')
  #     expect(page).to have_text('Login')
  #     expect(page).not_to have_text(@user.email)
  #   end

  #   it 'shows the user\'s email' do
  #     visit root_url
  #     expect(page).to have_text(@user.email)
  #   end

  #   describe 'and the user has a family' do
  #     before do
  #       @family = @user.families.create(family_attributes)
  #     end

  #     it it 'show the user\'s full name' do
  #       visit root_url
  #       expect(page).to have_text(@family.full_name)
  #     end
  #   end
  # end
end
