class Admin::Base < ApplicationController
  # アクションの前に実行されるようにする。
  before_action :autholize
  before_action :check_account
  before_action :check_timeout

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

  # アカウントが無効にされていた場合強制ログアウト
  private def check_account
    if current_administrator && !current_administrator.active?
      session.delete(:administrator_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  # アクセス間隔が長い場合に強制ログアウト
  private def check_timeout
    if current_administrator
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      end
    end
  end
end