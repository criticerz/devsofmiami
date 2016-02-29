class User < ActiveRecord::Base

  after_create :connect_user_with_profile

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email ||= auth['info']['email']
         user.username = auth['info']['nickname']
      end
    end
  end

  private
  def connect_user_with_profile
    profile = Profile.find_by(username: self.username)
    profile.user_id = self.id
    profile.save
  end

end
