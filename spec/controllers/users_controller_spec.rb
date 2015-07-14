require 'rails_helper'

describe UsersController do
  before do
    @user = create(:user)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end
    
    it "does not let me edit" do
      get :edit, id: @user

      expect(response).to redirect_to(login_url)
    end

  end
end
