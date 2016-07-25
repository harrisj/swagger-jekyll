require 'spec_helper'

describe SwaggerJekyll::Schema::String do
  describe 'display_type' do
    it 'should return string' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string'}, nil)
      expect(s.display_type).to eq('string')
    end

    it 'should append the format if specified' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string', 'format' => 'email'}, nil)
      expect(s.display_type).to eq('string (email)')
    end
  end

  describe 'example' do
    it 'should return a basic string if there is no format' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string'}, nil)
      expect(s.example).to eq('')
    end

    it 'should return a sample date-time' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string', 'format' => 'date-time'}, nil)
      expect(s.example).to eq('"2016-01-01T13:00:00Z"')
    end

    it 'should return a sample email' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string', 'format' => 'email'}, nil)
      expect(s.example).to eq('"user@example.com"')
    end

    it 'should return a markdown example' do
      s = SwaggerJekyll::Schema::String.new('foo', {'type' => 'string', 'format' => 'markdown'}, nil)
      expect(s.example).to eq('"A **markdown** string"')
    end
  end
end
