require_relative '../schema'

module SwaggerJekyll
  class Schema::AllOf < Schema
    def type
      'allOf'
    end

    def properties
      hash['allOf'].map { |h| Schema.factory(nil, h, specification).properties }.flatten
    end
  end
end
