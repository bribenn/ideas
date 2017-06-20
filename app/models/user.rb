class User < ActiveRecord::Base
  has_secure_password
  validates :name, :alias, :email, :password, presence: true
  validates :password, length: { minimum: 8 }
  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea
end
