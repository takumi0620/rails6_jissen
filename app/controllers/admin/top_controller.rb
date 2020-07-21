class Admin::TopController < Admin::Base
  # アクションの前に実行されないようにする。
  skip_before_action :autholize

  def index
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end
