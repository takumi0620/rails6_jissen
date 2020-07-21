class Admin::SessionsController < Admin::Base
  # アクションの前に実行されないようにする。
  skip_before_action :autholize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    if @form.email.present?
      admin_member = Administrator.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    if Admin::Authenticator.new(admin_member).authenticate(@form.password)
      if admin_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:administrator_id] = admin_member.id
        flash.notice = "ログインしました。"
        redirect_to :admin_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_root
  end

  private def login_form_params
    # requireメソッドはparamsに引数のキーがあるかチェックする。なければ実行時例外
    # permitはハッシュから引数で指定されたキー以外を除去して返却する。機能に不要なパラメータをユーザに見せないための考慮
    params.require(:admin_login_form).permit(:email, :password)
  end
end
