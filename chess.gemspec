lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chess/version'

Gem::Specification.new do |spec|
  spec.name = 'chess_game'
  spec.version = '0.0.13'
  spec.date = '2017-08-05'
  spec.authors = ["Benjamin Pearce"]
  spec.email = ["hawk.git@bcpearce.com"]
  spec.summary = "Play chess using the command line."
  spec.description = "Contain libraries for setting up and playing games of chess,\
                  making and validating moves, and evaluating victory conditionspec."
  spec.homepage = "https://github.com/bcpearce/command-line-chess"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '10.3.2'
  spec.add_development_dependency 'rspec', '~> 3.1'

  spec.add_runtime_dependency 'colorize', '~> 0.7.3'


end
