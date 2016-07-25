module SwaggerJekyll
  class Schema::Array < SwaggerJekyll::Schema
    def display_type
      "array of #{element_type.display_type}"
    end

    def description
      element_type.description
    end

    def element_type
      @_element_type ||= Schema.factory(nil, hash['items'], specification)
    end
  end
end
