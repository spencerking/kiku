require "option_parser"

require "mastodon"
require "colors"

url: String = ""
access_token: String = ""
src: String = "public"
config = false

OptionParser.parse! do |parser|
  parser.banner = "Usage kiku [arguments]"
  parser.on("-c", "--config", "Read from the config file") { config = true }
  parser.on("-i INSTANCE", "--instance=INSTANCE", "Specifies the instance url") { |instance| url = instance  }
  parser.on("-t TOKEN", "--token=TOKEN", "Specifies the token") { |token| access_token = token  }
  parser.on("-s SOURCE", "--source=SOURCE", "Specifies the content source") { |source| src = source }
  parser.on("-h", "--help", "Show help") { puts parser; exit }
end

if config == false
  if access_token == ""
    puts "Error! No access token specified."
    exit
  end

  if url == ""
    puts "Error! No instance url specified."
    exit
  end
end

client = Mastodon::Streaming::Client.new(url: url, access_token: access_token)

# Clear the screen
puts "\x1b[H\x1b[2J"

# TODO super gross, make not gross
if src == "user"
  client.user do |object|
    case object
    when Mastodon::Entities::Status
      puts "@".green + object.account.username.green + " " + object.account.display_name.green
      puts object.created_at.to_local.to_s.blue
      puts object.content.gsub(/<[^>]*>/) {}
      puts ""
    when Int32
      puts object
    else
      puts "test"
    end
  end
else
  client.public do |object|
    case object
    when Mastodon::Entities::Status
      puts "@".green + object.account.username.green + " " + object.account.display_name.green
      puts object.created_at.to_local.to_s.blue
      puts object.content.gsub(/<[^>]*>/) {}
      puts ""
    when Int32
      puts object
    else
      puts "test"
    end
  end
end
