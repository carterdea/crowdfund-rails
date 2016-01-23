require 'rails_helper'

describe Donation, '#donor_name' do
  it 'shows full name when anonymous is NOT chosen' do
    donation = build_stubbed(:donation, name: 'John Doe', anonymous: false)

    expect(donation.donor_name).to eq('John Doe')
  end

  it 'says anonymous when anonymous is chosen' do
    donation = build_stubbed(:donation, name: 'John Doe', anonymous: true)

    expect(donation.donor_name).to eq('Anonymous')
  end
end

describe Donation, '#donation_amount' do
  it 'hides the amount if the user wishes to hide the amount' do
    donation = build_stubbed(:donation, amount: 100, hide_amount: true)

    expect(donation.donation_amount).to eq('an undisclosed amount')
  end

  it 'adds a $ if the user doesn\'t hide the amount' do
    donation = build_stubbed(:donation, amount: 100, hide_amount: false)

    expect(donation.donation_amount).to eq('$100')
  end
end

describe Donation, '#type' do
  it 'shows as a monthly donation if the user chooses to make it monthly' do
    donation = build_stubbed(:donation, recurring: true)

    expect(donation.type).to eq('Monthly Donation')
  end

  it 'shows as a one-time donation if the user chooses not to make it monthly' do
    donation = build_stubbed(:donation, recurring: false)

    expect(donation.type).to eq('One-Time Donation')
  end
end
