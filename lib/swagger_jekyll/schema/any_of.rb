module SwaggerJekyll
  class Schema::AnyOf < SwaggerJekyll::Schema
    def compact_type
      type.join(", ")
    end
  end
end
