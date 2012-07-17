module LoginHelper
  def login_with_google_auth(company = FactoryGirl::create(:company))
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google, {
      :provider => "google",
      :info => {
        :email => "test@#{company.domain}"
      }
    })

    visit auth_google_callback_path
  end
end
