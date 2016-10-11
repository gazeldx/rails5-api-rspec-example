class Agent < ApplicationRecord
  has_secure_token
  has_secure_password

  has_many :tickets

  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  def regenerate_token
    random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    self.update_attribute(:token, random_string)
  end
end
