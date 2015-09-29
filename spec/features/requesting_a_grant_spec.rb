require 'rails_helper'

describe 'Requesting a grant' do
  it "doesn't let you make a grant request if you haven't uploaded an approval letter" do
    user = create(:user)
    family = user.create_family(attributes_for(:family))
    login_user(user)
    visit family_grants_path(family)
    expect(page).not_to have_button('New Grant Request')
    expect(page).to have_text('New Grant Request')
  end

  # it "lets you make a grant request if you've uploaded an approval letter" do
  #   user = create(:user)
  #   family = user.create_family(attributes_for(:family, :approval_letter_file))
  #   login_user(user)
  #   visit family_grants_path(family)
  #   expect(page).not_to have_button('Upload Your Approval Letter')
  #   click_button('Request a Grant')
  #   expect(page).to have_text('Request a Grant')
  #   fill_in 'Amount Requested', with: '4321.00'
  #   fill_in 'Expense description', with: 'I need to pay my adoption lawyer for all the adoption things I need.'
  #   fill_in 'Name', with: 'Bob Loblaw'
  #   fill_in 'Address', with: '1 Lucille Lane'
  #   fill_in 'City', with: 'Newport'
  #   select 'California', from: 'State'
  #   fill_in 'Zip Code', with: '12345'
  #   check 'I am requesting a grant to cover my adoption related expenses.'
  #   click_button('Request a Grant')
  #   expect(page).to have_text("Thanks for requesting a grant! We'll get back to you soon")
  #   expect(page).to have_text('Grant for Bob Loblaw')
  #   expect(page).to have_text('$12,345')
  #   expect(page).to have_text('I am requesting a grant to cover my adoption related expenses.')
  # end

  # it "doesn't let you make a grant request with invalid data" do
  #   user = create(:user)
  #   family = user.create_family(attributes_for(:family, :approval_letter_file))
  #   login_user(user)
  #   visit family_grants_path(family)
  #   click_button('Request a Grant')
  #   expect(page).to have_text('Request a Grant')
  #   fill_in 'Amount Requested', with: '4321.00'
  #   fill_in 'Expense description', with: 'I need to pay my adoption lawyer for all the adoption things I need.'
  #   fill_in 'Name', with: 'Bob Loblaw'
  #   fill_in 'Address', with: '1 Lucille Lane'
  #   fill_in 'City', with: 'Newport'
  #   select 'California', from: 'State'
  #   fill_in 'Zip Code', with: '12345'
  #   check 'I am requesting a grant to cover my adoption related expenses.'
  #   click_button('Request a Grant')
  #   expect(page).to have_text("Thanks for requesting a grant! We'll get back to you soon")
  #   expect(page).to have_text('Grant for Bob Loblaw')
  #   expect(page).to have_text('$12,345')
  #   expect(page).to have_text('I am requesting a grant to cover my adoption related expenses.')
  # end
end
