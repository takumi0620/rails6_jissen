class StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occured_at, to: :object

  def table_row
    markup(:tr) do |m|
      # erbの下記記述の代わりとなる
      # <% unless @staff_member %>
      #   <td>
      #     <%= link_to(event.member.family_name + event.member.given_name, [ :admin, event.member, :staff_events ]) %>
      #   </td>
      # <% end %>
      unless view_context.instance_variable_get(:@staff_member) # instance_variable_getレシーバが持っているインスタンス変数の値を取得するメソッド
        m.td do
          m << link_to(member.family_name + member.given_name, [ :admin, member, :staff_events ])
        end
      end

      # erbの下記記述の代わりとなる
      # <td><%= event.description %></td>
      # <td class="date">
      #   <%= event.occurred_at.strftime("%Y/%m/%d %H:%M:%S") %>
      # </td>
      m.td description
      m.td(:class => "date") do
        m.text occured_at.strftime("%Y/%m/%d %H:%M:%S")
      end
    end
  end
end