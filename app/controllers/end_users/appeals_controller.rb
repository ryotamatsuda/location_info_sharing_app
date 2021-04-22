class EndUsers::AppealsController < ApplicationController

  before_action :authenticate_end_user!

  def index
    @latest_appeals = current_end_user.following_user_appeals.order(date_and_time: "DESC").limit(5)
    gon.latest_appeal_comments = Array.new
    gon.latest_appeal_lat_and_lon = Array.new(5).map{Array.new(2,0)}
    @latest_appeals.each_with_index do |appeal, index|
      gon.latest_appeal_comments << appeal.comment
      gon.latest_appeal_lat_and_lon[index][0] = appeal.latitude
      gon.latest_appeal_lat_and_lon[index][1] = appeal.longitude
    end
  end

  def new
    @new_appeal = Appeal.new
    gon.from = 0
  end

  def create
    @new_appeal = Appeal.new(appeal_params)
    @new_appeal.end_user_id = current_end_user.id
    if @new_appeal.save
      flash[:notice] = 'アピールを投稿しました'
      redirect_to appeals_path
    else
      if @new_appeal.latitude == nil || @new_appeal.longitude == nil
        gon.from = 0
        @new_appeal.add_lat_and_lon_error_message
      else
        gon.from = 1
        gon.new_appeal_lat = @new_appeal.latitude
        gon.new_appeal_log = @new_appeal.longitude
      end
      render :new
    end
  end

  private
  def appeal_params
    params.require(:appeal).permit(:comment, :date_and_time, :latitude, :longitude)
  end
end
