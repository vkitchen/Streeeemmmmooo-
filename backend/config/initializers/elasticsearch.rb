require "elasticsearch"

SearchClient = Elasticsearch::Client.new(
  hosts: [
      {
          host: Rails.application.credentials.elasticsearch[:host],
          port: Rails.application.credentials.elasticsearch[:port],
          user: Rails.application.credentials.elasticsearch[:user],
          password: Rails.application.credentials.elasticsearch[:password],
          scheme: 'https',
      },
  ],
  retry_on_failure: 2,
  request_timeout: 10,
  adapter: :typhoeus,
  log: Rails.env.development?,
)
