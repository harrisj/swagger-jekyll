module SwaggerJekyll
  class Schema::Array < SwaggerJekyll::Schema
    def compact_type
      "#{element_type.compact_type}[] array"
    end

    def element_type
      @_element_type ||= Schema.factory(nil, hash['items'], specification)
    end
  end
end
