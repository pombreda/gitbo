Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '6d51403ac6d796c9b2c3', 'f5ed8a390f33a28b01bc925334a3caa205e212d0',
  scope: "user, repo, issues"
  
end
