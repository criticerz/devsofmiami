class StackProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile

  validates :display_name, uniqueness: true
end
