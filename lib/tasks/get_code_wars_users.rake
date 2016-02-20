require 'httparty'

desc "Get users from code wars"
task get_code_wars_users: :environment do
  Profile.all.each do |profile|
    response = HTTParty.get("https://www.codewars.com/api/v1/users/#{profile.username}").to_json
    parsed_response = JSON.parse(response)

    CodeWarsDatum.where(username: profile.username).first_or_create(username: parsed_response["username"], honor: parsed_response["honor"], languages: parsed_response["ranks"]["languages"].keys, challenges_completed: parsed_response["codeChallenges"]["totalCompleted"])
  end
end
