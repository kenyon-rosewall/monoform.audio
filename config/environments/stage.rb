Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  config.log_level = :error

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

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

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
