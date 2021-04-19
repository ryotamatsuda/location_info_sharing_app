class EndUsers::RelationshipsController < ApplicationController
  def create
    @end_user = EndUser.find(params[:followed_end_user_id])
    current_end_user.follow(@end_user.id)
  end
  def destroy
    @end_user = EndUser.find(params[:unfollowed_end_user_id])
    current_end_user.unfollow(@end_user.id)
  end
end
