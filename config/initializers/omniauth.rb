require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "58461ec83b874d08a8bcd731b61e09a3", "7017d0574a0c4bf4b31f5dd68f072c13", scope: 'user-top-read user-read-email playlist-modify-public user-library-read user-library-modify'
end
