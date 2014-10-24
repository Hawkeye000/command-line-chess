Gem::Specification.new do |s|
  s.name = 'chess'
  s.version = '0.0.0'
  s.date = '2014-10-24'
  s.summary = "Play chess using the command line."
  s.description = "Contain libraries for setting up and playing games of chess,\
                  making and validating moves, and evaluating victory conditions."
  s.authors = ["Benjamin Pearce"]
  require 'rake'
  s.files = Dir['lib/*.rb'] + Dir['bin/*']
  s.files += Dir['[A-Z]*'] + Dir['spec/**/*']
  s.files.reject! { |fn| fn.include? "CVS" }
  s.license = "MIT"
end
