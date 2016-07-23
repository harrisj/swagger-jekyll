require_relative '../schema'

module SwaggerJekyll
  class Schema::Number < SwaggerJekyll::Schema
    def display_type
      out = type

      if has_min? && has_max?
        out << " (#{min_display_left} n #{max_display_right})"
      elsif has_min?
        out << " (n #{min_display_right})"
      elsif has_max?
        out << " (n #{max_display_right})"
      end

      out
    end

    def example
      case type
      when 'integer'
        39
      when 'number'
        39.4
      when 'boolean'
        true
      end
    end

    private

    def has_min?
      hash['minimum']
    end

    def has_max?
      hash['maximum']
    end

    def max_display_right
      operator = hash['exclusiveMaximum'] ? '<' : '<='
      "#{operator} #{hash['maximum']}"
    end

    def min_display_right
      operator = hash['exclusiveMinimum'] ? '>' : '>='
      "#{operator} #{hash['minimum']}"
    end

    def min_display_left
      operator = hash['exclusiveMinimum'] ? '<' : '<='
      "#{hash['minimum']} #{operator}"
    end
  end
end
