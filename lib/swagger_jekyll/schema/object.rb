module SwaggerJekyll
  class Schema::Object < SwaggerJekyll::Schema
    def type
      'object'
    end

    def properties
      properties_hash.values
    end

    def property(key)
      properties_hash[key]
    end

    def compact_type
      if properties.length > 0 && properties.length < 3
        "<#{name+' ' unless name.nil?}{" + properties.map {|p| '"' + p.name + '": ' + p.compact_type}.join(', ') + '}>'
      else
        "<#{name} object>"
      end
    end

    def title
      hash['title']
    end

    def description
      hash['description']
    end

    def example
      ''
    end

    private

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
