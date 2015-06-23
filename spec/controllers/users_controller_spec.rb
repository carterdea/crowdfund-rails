require 'rails_helper'

describe UsersController do
  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do
    it "does not let me edit"

  end
end
