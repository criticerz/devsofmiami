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