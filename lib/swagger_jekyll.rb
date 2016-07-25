require 'json'
require 'open-uri'

require 'swagger_jekyll/path'
require 'swagger_jekyll/reference'
require 'swagger_jekyll/response'
require 'swagger_jekyll/specification'
require 'swagger_jekyll/schema'
require 'swagger_jekyll/verb'
require 'swagger_jekyll/schema/all_of'
require 'swagger_jekyll/schema/any_of'
require 'swagger_jekyll/schema/array'
require 'swagger_jekyll/schema/number'
require 'swagger_jekyll/schema/object'
require 'swagger_jekyll/schema/string'

# taken from 18F/Jekyll_get
module SwaggerJekyll
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      config = site.config['swagger']
      if config.nil?
        return
      end
      if !config.is_a?(Array)
        config = [config]
      end
      config.each do |d|
        data_key = d['id'] || 'swagger'
        source = JSON.load(open(d['json']))
        site.data[data_key] = SwaggerJekyll::Specification.new(source)

        if d['cache']
          data_source = (site.config['data_source'] || '_data')
          path = "#{data_source}/#{d['data']}.json"
          open(path, 'wb') do |file|
            file << JSON.generate(site.data[d['data']])
          end
        end
      end
    end
  end
end
