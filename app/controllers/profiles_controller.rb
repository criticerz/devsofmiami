class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
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

    puts @profiles.first.inspect
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:username, :name, :company, :blog, :location, :hireable, :email, :bio, :public_repos, :public_gists, :followers, :following, :avatar_url)
    end
end
