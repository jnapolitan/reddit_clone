class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates_uniqueness_of :username, case_sensitive: false
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  attr_reader :password

  has_many :subs,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :Sub,
    inverse_of: :moderator

  has_many :posts,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :Post,
    inverse_of: :author

  has_many :comments,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :Comment,
    inverse_of: :author

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
end
