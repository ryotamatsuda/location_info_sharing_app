class EndUsers::EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  def recommend
  end

  def search
  end

  def show
    @end_user = EndUser.find(params[:id])
    gon.latest_appeal_comments = Array.new
    gon.latest_appeal_lat_and_lon = Array.new(5).map{Array.new(2,0)}
    @end_user.appeals.each_with_index do |appeal, index|
      gon.latest_appeal_comments << appeal.comment
      gon.latest_appeal_lat_and_lon[index][0] = appeal.latitude
      gon.latest_appeal_lat_and_lon[index][1] = appeal.longitude
    end
  end

  def follow_index
  end

  def follower_index
  end

end
