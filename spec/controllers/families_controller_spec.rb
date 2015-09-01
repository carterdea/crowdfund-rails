require 'rails_helper'

describe FamiliesController do
  it 'rejects invalid family data' do
    @family = build(:family, first_name: '', last_name: '')

    @family.valid?
    expect(@family.errors.any?).to eq(true)
  end

  it 'rejects invalid user data' do
    @user = build(:user, email: '', password: '')

    @user.valid?
    expect(@user.errors.any?).to eq(true)
  end

  it 'requires valid family & user data' do
    @user = build(:user)
    @family = build(:family)
    @user.valid?
    @family.valid?
    @family.errors.full_messages.each do |message|
      puts message
    end
    expect(@user.errors.any?).to eq(false)
    expect(@family.errors.any?).to eq(false)
  end
end
