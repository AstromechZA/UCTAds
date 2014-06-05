require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Uctads
  class Application < Rails::Application

    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => false,
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    config.time_zone = 'Pretoria'

    config.i18n.enforce_available_locales = true
  end
end
