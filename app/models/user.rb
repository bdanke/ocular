class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :bday, :gender, :password, :profile_id
  attr_reader :password
  validates :email, :fname, :lname, presence: true
  validates :bday, :gender, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank!" }
  validates :email, uniqueness: true
  validates :email, email: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :gender, inclusion: { in: %w(m f) }
  validates_date :bday

  after_initialize :ensure_session_token

  has_many(
  :in_friendships,
  class_name: "Friendship",
  foreign_key: :out_friend_id,
  primary_key: :id)

  has_many(
  :out_friendships,
  class_name: "Friendship",
  foreign_key: :in_friend_id,
  primary_key: :id)

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def name
    self.fname + " " + self.lname
  end

  def friends
    friends = []
    in_friend_ids = (self.in_friendships.select { |friendship| friendship.pending_flag == false }).map { |friendship| friendship.in_friend_id }
    out_friend_ids = (self.out_friendships.select { |friendship| friendship.pending_flag == false }).map { |friendship| friendship.out_friend_id }
    in_friend_ids.concat(out_friend_ids).each do |id|
      friends << User.find(id)
    end
    friends
  end

  def pending_request_friends
    pending_friends = []
    in_friend_ids = (self.in_friendships.select { |friendship| friendship.pending_flag == true }).map { |friendship| friendship.in_friend_id }
    in_friend_ids.each do |id|
      pending_friends << User.find(id)
    end
    pending_friends
  end

  def pending_friends
    pending_friends = []
    out_friend_ids = (self.out_friendships.select { |friendship| friendship.pending_flag == true }).map { |friendship| friendship.out_friend_id }
    out_friend_ids.each do |id|
      pending_friends << User.find(id)
    end
    pending_friends
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end