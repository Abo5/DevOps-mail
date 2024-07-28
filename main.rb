require 'net/http'
require 'json'
require 'mail'

# Email settings
options = {
  address: 'smtp.your-email-provider.com',
  port: 587,
  user_name: 'your-email@example.com',
  password: 'your-email-password',
  authentication: 'plain',
  enable_starttls_auto: true
}

Mail.defaults do
  delivery_method :smtp, options
end

# Fetching data from Prometheus
uri = URI('http://your-prometheus-server/api/v1/query?query=up')
response = Net::HTTP.get(uri)
result = JSON.parse(response)

# Setting up the email message
mail = Mail.new do
  from     'your-email@example.com'
  to       'recipient-email@example.com'
  subject  'Daily Report from Prometheus'
  body     "System Status:\n\n#{result['data']['result'].map { |r| "#{r['metric']['instance']}: #{r['value'][1]}" }.join("\n")}"
end

begin
  mail.deliver!
  puts "Email sent successfully"
rescue => e
  puts "Failed to send email. Reason: #{e.message}"
end
