class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :gender, :password, :profile_id
  attr_reader :password
  validates :email, :fname, :lname, presence: true
  validates :gender, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank!" }
  validates :email, uniqueness: true
  validates :email, email: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :gender, inclusion: { in: %w(m f) }

  after_initialize :ensure_session_token

  has_one(
  :profile,
  class_name: "Profile",
  foreign_key: :owner_id,
  primary_key: :id)

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

  has_many(
  :statuses,
  class_name: "Status",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :likes,
  class_name: "Like",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :comments,
  class_name: "Comment",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :albums,
  class_name: "Album",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
  :photos,
  class_name: "Photo",
  foreign_key: :owner_id,
  primary_key: :id)

  has_many(
    :taggings,
    class_name: "Tag",
    foreign_key: :user_id,
    primary_key: :id)

  has_many(
  :out_message_threads,
  class_name: "MessageThread",
  foreign_key: :sender_id,
  primary_key: :id)

  has_many(
  :in_message_threads,
  class_name: "MessageThread",
  foreign_key: :recipient_id,
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
    in_friend_ids = (self.in_friendships.select { |friendship| friendship.pending_flag == "F" }).map { |friendship| friendship.in_friend_id }
    out_friend_ids = (self.out_friendships.select { |friendship| friendship.pending_flag == "F" }).map { |friendship| friendship.out_friend_id }
    in_friend_ids.concat(out_friend_ids).each do |id|
      friends << User.find(id)
    end
    friends
  end

  def pending_request_friends
    pending_friends = []
    in_friend_ids = (self.in_friendships.select { |friendship| friendship.pending_flag == "T" }).map { |friendship| friendship.in_friend_id }
    in_friend_ids.each do |id|
      pending_friends << User.find(id)
    end
    pending_friends
  end

  def pending_friends
    pending_friends = []
    out_friend_ids = (self.out_friendships.select { |friendship| friendship.pending_flag == "T" }).map { |friendship| friendship.out_friend_id }
    out_friend_ids.each do |id|
      pending_friends << User.find(id)
    end
    pending_friends
  end

  def newsfeed_statuses
    select_query = "owner_id = #{self.id}"
    self.friends.each do |friend|
      select_query += " OR wall_user_id = #{friend.id}"
    end
    query = <<-END
    SELECT *
    FROM statuses
    WHERE #{select_query}
    ORDER BY created_at DESC LIMIT 25
    END
    Status.find_by_sql(query)
  end

  def newsfeed_notifications
    select_array = []
    friends = self.friends
    unless friends.empty?
      friends.each do |friend|
        select_array << " user_id = #{friend.id}"
      end
      select_query = select_array.join(" OR")
      query = <<-END
      SELECT *
      FROM notifications
      WHERE #{select_query}
      ORDER BY created_at DESC LIMIT 25
      END
      return Notification.find_by_sql(query)
    end
    []
  end

  def newsfeed_data
    statuses = self.newsfeed_statuses
    notifications = self.newsfeed_notifications
    together = statuses.concat(notifications)
    together.sort! { |a,b| b.created_at <=> a.created_at }
  end

  def wall_posts
    query = <<-END
    SELECT *
    FROM statuses
    WHERE wall_user_id = #{self.id} LIMIT 25
    END
    Status.find_by_sql(query)
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end