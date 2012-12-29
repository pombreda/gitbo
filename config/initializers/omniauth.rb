Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, CONFIG[:github_client_id], CONFIG[:github_client_secret],
  scope: "user, public_repo"
end
