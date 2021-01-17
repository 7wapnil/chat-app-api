class User < ApplicationRecord
  has_secure_password
  has_many :participants
  has_many :conversations, through: :participants
  has_many :messages

  def full_name
    "#{first_name} #{last_name}"
  end
end
