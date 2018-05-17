require 'analytics-ruby'

$analytics = Segment::Analytics.new(write_key: ENV["ANALYTICS_WRITE_KEY"])