require 'rails_helper'

RSpec.feature "Operations' index page", type: :feature do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let!(:operations) { create_list(:operation, 3, group: group, author: user) }

  before do
    sign_in user
    visit group_operations_path(group)
  end
  
  scenario 'displays the group name in title' do
    expect(page).to have_content("Operations for #{group.name}")
  end

  scenario 'has a back link' do
    expect(page).to have_css('i.fa-arrow-left')
  end

  scenario 'shows total amount for the group' do
    total_amount = operations.sum(&:amount)
    expect(page).to have_content("Total Amount for #{group.name} : $#{total_amount}")
  end

  scenario 'lists all operations' do
    operations.each do |operation|
      expect(page).to have_content("$#{operation.amount}")
    end
  end
  
  scenario 'has a link to add new operation' do
    expect(page).to have_link('ADD A NEW TRANSACTION', href: new_group_operation_path(group))
  end
  
end
