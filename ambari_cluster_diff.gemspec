# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ambari_cluster_diff/version'

Gem::Specification.new do |spec|
  spec.name          = "ambari_cluster_diff"
  spec.version       = AmbariClusterDiff::VERSION
  spec.authors       = ["Ace Subido"]
  spec.email         = ["ace.subido@gmail.com"]

  spec.summary       = %q{Command Line Tool to get the differences between Hadoop Clusters}
  spec.description   = %q{Command Line Tool to get the differences between Hadoop Clusters}
  spec.homepage      = "https://github.com/ace-subido/ambari_cluster_diff"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.2"
  spec.add_dependency "thor", "0.19.1"
  spec.add_dependency "hashdiff", "0.3.0"
  spec.add_dependency "virtus", "~> 1.0"
  spec.add_dependency "table_print", "~> 1.5"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

end
