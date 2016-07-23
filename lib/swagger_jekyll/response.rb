module SwaggerJekyll
  class Response < Struct.new(:code, :hash, :specification)
    def description
      hash['description']
    end

    def to_liquid
      hash.dup.merge(
        'code' => code,
        'display_type' => response_type.display_type
      )
    end

    def display_type
      response_type.display_type
    end

    def response_type
      Schema.factory(nil, hash['schema'], specification)
    end
  end
end
