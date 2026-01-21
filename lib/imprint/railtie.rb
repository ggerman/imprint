# frozen_string_literal: true

require 'rails/railtie'

module Imprint
  class Railtie < Rails::Railtie
    initializer 'imprint.helpers' do
      ActiveSupport.on_load(:action_view) do
        include Imprint::Rails::Helper
      end
    end

    initializer 'imprint.configure' do
      # Punto de extensión futuro
    end
  end
end
