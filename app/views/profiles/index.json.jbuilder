json.profiles(@profiles) do |profile|
  json.extract! profile, :id, :username, :name, :company, :blog, :location, :hireable, :email, :bio, :public_repos, :public_gists, :followers, :following, :avatar_url
  json.languages(profile.languages) do |language|
    json.extract! language, :id, :name, :slug, :icon_class
  end
  json.url profile_url(profile, format: :json)
end
