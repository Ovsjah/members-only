class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  class << self
    # Returns the hash digest of the given string.
    def digest(str)
      Digest::SHA1.hexdigest(str)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated?(type, token)
    digest = send("#{type}_digest")
    return false unless digest
    self.class.digest(token) == digest
  end

private

    def downcase_email
      email.downcase!
    end

    def remember
      self.remember_token = self.class.new_token
      update_attribute(:remember_digest, self.class.digest(remember_token))
    end

    def forget
      update_attribute(:remember_digest, nil)
    end
end
