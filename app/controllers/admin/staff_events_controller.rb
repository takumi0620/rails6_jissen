class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events
    else
      @events = StaffEvent
    end
    # includesメソッドに関連付けの名前を与えると関連づけられたモデルオブジェクトを一括して取得してくれる。in句を使用して持ってくる。
    # pageメソッドはkaminariが提供しているもの
    @events = @events.order(occurred_at: :desc).includes(:member).page(params[:page])
  end
end
