require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      expect(user).not_to be_valid
    end

    it "is not valid if email is not unique" do
      create(:user, email: "test@example.com")
      user.email = "test@example.com"
      expect(user).not_to be_valid
    end
  end

  describe "associations" do
    it "has many operations" do
      association = described_class.reflect_on_association(:operations)
      expect(association.macro).to eq :has_many
    end

    it "has many groups" do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq :has_many
    end
  end

end
