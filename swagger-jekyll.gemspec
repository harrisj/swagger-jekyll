Gem::Specification.new do |s|
  s.name        = 'swagger_jekyll'
  s.version     = '0.0.1'
  s.date        = '2016-07-22'
  s.summary     = 'Load swagger JSON for Jekyll'
  s.description = 'A plugin for Jekyll to load Swagger files and render as tags'
  s.author      = 'Jacob Harris'
  s.email       = 'jacob.harris@gsa.gov'
  s.homepage    = 'https://github.com/harrisj/swagger-jekyll'
  s.license     = 'CC0'
  s.post_install_message = 'Remember to add add `swagger_jekyll` to the list of Gems in _config.yml.'
  s.files       = ['lib/swagger_jekyll.rb', 'lib/swagger_jekyll/path.rb', 'lib/swagger_jekyll/reference.rb',
                   'lib/swagger_jekyll/response.rb', 'lib/swagger_jekyll/schema.rb', 'lib/swagger_jekyll/specification.rb',
                   'lib/swagger_jekyll/verb.rb', 'lib/swagger_jekyll/schema/all_of.rb', 'lib/swagger_jekyll/schema/any_of.rb',
                   'lib/swagger_jekyll/schema/array.rb', 'lib/swagger_jekyll/schema/number.rb', 'lib/swagger_jekyll/schema/object.rb',
                   'lib/swagger_jekyll/schema/string.rb']

  s.extra_rdoc_files = ['README.md', 'LICENSE', 'CONTRIBUTING.md']

  s.add_dependency 'hana'

  s.add_development_dependency 'jekyll'
  s.add_development_dependency 'rspec'
end
