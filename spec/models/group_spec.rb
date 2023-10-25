require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { FactoryBot.create(:group) }

  it 'is valid with valid attributes' do
    expect(group).to be_valid
  end

  it 'is not valid without a name' do
    group.name = nil
    expect(group).to_not be_valid
  end

  it 'is not valid without an icon' do
    group.icon = nil
    expect(group).to_not be_valid
  end

  it 'belongs to a user' do
    expect(group.user).to be_present
  end

  it 'can have many operations' do
    operation1 = FactoryBot.create(:operation, group: group) 
    operation2 = FactoryBot.create(:operation, group: group)
    
    expect(group.operations).to include(operation1, operation2)
  end
end
