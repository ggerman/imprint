# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Imprint::Renderer do
  it 'renders an image with watermark' do
    output = described_class.render(
      source: 'spec/fixtures/sample.png',
      watermark: 'CONFIDENTIAL'
    )

    expect(File).to exist(output)
    expect(File.size(output)).to be > 0
  end
end
