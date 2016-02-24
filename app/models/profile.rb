class Profile < ActiveRecord::Base
  has_many :profile_languages
  has_many :languages, through: :profile_languages

  # has_many :visible_languages, through: :profile_languages, class_name: 'Language'

  has_one :code_wars_datum

  validates :username, uniqueness: true
end
