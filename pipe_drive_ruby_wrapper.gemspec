Gem::Specification.new do |s|
  s.name        = 'pipe_drive_ruby_wrapper'
  s.version     = '0.2.3'
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Some PipeDrive API Ruby Wrapper'
  s.description = 'ruby wrapper of some pipe drive api'
  s.authors     = ['JiaRou Lee']
  s.email       = 'laura34963@kdanmobile.com'
  s.homepage    = 'https://github.com/laura34963/pipe_drive_ruby_wrapper'
  s.license     = 'MIT'

  s.files            = `git ls-files -- lib/*`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.extra_rdoc_files = [ 'README.md' ]
  s.rdoc_options     = ['--charset=UTF-8']
  s.require_path     = "lib"

  s.required_ruby_version = '>= 2.3.1'
  s.add_development_dependency 'rspec', ['~> 3.0']
end