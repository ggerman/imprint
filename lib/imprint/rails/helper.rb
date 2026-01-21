# frozen_string_literal: true

module Imprint
  module Rails
    module Helper
        def imprint_image_tag(token, **)
          image_tag(
              imprint_render_path(token: token),
              **
          )
        end
    end
  end
end
