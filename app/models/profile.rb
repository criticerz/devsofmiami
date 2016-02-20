class Profile < ActiveRecord::Base
  has_many :profile_languages
  has_many :languages, through: :profile_languages

  validates :username, uniqueness: true
end
