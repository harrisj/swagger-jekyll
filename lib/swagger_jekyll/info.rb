module SwaggerJekyll
  class Info
    def initialize(hash)
      @hash = hash
    end

    def title
      @hash['title']
    end

    def description
      @hash['description']
    end

    def terms_of_service
      @hash['termsOfService']
    end

    def contact_name
      @hash.dig('contact', 'name')
    end

    def contact_url
      @hash.dig('contact', 'url')
    end

    def contact_email
      @hash.dig('contact', 'email')
    end

    def license_name
      @hash.dig('license', 'name')
    end

    def license_url
      @hash.dig('license', 'url')
    end

    def version
      @hash['version']
    end
  end
end
