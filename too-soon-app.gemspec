# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "Too Soon? app"
  spec.version = '0.1'
  spec.authors = ['Chris Pardee', 'Mattori Birnbaum', 'Nathaniel Ostrer', 'Meet Patel']
  spec.email = ['mattori.birnbaum@gmail.com']
  spec.summary = "An app and Twitter bot about if it's too soon to talk about something."
  spec.description = "A server that parses from a Sinatra-based web server and Twitter bot and determines whether it's too soon to talk about a popular media topic."
  spec.homepage = "http://github.com/PsychicNoodles/too-soon-app"
  spec.license = "MIT"
  spec.files = ['lib/too-soon-app.rb']
  spec.executables = ['bin/too-soon-app']
  spec.test_files = ['tests/test_too-soon-app']
  spec.require_paths = ['lib']
end
