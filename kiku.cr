require "mastodon"

client = Mastodon::Streaming::Client.new(url: "INSTANCE NAME HERE", access_token: "ACCESS TOKEN HERE")

client.public do |object|
  case object
  when Mastodon::Entities::Status
  	puts object.account.username + " " + object.account.display_name
  	puts object.created_at.to_local
    puts object.content.gsub(/<[^>]*>/) {}
    puts ""
  when Int32
    puts object
  end
end