class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.all.order('created_at DESC').page(params[:page]).per(10)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end
end
