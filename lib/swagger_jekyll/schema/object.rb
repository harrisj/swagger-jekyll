module SwaggerJekyll
  class Schema::Object < SwaggerJekyll::Schema
    def type
      'object'
    end

    def properties
      properties_hash.values
    end

    def display_type
      if properties.length < 3
        '{' + properties.map {|p| '"' + p.name + '": ' + p.display_type}.join(', ') + '}'
      else
        "<#{name} object>"
      end
    end

    def title
      name
    end

    def description
      hash['description']
    end

    def example
      ''
    end

    def properties_hash
      if @_properties.nil?
        @_properties = {}

        if hash.key?('properties')
          hash['properties'].each do |name, value|
            @_properties[name] = Schema.factory(name, value, specification)
          end
        end
      end

      @_properties
    end
  end
end
