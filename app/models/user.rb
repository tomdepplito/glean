class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password, if: :password
  validates :password, presence:     true,
            confirmation: { message: 'Password/Password Confirmation do not match.' },
            length: { :minimum => 8 },
            if:           :password
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  private

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end
