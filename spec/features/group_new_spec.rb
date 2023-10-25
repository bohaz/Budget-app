require 'rails_helper'

RSpec.feature "Group's new page", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_group_path
  end

  scenario 'displays the title' do
    expect(page).to have_content('Add a new category')
  end

  scenario 'has a back link' do
    expect(page).to have_css('i.fa-arrow-left')
  end

  scenario 'has a category name field' do
    expect(page).to have_field('Category Name')
  end

  scenario 'has a select field for icon' do
    expect(page).to have_select('group_icon', with_options: %w[Car Bicycle Bus])
  end

  scenario 'has an add category button' do
    expect(page).to have_button('ADD CATEGORY')
  end

  scenario 'creates a new group when form is filled out correctly' do
    fill_in 'Category Name', with: 'Test Category'
    select 'Car', from: 'group_icon'

    click_on 'ADD CATEGORY'

    expect(page).to have_content('Test Category')
    expect(Group.last.name).to eq('Test Category')
    expect(Group.last.icon).to eq('fas fa-car')
  end
end
