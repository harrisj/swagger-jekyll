module SwaggerJekyll
  class Schema::String < Schema
    def compact_type
      out = "string"
      out += " (#{format})" if format
      out
    end

    def format
      hash['format']
    end

    def example
      case format
      when 'date-time'
        '"2016-01-01T13:00:00Z"'
      when 'email'
        '"user@example.com"'
      when 'hostname'
        '"example.com"'
      when 'url'
        '"http://example.com/"'
      when 'markdown'
        '"A **markdown** string"'
      else
        ''
      end
    end
  end
end
