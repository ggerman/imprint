# frozen_string_literal: true

require 'spec_helper'
require 'gd'

RSpec.describe Imprint do
  before do
    FileUtils.mkdir_p('spec/fixtures')

    image = GD::Image.new(200, 100)
    white = GD::Color.rgb(255, 255, 255)
    image.fill(white)
    image.save('spec/fixtures/source.png')
  end

  it 'renders image when token is valid' do
    token = Imprint.sign(
      source: 'spec/fixtures/source.png',
      watermark: 'CONFIDENTIAL',
      expires_in: 60
    ).split('/').last

    output = Imprint.render_from_token(token)

    expect(output).to be_a(String)
    expect(File).to exist(output)
  end

  it 'returns nil for expired token' do
    token = Imprint.sign(
      source: 'spec/fixtures/source.png',
      watermark: 'CONFIDENTIAL',
      expires_in: -1
    ).split('/').last

    expect(Imprint.render_from_token(token)).to be_nil
  end
end
