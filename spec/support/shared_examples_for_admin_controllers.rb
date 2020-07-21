shared_examples "a protected admin controller" do |controller|
  let(:args) do
    {
      host: Rails.application.config.baukis2[:admin][:host],
      controller: controller
    }
  end

  describe "#index" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :index))
      expect()
    end
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :show, id: 1))
      expect(responce).to redirect_to(admin_login_url)
    end
  end
end

shared_examples "a protected singular admin contoller" do |contoller|
  let(:args) do
    {
      host: Rails.application.config.baukis2[:admin][:host],
      contoller: controller
    }
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do

    end
  end
end