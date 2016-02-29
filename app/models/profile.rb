class Profile < ActiveRecord::Base
  has_many :profile_languages
  has_many :languages, through: :profile_languages

  default_scope { order('latest_github_activity_at IS NULL, latest_github_activity_at DESC') }

  scope :search, -> (username) { where("username like ?", "#{username}%")}

  # has_many :visible_languages, through: :profile_languages, class_name: 'Language'

  has_one :code_wars_datum

  validates :username, uniqueness: true

  @@client = ENV['DEV_GITHUB_CLIENT']
  @@secret = ENV['DEV_GITHUB_SECRET']

  def self.create_from_github
    sort_options = ['followers', 'joined', 'repositories']
    directions = ['asc', 'desc']
    
    page = 1
    directions.each do |direction|
      sort_options.each do |option|
        while page < 11
          response = HTTParty.get(URI.encode("https://api.github.com/search/users?q=+location:Miami&per_page=100&page=#{page}&sort=#{option}&order=#{direction}&client_id=#{@@client}&client_secret=#{@@secret}"))

          response.each do |user|
            begin
              user[1].each do |u|
                p "usernames: #{u['login']}"
                profile = Profile.where(username: u['login']).first_or_create
              end
            rescue => e
              p "there was an error: #{e}"
            end
          end
          page += 1
        end
      end
    end
  end

  def self.update_from_github
    Profile.find_each do |profile|
      begin
        # next if profile.id < 100
        username = profile.username
        response = HTTParty.get(URI.encode("https://api.github.com/users/#{username}?client_id=#{@@client}&client_secret=#{@@secret}"))
        
        p "response: #{response.inspect}"
        
        unless response['login'].blank?
          p response['login']
          profile.avatar_url = response['avatar_url']
          profile.hireable = response['hireable']
          profile.company = response['company']
          profile.bio = response['bio']
          profile.public_repos = response['public_repos']
          profile.public_gists = response['public_gists']
          profile.followers = response['followers']
          profile.following = response['following']
          profile.location = response['location']
          profile.github_created_at = response['created_at']
          profile.save
        else
          next
        end

      rescue => e
        p "there was an error: #{e}"
      end
    end
  end
end
