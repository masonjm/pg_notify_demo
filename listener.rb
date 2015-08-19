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

# The channel name to use for notification
CHANNEL = "PG_NOTIFY_DEMO"

# Register this connection as a listener for the channel
connection.execute("LISTEN #{CHANNEL}")

# The ActiveRecord API doesn't expose the methods we need, so we drop down to
# the API provided by the PG gem.
pg_connection = connection.raw_connection

loop do
  # Notification are asynchronous, so this just waits until one comes in
  pg_connection.wait_for_notify do |channel, pid, data|
    puts "Listener #{Process.pid}: Received #{data} on #{channel} from "\
         "postgres connection #{pid}"
  end
end
