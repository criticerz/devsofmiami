require 'httparty'
# require 'uri'
task :create_profiles => :environment do
  i = 0
  response = HTTParty.get(URI.encode("https://api.github.com/search/users?q=+location:Miami&per_page=100&page=1"))
  # response = HTTParty.get("https://api.github.com/user/repos?page=3&per_page=100?q=+location:Miami")
  p "count: #{response.length}"
  response.each do |user|

    begin
      p user[1].count
      p "users: #{user[1]}"
      user[1].each do |u|
        # p "u.inspect"
        p "usernames: #{u['login']}"
        profile = Profile.create!(username: u['login'])
        # p "name: #{u['name']}"
        # p "company: #{u['company']}"
        # p "blog: #{u['blog']}"
        # p "location: #{u['location']}"
        # p "email: #{u['email']}"
        # profile = Profile.create!(username: u['login'], )
      end
      # p "user: #{user[1][0]['login']}"    
    rescue => e
      p "there was an error: #{e}"
    end
  end
end

# client_id: 375c84879ebf62fbd53d
# client_secret: 06063a17ab8290116377f9436f0337a5d6710a9d

task :update_profiles => :environment do
  client = ENV['DEV_GITHUB_CLIENT']
  secret = ENV['DEV_GITHUB_SECRET']
  Profile.find_each do |profile|
    begin
      username = profile.username
      response = HTTParty.get(URI.encode("https://api.github.com/users/#{username}?client_id=#{client}&client_secret=#{secret}"))
      profile = Profile.where(username: username).last
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
      profile.save

      # response.each do |u|
      #   p "u: #{u[0]} #{u[1]}"
      #   github_profile = Profile.where(username: username)
      #   case u[0] 
      #   when 'login'
      #     username = u[1]
      #     p "username: #{username}"
      #   when 'public_repos'
      #     public_repos = u[1]
      #     github_profile.public_repose = public_repos
      #     github_profile.save
      #     p "public_repos: #{public_repos}"
      #   when 'location'
      #     location = u[1]
      #     github_profile.location = location
      #     github_profile.save
      #   when 'avatar_url'
      #     # avatar_url = u[1]
      #     # github_profile.avatar_url = avatar_url
      #     # github_profile.save
      #   when 'hireable'
      #     hireable = u[1]
      #     github_profile.hireable = hireable
      #     github_profile.save
      #   when 'company'
      #     # company = u[1]
      #     # github_profile.company
      #     # github_profile.save
      #   when 'bio'
      #     bio = u[1]
      #     github_profile.bio
      #     github_profile.save
      #   when 'public_repos'
      #     public_repos = u[1]
      #     github_profile.public_repos
      #     github_profile.save
      #   when 'public_gists'
      #     public_gists = u[1]
      #     github_profile.public_gists
      #     github_profile.save
      #   when 'followers'
      #     followers = u[1]
      #     github_profile.followers = followers
      #     github_profile.save

      #   when 'following'
      #     following = u[1]
      #     github_profile.following = following
      #     github_profile.save
      #   when 'created_at'
      #     github_created_at = u[1]
      #     github_profile.github_created_at = github_created_at
      #     github_profile.save
      #   end
      # end

    rescue => e
      p "there was an error: #{e}"
    end
  end
end