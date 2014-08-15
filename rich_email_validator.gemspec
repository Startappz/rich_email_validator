# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rich_email_validator/version'

Gem::Specification.new do |gem|
  gem.name          = "rich_email_validator"
  gem.version       = RichEmailValidator::Version
  gem.authors       = ["Khaled alHabache"]
  gem.email         = ["khellls@gmail.com"]
  gem.summary       = %q{Set of helpers to validate emails}
  gem.description   = %q{Set of helpers to validate emails}
  gem.homepage      = "https://github.com/Startappz/rich_email_validator"
  gem.license       = 'LGPL-3'
  gem.required_ruby_version = '>= 1.9.2'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files = Dir.glob('spec/**/*')
  gem.require_paths = ['lib']
end
