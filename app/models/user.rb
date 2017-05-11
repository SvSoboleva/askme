require 'openssl'

class User < ApplicationRecord
  attr_accessor :password

  has_many :questions, dependent: :destroy

  #параметры для паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :username, with: /\A\w+\Z/i, message: 'Используйте только латинские буквы, цифры и _'
  validates_length_of :username, maximum: 40

  before_save :encrypt_password

  before_validation :username_downcase

  def username_downcase
    self.username.downcase!
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end

