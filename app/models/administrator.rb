class Administrator < ApplicationRecord
  has_secure_token
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  # TODO: This method should extract to mixin method.
  def regenerate_token
    random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    self.update_attribute(:token, random_string)
  end
end
