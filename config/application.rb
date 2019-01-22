require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # 缓存大小
    config.cache_store = :memory_store, { size: 64.megabytes }
    config.time_zone = "Beijing"
    config.active_record.default_timezone = :local
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += [
      Rails.root.join('api')
    ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
