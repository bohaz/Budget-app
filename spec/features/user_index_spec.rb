require 'rails_helper'

RSpec.feature "User's index page", type: :feature do
  before do
    visit root_path
  end

  scenario 'displays the main header' do
    expect(page).to have_content('TransactTrends')
  end

  scenario 'has a log in button' do
    expect(page).to have_link('LOG IN', href: new_user_session_path)
  end

  scenario 'has a sign up button' do
    expect(page).to have_link('SIGN UP', href: new_user_registration_path)
  end
end
