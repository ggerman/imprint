# frozen_string_literal: true

require "openssl"
require "json"
require "base64"

module Imprint
  class Signer
    ALGORITHM = "HS256"

    def self.sign(payload, secret:)
      data = Base64.urlsafe_encode64(payload.to_json)
      signature = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new("sha256"),
        secret,
        data
      )

      "#{data}.#{signature}"
    end

    def self.verify(token, secret:)
      data, signature = token.split(".", 2)
      return nil unless data && signature

      expected = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new("sha256"),
        secret,
        data
      )

      return nil unless secure_compare(expected, signature)

      JSON.parse(Base64.urlsafe_decode64(data))
    rescue JSON::ParserError, ArgumentError
      nil
    end

    def self.secure_compare(a, b)
    return false unless a.bytesize == b.bytesize

    OpenSSL.fixed_length_secure_compare(a, b)
    end
  end
end
