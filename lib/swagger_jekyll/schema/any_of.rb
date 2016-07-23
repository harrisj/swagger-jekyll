module SwaggerJekyll
  class Schema::AnyOf < SwaggerJekyll::Schema
    def display_type
      type.join(", ")
    end
  end
end
