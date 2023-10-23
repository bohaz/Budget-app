class Group < ApplicationRecord
  has_many :operations
  
  validates :name, presence: true
  validates :icon, presence: true
  validates :created_at, presence: true
end
