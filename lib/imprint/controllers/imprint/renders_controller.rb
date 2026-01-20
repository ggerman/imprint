# frozen_string_literal: true

module Imprint
  class RendersController < ActionController::Base
    def show
      path = Imprint.render_from_token(params[:token])

      return head :not_found unless path && File.exist?(path)

      send_file(
        path,
        type: 'image/png',
        disposition: 'inline',
        cache_control: 'no-store'
      )
    end
  end
end
