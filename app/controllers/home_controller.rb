class HomeController < ApplicationController
  def index

    sort_columns = {
      'default' => 'latest_github_activity_at',
      'github-joined' => 'github_created_at',
      'github-followers' => 'followers'
    }

    params[:sort_order] = params[:sort_order] || 'desc'

    if params[:sort_by].present?
      order_by_string = "#{sort_columns[params[:sort_by]]} #{params[:sort_order].upcase}"
    else
      order_by_string = "#{sort_columns['default']} #{params[:sort_order].upcase}"
    end

    if params[:language].present? 
      
      language = Language.find_by(slug: params[:language])
      @profiles = language.profiles.includes([:code_wars_datum, :languages]).reorder(order_by_string).paginate(:page => (params[:page] || 1), :per_page => 100)

    elsif params[:username].present?

      @profiles = Profile.includes([:code_wars_datum, :languages]).search(params[:username]).reorder(order_by_string).paginate(:page => (params[:page] || 1), :per_page => 100)

    else
      
      @profiles = Profile.includes([:code_wars_datum, :languages]).reorder(order_by_string).paginate(:page => (params[:page] || 1), :per_page => 100)
      
    end

    @languages = Language.includes(:profiles).order('name ASC')

  end
end
