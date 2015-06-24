require 'rails_helper'

describe "Viewing a page" do
  it "takes a user to the homepage" do
    visit root_url
    expect(page).to have_text("Help Fund Adoptions")
  end
end
