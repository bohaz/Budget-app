require 'rails_helper'

RSpec.describe Operation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }

    it 'is valid with valid attributes' do
      operation = build(:operation)
      expect(operation).to be_valid
    end

    it 'is not valid without a name' do
      operation = build(:operation, name: nil)
      expect(operation).not_to be_valid
    end

    it 'is not valid without an amount' do
      operation = build(:operation, amount: nil)
      expect(operation).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should belong_to(:group).optional }

    it 'can be created without a group' do
      operation = build(:operation, :without_group)
      expect(operation.group).to be_nil
    end

    it 'can be associated with a group' do
      group = create(:group)
      operation = build(:operation, group: group)
      expect(operation.group).to eq(group)
    end
  end
end
