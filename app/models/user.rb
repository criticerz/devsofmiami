class User < ActiveRecord::Base

  after_create :connect_user_with_profile

  def self.create_with_omniauth(auth)
    create! do |user|
      
      user.provider = auth['provider']
      user.uid = auth['uid']
      
      # create remember token
      user.create_remember_token

      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email ||= auth['info']['email']
         user.username = auth['info']['nickname']
      end
    end
  end

  def self.add_remember_token_to_all_users
    User.all.each do |user|
      user.create_remember_token
      user.save
    end
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  private

  def connect_user_with_profile
    profile = Profile.find_by(username: self.username)
    if profile.blank?
      # update_profile_data callback on profile should create rest
      profile = Profile.create(username: self.username, user_id: self.id)
    else
      profile.user_id = self.id
      profile.save
    end
  end

end
