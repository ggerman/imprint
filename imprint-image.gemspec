# frozen_string_literal: true

require_relative "lib/imprint/version"

Gem::Specification.new do |spec|
  spec.name = "imprint-image"
  spec.version = Imprint::VERSION
  spec.authors = ["Giménez Silva Germán Alberto"]
  spec.email = ["ggerman@gmail.com"]

  spec.summary = "Signed, expiring image watermark rendering for Ruby"
  spec.description = <<~DESC
    Imprint is a Ruby library for generating signed, time-limited image renders
    with dynamic text watermarks. It allows you to securely distribute images
    using expiring tokens, preventing unauthorized reuse or hotlinking.

    Imprint works as a pure Ruby library and can optionally integrate with Rails
    via an isolated engine. Image rendering is powered by the GD graphics library.
  DESC
  spec.homepage = "https://github.com/ggerman/imprint"
  spec.license = "MIT"
  spec.required_ruby_version = '>= 3.3.0'

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ggerman/imprint"
  spec.metadata["changelog_uri"] = "https://github.com/ggerman/imprint/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    Dir['lib/**/*', 'README.md', 'LICENSE', 'CHANGELOG.md']
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'ruby-libgd'
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
