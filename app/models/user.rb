class User < ActiveRecord::Base
  has_one :news_feed

  validates_presence_of :news_feed
  validates_associated :news_feed
  validates :email, 
    :presence => true, 
    :uniqueness => true,
    :format => /[\w._%+-]+@[\w._%+-]+\.\w+/
  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_accessor :password
  attr_accessor :feed_url
  validate :password_must_be_present

  def User.authenticate(email, password)
    if user = find_by_email(email)
      if user.hashed_password == encrypt_password(password, user.salt)
        return user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'wombat' + salt)
  end

  def feed_url=(feed_url)
    if feed_url.present?
      feed = NewsFeed.new
      feed.feed_url = feed_url
      self.news_feed = feed
      if !feed.save
        errors.add(:feed_url, "Feed url invalid") 
      end
    end
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private
    def password_must_be_present
      errors.add(:password, "Password missing") unless hashed_password.present?
    end


    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
