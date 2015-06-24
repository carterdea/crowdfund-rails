require 'rails_helper'

describe SessionsController do

  describe "when not logged in" do
    it "doesn't accept an invalid email"

    it "doesn't accept an invalid password"

    it "requires a valid email"

    it "requires a password"

    it "accepts a valid email & password"
  end

  describe "when logged in" do
    it "doesn't let user see the login"

    it "lets user log out"

    it "shows the user's email"

    describe "and the user has a family" do
      # before_action
      it "it show the user's full name"
    end
  end

end
