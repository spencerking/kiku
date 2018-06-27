require "mastodon"
require "colors"

client = Mastodon::Streaming::Client.new(url: "INSTANCE NAME HERE", access_token: "ACCESS TOKEN HERE")

client.public do |object|
  case object
  when Mastodon::Entities::Status
  	puts "@".green + object.account.username.green + " " + object.account.display_name.green
  	puts object.created_at.to_local.to_s.blue
    puts object.content.gsub(/<[^>]*>/) {}
    puts ""
  when Int32
    puts object
  end
end