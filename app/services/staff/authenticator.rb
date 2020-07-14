class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
    @staff_member.hashed_password &&
    @staff_member.start_date <= Date.today &&
    (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
    # ↓の==は演算子ではなくBCryptのインスタンスメソッド 引数（今回だとraw_password）をハッシュ化して比較する
    BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end