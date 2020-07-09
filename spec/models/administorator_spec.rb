require "rails_helper"

RSpec.describe Administrator, type: :model do
  describe "#password=" do
    example "文字列を与えるとhashed_passwordは長さ60の文字列になる" do
      admin = Administrator.new
      admin.password = "hoge"
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    example "nilを与えるとhasehd_passwordはnilになる" do
      admin = Administrator.new
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end