class HomeController < ApplicationController
  def index

    @profiles = Profile.all

  end
end
