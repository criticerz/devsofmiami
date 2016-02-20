require 'httparty'

task :create_profiles => :environment do
  i = 0
  response = HTTParty.get(URI.encode("https://api.github.com/search/users?q=+location:Miami&per_page=100&page=1"))
  p "count: #{response.length}"
  response.each do |user|

    begin
      p user[1].count
      p "users: #{user[1]}"
      user[1].each do |u|
        p "usernames: #{u['login']}"
        profile = Profile.create!(username: u['login'])
      end
    rescue => e
      p "there was an error: #{e}"
    end
  end
end

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
    rescue => e
      p "there was an error: #{e}"
    end
  end
end

task :update_languages => :environment do
  client = ENV['DEV_GITHUB_CLIENT']
  secret = ENV['DEV_GITHUB_SECRET']
  Profile.find_each do |profile|
    begin
      username = profile.username
      response = HTTParty.get("https://api.github.com/users/#{username}/repos?client_id=#{client}&client_secret=#{secret}")
      
      parsed_response = JSON.parse(response.body)
      if parsed_response[0]
        language = parsed_response[0]['language']
        unless language.blank?
          find_language = Language.where(name: language).first_or_create()
          p find_language
          profile_language = ProfileLanguage.create(profile_id: profile.id, language_id: find_language.id)
        end
      end
    rescue => e
      p "An error occurred: #{e}"
    end
  end
end



