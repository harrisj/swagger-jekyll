require 'hana'

module SwaggerJekyll
  class Reference
    def initialize(name, hash, specification)
      @name = name
      @hash = hash
      @specification = specification

      fail "This isn't a reference: #{hash.inspect}" unless hash['$ref']
    end

    def to_liquid
      {
        'name' => name,
        'display_type' => display_type
      }
    end

    def name
      @name || ''
    end

    def ref
      @hash['$ref'].gsub(/^#/, '')
    end

    def dereference
      pointer = Hana::Pointer.new(ref)
      target = pointer.eval(@specification.json)
      raise "Unable to dereference #{ref}" if target.nil?
      Schema.factory(@name, target, @specification)
    end

    def properties
      dereference.properties
    end

    def display_type
      "#{@hash['$ref'].gsub('#/definitions/', '')} object"
    end

    def example
      ''
    end
  end
end
