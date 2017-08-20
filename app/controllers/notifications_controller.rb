class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.all.order('created_at DESC').page(params[:page]).per(10)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def follow_link_through
    @notification = Notification.find(params[:id])
    notified_by = User.find(@notification.notified_by_id)
    @notification.update(read: true)
    redirect_to profile_path(notified_by.user_name)
  end
  
end
