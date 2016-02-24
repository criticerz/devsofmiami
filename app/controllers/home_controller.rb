class HomeController < ApplicationController
  def index

    if params[:language].present? 
      
      language = Language.find_by(slug: params[:language])
      @profiles = language.profiles.includes([:code_wars_datum, :languages]).paginate(:page => (params[:page] || 1), :per_page => 100)

    else
      
      @profiles = Profile.includes([:code_wars_datum, :languages]).paginate(:page => (params[:page] || 1), :per_page => 100)
      
    end

    @languages = Language.includes(:profiles).where('icon_class IS NOT NULL').order('name ASC')

  end
end
