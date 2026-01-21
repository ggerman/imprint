# frozen_string_literal: true

module Imprint
  module Rails
    module Helper
      def imprint_image_tag(token, **options)
        image_tag(
          imprint_render_path(token: token),
          **options
        )
      end
    end
  end
end
