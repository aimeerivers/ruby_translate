Gem::Specification.new do |s|
  s.name = %q{ruby_translate}
  s.version = "0.1"
  s.date = %q{2009-06-15}
  s.authors = ["Aimee Daniells"]
  s.email = %q{aimee@edendevelopment.co.uk}
  s.homepage = %q{http://www.edendevelopment.co.uk}
  s.summary = %q{An easy way to access the Google Translate API via Ruby.}
  s.description = %q{RubyTranslate provides a simple wrapper around the Google Translate API for detecting and translating languages.}
  s.files = [ "lib/ruby_translate.rb"]
  s.add_dependency(%q<json>, [">= 1.1.3"])
  s.has_rdoc = true
end
