Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://server.akiumi.net', 'https://www.akiumi.net', 'http://localhost:3000'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end
