# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qbwc_workers/version'

Gem::Specification.new do |spec|
  spec.name          = "qbwc_workers"
  spec.version       = QbwcWorkers::VERSION
  spec.authors       = ["Vic Amuso"]
  spec.email         = ["vic@parablesoft.com"]

  spec.summary       = %q{Stuff to make working with QBWC easier}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", '~> 1.3.9'
  spec.add_development_dependency "byebug", '~> 4.0.5'
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "require_all"
  spec.add_dependency "qbxml", [">= 0.3.0"]
  spec.add_dependency "wash_out", ["= 0.10.0"]
  spec.add_dependency 'actionview', ['>= 4.1.0']
  spec.add_dependency "qbwc"
  spec.add_dependency "hashie"
  spec.add_development_dependency('rails', [">= 4.1.0"])
end
