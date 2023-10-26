require 'rails_helper'

RSpec.feature "Group's index page", type: :feature do
  let(:user) { create(:user) }
  let!(:group1) { create(:group, user:) }
  let!(:group2) { create(:group, user:) }
  let!(:operation1) { create(:operation, author: user, group: group1, amount: 100) }
  let!(:operation2) { create(:operation, author: user, group: group2, amount: 200) }

  before do
    sign_in user
    visit groups_path
  end

  scenario 'displays the welcome message with user name' do
    expect(page).to have_content("Welcome, #{user.name}!")
  end

  scenario 'displays the total amount of operations' do
    total_amount = group1.operations.where(author: user).sum(:amount) + group2.operations.where(author: user).sum(:amount)
    expect(page).to have_content("Total Amount: $#{total_amount}")
  end

  scenario 'displays all the groups with their respective amounts' do
    [group1, group2].each do |group|
      amount = group.operations.where(author: user).sum(:amount)
      expect(page).to have_content(group.name)
      expect(page).to have_content("$#{amount}")
    end
  end

  scenario 'has a logout icon' do
    expect(page).to have_css('i.fas.fa-power-off')
  end

  scenario 'has a link to create a new group' do
    expect(page).to have_link('ADD A NEW CATEGORY', href: new_group_path)
  end
end
