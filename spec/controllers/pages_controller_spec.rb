require 'rails_helper'

describe "Pages controller" do
  # describe "when visiting the home page" do
    it "takes the user to the homepage" do
      visit root_path
      expect(page).to have_text("Help Fund Adoptions")
    end
  # end
end
