require "bundler"
require "active_record"

# Disable output buffering. See:
# https://github.com/ddollar/foreman/wiki/Missing-Output
$stdout.sync = true

# Configure database connection
ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  user:    "pg_notify_demo",
  )
connection = ActiveRecord::Base.connection

# The name of the channel to broadcast on
CHANNEL = "PG_NOTIFY_DEMO"

loop do
  # Some data to send on the channel
  pid = Process.pid
  data = "#{pid}-#{Time.now.iso8601}"

  puts "Notifier #{pid}: sending #{data}"

  # Send the data over the channel
  connection.execute("NOTIFY #{CHANNEL}, '#{data}'")

  # Don't flood the channel
  sleep 1
end
