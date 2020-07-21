class Admin::Base < ApplicationController
  # アクションの前に実行されるようにする。
  before_action :autholize

  helper_method :current_administrator

  private def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
    end
  end

  private def autholize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end
end