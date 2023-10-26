class Group < ApplicationRecord
  belongs_to :user
  has_many :operations

  validates :name, presence: true
  validates :icon, presence: true
end
