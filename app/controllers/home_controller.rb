class HomeController < ApplicationController
  def index

    if params[:language].present? 
      
      language = Language.find_by(slug: params[:language])
      @profiles = language.profiles.paginate(:page => (params[:page] || 1), :per_page => 100)

    else
      
      @profiles = Profile.paginate(:page => (params[:page] || 1), :per_page => 100)
      
    end

    @languages = Language.where('icon_class IS NOT NULL').order('name ASC')

  end
end
