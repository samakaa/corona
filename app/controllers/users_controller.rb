class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
@uu=User.all.order(:confirmed)
    @conf=User.sum(:confirmed)
    @reco=User.sum(:recovered)
    @death=User.sum(:death)
   @users = User.all.order(confirmed: :desc )
   @map_hash = Gmaps4rails.build_markers(@users) do |user, marker|
     user_path = view_context.link_to user.name, user_path(user)
 marker.lat user.latitude
 marker.lng user.longitude
 marker.infowindow "<b>#{user_path}<br>Confirmed: #{user.confirmed}<br>Recovered: #{user.recovered}
 <br>death:#{user.death} </b>"
   end
 end

  # GET /users/1
  # GET /users/1.json
  def show
  #  require 'uri'
  #  require 'net/http'
  #  require 'openssl'

  #  url = URI("https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=Canada")

  #  http = Net::HTTP.new(url.host, url.port)
  #  http.use_ssl = true
  #  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #  request = Net::HTTP::Get.new(url)
  #  request["x-rapidapi-host"] = 'covid-19-coronavirus-statistics.p.rapidapi.com'
  #  request["x-rapidapi-key"] = '538c3f3ed9msh9c8171d606a7d2cp120627jsnd293888a70a3'

  #  response = http.request(request)
#@res= response.read_body
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:latidute, :longitude, :name, :address, :confirmed, :recovered, :death)
    end
end
