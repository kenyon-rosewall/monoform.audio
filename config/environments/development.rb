Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # SMTP settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "mail.privateemail.com",
    :port                 => 587,
    :user_name            => 'info@twinmusicom.org',
    :password             => '5P@Rkyn@!1',
    :authentication       => "plain",
    :enable_starttls_auto => true
  }

  config.log_level = :error

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  all_envs = Dir.glob("./config/environments/*.rb").map { |filename| File.basename(filename, ".rb") }
  current_env = Rails.env.to_s

  begin
    YAML.load(File.open(File.expand_path("./config/application.yml"))).each do |key, value|
      if (all_envs.include?(key.to_s))
        #deal with environment hash
        if (key.to_s == current_env)
          value.each do |env_key, env_value|
            ENV[env_key.to_s] = env_value.to_s
            #puts('key : '+env_key.to_s+' value: '+env_value.to_s+')
          end
        end
      else
        ENV[key.to_s] = value.to_s
        #puts('key : '+key.to_s+' value: '+value.to_s+' ENV["key"]:')
      end

    end
  rescue Exception => e
    puts('Problem loading file : '+e.message.to_s)
    puts(e.backtrace.inspect)
  end
end
