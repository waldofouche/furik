lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'furik/version'

Gem::Specification.new do |spec|
  spec.name          = 'furik'
  spec.version       = Furik::VERSION
  spec.authors       = ['linyows', 'SHIBATA Hiroshi']
  spec.email         = ['linyows@gmail.com', 'hsbt@ruby-lang.org']

  spec.summary       = 'A summary generator of GitHub activity for retrospective.'
  spec.description   = 'A summary generator of GitHub activity for retrospective.'
  spec.homepage      = 'https://github.com/pepabo/furik'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'netrc', '~> 0.11.0'
  spec.add_dependency 'octokit', '~> 4.20.0'
  spec.add_dependency 'thor', '~> 1.1.0'

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'rake', '~> 13.0'
end
