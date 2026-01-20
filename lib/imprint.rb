require "imprint/version"
require "imprint/engine"
require "imprint/signer"

module Imprint
  def self.sign(source:, watermark:, expires_in:)
    payload = {
      source: source,
      watermark: watermark,
      exp: expires_in.from_now.to_i
    }

    token = Signer.sign(
      payload,
      secret: secret_key
    )

    "/imprint/render/#{token}"
  end

  def self.secret_key
    Rails.application.secret_key_base
  end
end
