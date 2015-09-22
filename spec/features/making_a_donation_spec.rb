require 'rails_helper'

describe 'Making a donation to a family' do

  it 'makes the donation if the family data & user data is valid', js: true do
    family = create(:family)
    visit family_path(family)
    expect(page).to have_text('John Doe')
    click_link('Give to this Adoption')
    expect(page).to have_text('Donate to a Family')
    page.find('label[for="donation_amount_100"]').click
    choose('10%')
    within('.amount.tab-pane') { click_link('Next') }
    fill_in 'Name', with: 'John Smith'
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    within('.donation-info.tab-pane') { click_link('Next') }
    # Masking messed with jquery Payment for some reason :/
    page.execute_script '$("#card_number").val("4242424242424242");'
    page.execute_script '$("#expiration_date").val("12/19");'
    page.execute_script '$("#security_code").val("123");'
    within('.new_donation') { click_button('Donate') }

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thank you for your donation!')
  end

  it "respects a donor's privacy settings", js: true do
    family = create(:family)
    visit family_path(family)
    expect(page).to have_text('John Doe')
    click_link('Give to this Adoption')
    expect(page).to have_text('Donate to a Family')
    page.find('label[for="donation_amount_100"]').click
    choose('10%')
    check('Make my donation amount private')
    within('.amount.tab-pane') { click_link('Next') }
    fill_in 'Name', with: 'John Smith'
    check('Make this donation anonymous')
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    within('.donation-info.tab-pane') { click_link('Next') }
    page.execute_script '$("#card_number").val("4242424242424242");'
    page.execute_script '$("#expiration_date").val("12/19");'
    page.execute_script '$("#security_code").val("123");'
    within('.new_donation') { click_button('Donate') }

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thank you for your donation!')
    visit family_path(family)
    expect(page).not_to have_text('John Smith')
    expect(page).to have_text('Anonymous')
    expect(page).to have_text('an undisclosed amount')
  end

  it 'lets the user put a custom donation amount & a custom at tip', js: true do
    family = create(:family)
    visit family_path(family)
    expect(page).to have_text('John Doe')
    click_link('Give to this Adoption')
    expect(page).to have_text('Donate to a Family')
    fill_in 'other_text', with: '$1234'
    fill_in 'tip_other_text', with: '56'
    within('.amount.tab-pane') { click_link('Next') }
    fill_in 'Name', with: 'John Smith'
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    within('.donation-info.tab-pane') { click_link('Next') }
    page.execute_script '$("#card_number").val("4242424242424242");'
    page.execute_script '$("#expiration_date").val("12/19");'
    page.execute_script '$("#security_code").val("123");'
    within('.new_donation') { click_button('Donate') }

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thank you for your donation!')
    expect(page).to have_text('$1,234')
    expect(page).to have_text('$56')
    expect(page).to have_text('$1,290')
  end

  it 'lets the user cancel their monthly donation', js: true do
    family = create(:family)
    visit family_path(family)
    expect(page).to have_text('John Doe')
    click_link('Give to this Adoption')
    expect(page).to have_text('Donate to a Family')
    page.find('label[for="donation_amount_100"]').click
    choose('10%')
    within('.amount.tab-pane') { click_link('Next') }
    fill_in 'Name', with: 'John Smith'
    fill_in 'Message', with: 'I hope you guys love your new child!'
    fill_in 'Email', with: 'hello@example.com'
    within('.donation-info.tab-pane') { click_link('Next') }
    # Masking messed with jquery Payment for some reason :/
    page.execute_script '$("#card_number").val("4242424242424242");'
    page.execute_script '$("#expiration_date").val("12/19");'
    page.execute_script '$("#security_code").val("123");'
    check('Make this a monthly donation. Each month you will bring this family closer to their goal.')
    within('.new_donation') { click_button('Donate') }

    expect(page).not_to have_text('Donate to a Family')
    expect(page).to have_text('Thank you for your donation!')
    expect(page).to have_text('Monthly Donation')
    within('.small.help-block') { click_link('cancel your monthly contribution') }
    expect(page).to have_text('Cancel Monthly Donation')
    click_button('Cancel Monthly Donation')
    expect(page).to have_text('Your donation has been updated.')
  end
end
