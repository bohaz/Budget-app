require 'rails_helper'

RSpec.feature "New Operation page", type: :feature do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }

  before do
    sign_in user
    visit new_group_operation_path(group)
  end
  
  scenario 'displays the title' do
    expect(page).to have_content('Add a New Transaction')
  end
  
  scenario 'has a back link' do
    expect(page).to have_css('i.fa-arrow-left')
  end
  
  scenario 'displays transaction name input' do
    expect(page).to have_field('Transaction Name', type: 'text')
  end
  
  scenario 'displays amount input' do
    expect(page).to have_field('Amount', type: 'number')
  end
  
  scenario 'has a save button' do
    expect(page).to have_button('SAVE')
  end

end
