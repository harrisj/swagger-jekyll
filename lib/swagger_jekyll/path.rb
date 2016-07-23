module SwaggerJekyll
  class Path
    attr_accessor :path, :verbs

    def initialize(path, hash, specification)
      @path = path
      @hash = hash
      @specification = specification
    end

    def to_liquid
      @hash.dup.merge(
        'path' => @path,
        'verbs' => verbs
      )
    end

    def verbs
      verbs_hash.values
    end

    private

    def verbs_hash
      if @_verbs_hash.nil?
        @_verbs_hash = {}
        @hash.each do |path, hash|
          @_verbs_hash[path] = Verb.new(path, hash, @specification)
        end
      end

      @_verbs_hash
    end
  end
end
