require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cabler
  class Application < Rails::Application
    VERSION = "0.1.1".freeze

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Needed for correct error field markup with bulma_form_builder
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag.gsub(/class="/, "class=\"field_with_errors ").html_safe
      #%Q(<div class="field_with_errors">#{html_tag}</div>).html_safe
    end
  end

end
