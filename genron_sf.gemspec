# frozen_string_literal: true

require_relative 'lib/genron_sf/version'

Gem::Specification.new do |spec|
  spec.name          = 'genron_sf'
  spec.version       = GenronSF::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Scraping and ebook generation of 超・SF作家育成サイト'
  spec.homepage      = 'https://github.com/fuji-nakahara/genron_sf'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/fuji-nakahara'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/fuji-nakahara/genron_sf'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gepub', '>= 1.0'
  spec.add_dependency 'nokogiri', '>= 1.10'
end
