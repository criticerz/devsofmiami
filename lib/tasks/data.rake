require 'httparty'
require 'csv'

task :create_profiles => :environment do
  i = 0
  page = 1
  while page < 20
    response = HTTParty.get(URI.encode("https://api.github.com/search/users?q=+location:Miami&per_page=100&page=#{page}"))
    p "count: #{response.length}"
    response.each do |user|
      begin
        p user[1].count
        p "users: #{user[1]}"
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

task :update_profiles => :environment do
  client = ENV['DEV_GITHUB_CLIENT']
  secret = ENV['DEV_GITHUB_SECRET']
  Profile.find_each do |profile|
    begin
      # next if profile.id < 100
      username = profile.username
      response = HTTParty.get(URI.encode("https://api.github.com/users/#{username}?client_id=#{client}&client_secret=#{secret}"))
      p "response: #{response.inspect}"
      profile = Profile.where(username: username).last
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
        profile.save
      else
        next
      end
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
      
      repos = JSON.parse(response.body)

      repos.each do |repo|

        language = repo['language']

        unless language.blank?
          find_language = Language.where(name: language).first_or_create()
          profile_language = ProfileLanguage.where(profile_id: profile.id, language_id: find_language.id).first_or_create
          puts "added language"
        end

      end

    rescue => e
      p "An error occurred: #{e}"
    end
  end
end

task :import_stack_data => :environment do
  # we can automate getting this data later
  CSV.foreach('QueryResults.csv', :headers => true) do |row|
    begin
      p row["DisplayName"] + ": " + row["Reputation"]
      display_name = row["DisplayName"]
      reputation = row["Reputation"].to_i
      location = row["Location"]
      StackProfile.create!(display_name: display_name, reputation: reputation, location: location)
    rescue => e
      p "an error occurred: #{e}"
    end
  end
end

task :find_matches => :environment do
  Profile.find_each do |profile|
    match_name = StackProfile.where(display_name: profile.name)
    match_username = StackProfile.where(display_name: profile.username)
    if match_name.length == 1
      p "display name: #{match_name.last.display_name}"
      p "profile name: #{profile.name}"
      match_name.last.profile_id = profile.id
      match_name.last.save
    elsif match_username.length == 1
      p "display name: #{match_username.last.display_name}"
      p "profile name: #{profile.username}"
      match_username.last.profile_id = profile.id
      match_username.last.save
    end
  end
end



