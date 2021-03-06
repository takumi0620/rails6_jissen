class ApplicationController < ActionController::Base
  layout :set_layout # レイアウトを行うためのメソッドを指定

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private def set_layout
    # paramsオブジェクトを返却
    # params[:controller]で現在選択されているコントローラの名前を取得できる。
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      "customer"
    end
  end
end
