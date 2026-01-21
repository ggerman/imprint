# frozen_string_literal: true

require 'imprint/version'
require 'imprint/signer'
require 'imprint/renderer'
require 'imprint/engine' if defined?(Rails)
require 'imprint/railtie' if defined?(Rails)

module Imprint
  def self.sign(source:, watermark:, expires_in:)
    payload = {
      source: source,
      watermark: watermark,
      exp: Time.now.to_i + expires_in.to_i
    }

    token = Signer.sign(payload, secret: secret_key)
    "/imprint/render/#{token}"
  end

  def self.verify(token)
    payload = Signer.verify(token, secret: secret_key)
    return nil unless payload.is_a?(Hash)

    return nil if payload['exp'].to_i < Time.now.to_i

    payload
  end

  def self.render_from_token(token)
    payload = verify(token)
    return nil unless payload

    Renderer.render(
      source: payload['source'],
      watermark: payload['watermark']
    )
  end

  def self.secret_key
    # sin engine todavía; Rails solo si existe
    if defined?(Rails)
      Rails.application.secret_key_base
    else
      ENV['IMPRINT_SECRET'] || 'imprint-dev-secret'
    end
  end
end
