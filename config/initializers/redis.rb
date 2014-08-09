uri = URI.parse(Rails.env.production? ? ENV["REDISTOGO_URL"] : "http://localhost:6379")
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
