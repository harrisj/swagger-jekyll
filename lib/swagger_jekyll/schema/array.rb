module SwaggerJekyll
  class Schema::Array < SwaggerJekyll::Schema
    def display_type
      "<#{element_type.display_type}>[] array"
    end

    def element_type
      @_element_type ||= Schema.factory(nil, hash['items'], specification)
    end
  end
end
