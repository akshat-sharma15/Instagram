OmniAuth.config.on_failure = proc do |env|
  "Users::OmniauthCallbacksController".constantize.action(:failure).call(env)
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret
end
