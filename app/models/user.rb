class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :operations, foreign_key: 'author_id'
  has_many :groups
  validates :name, presence: true
  validate :name_should_have_at_least_two_words

  private

  def name_should_have_at_least_two_words
    errors.add(:name, "should have at least two words") if name && name.split.count < 2
  end  
end
