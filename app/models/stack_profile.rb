class StackProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile

  validates :display_name, uniqueness: true

  STACK_CLIENT_ID = ENV['STACK_CLIENT_ID']
  STACK_CLIENT_SECRET = ENV['STACK_CLIENT_SECRET']
  STACK_KEY = ENV['STACK_KEY']

  # https://api.stackexchange.com/docs/authentication
  # https://api.stackexchange.com/docs/js-lib
  
end
