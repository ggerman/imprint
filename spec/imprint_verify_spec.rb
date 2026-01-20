# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Imprint do
  it 'verifies a valid token' do
    token = Imprint.sign(
      source: 'image.jpg',
      watermark: 'CONFIDENTIAL',
      expires_in: 60
    ).split('/').last

    payload = Imprint.verify(token)

    expect(payload).to be_a(Hash)
    expect(payload['source']).to eq('image.jpg')
  end

  it 'rejects expired tokens' do
    token = Imprint.sign(
      source: 'image.jpg',
      watermark: 'CONFIDENTIAL',
      expires_in: -1
    ).split('/').last

    expect(Imprint.verify(token)).to be_nil
  end
end
