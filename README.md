# DevOps-mail
Applying the Script in a DevOps Environment : Alerts and Monitoring, Daily Reports, Documentation and Review using ``Ruby`` script

### Applying the Script in a DevOps Environment

**Alerts and Monitoring:**

- The ``Ruby`` script can be used to send daily reports on the system's status, such as resource usage, service health, and application performance.
- It can be integrated with monitoring tools like Prometheus or Nagios to automatically send alerts when issues occur.

**Daily Reports:**

- Send reports on deployments, building new versions of the application, and quality tests.
- It can send summaries of Continuous Integration (CI) and Continuous Delivery (CD) statuses using tools like Jenkins or GitLab CI/CD.

**Documentation and Review:**

- Daily documentation reports can be sent to team members about the activities performed and any issues encountered.
- It helps in tracking and reviewing changes happening in the infrastructure or applications.

### Example of Using the Script to Send a Report from Jenkins

If you are using Jenkins, you can set up a job to run the script after each build or deployment and send a status report.

#### Setting Up a Jenkins Job to Run the Script

**Creating a New Job:**

- Open Jenkins and create a new project (Freestyle Project).
- In the "Build" section, add a new "Execute Shell" step.

**Adding the Script:**

- In "Execute Shell," add the command to run your script:
  ```sh
  ruby /path/to/your/send_report.rb
  ```

**Running the Job After Each Build:**

- You can set up a trigger to build the project automatically after each code change, or schedule a build to run the job daily.

### Integrating the Script with Other Monitoring Tools

You can modify the script to fetch data from monitoring tools like Prometheus or Nagios and send it as part of the report.

#### Example of Fetching Data from Prometheus

```ruby
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
```

By following these steps, you can use the script as part of DevOps tasks, contributing to automation, enhanced monitoring, and better flow management.
