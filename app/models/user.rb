class User < ApplicationRecord
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password) 
    user = User.find_by_email(email)
    if user && user.authenticate(password) 
      return user
    else 
      return nil  
    end
  end
end
