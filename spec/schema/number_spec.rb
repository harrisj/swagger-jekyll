require 'spec_helper'

describe SwaggerJekyll::Schema::Number do
  describe 'compact_type' do
    it 'should just be the display type' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer'}, nil)
      expect(s.compact_type).to eq('integer')
    end

    it 'should include an exclusiveMinimum if specified' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer', 'exclusiveMinimum' => true, 'minimum' => 0}, nil)
      expect(s.compact_type).to eq('integer (n > 0)')
    end

    it 'should include an exclusiveMaximum if specified' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer', 'exclusiveMaximum' => true, 'maximum' => 3500}, nil)
      expect(s.compact_type).to eq('integer (n < 3500)')
    end

    it 'should include a minimum if specified' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer', 'minimum' => 0}, nil)
      expect(s.compact_type).to eq('integer (n >= 0)')
    end

    it 'should include a maximum if specified' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer', 'maximum' => 3500}, nil)
      expect(s.compact_type).to eq('integer (n <= 3500)')
    end

    it 'should combine maximum and minimums' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer', 'maximum' => 3500, 'exclusiveMinimum' => true, 'minimum' => 0}, nil)
      expect(s.compact_type).to eq('integer (0 < n <= 3500)')
    end
  end

  describe 'example' do
    it 'should be an integer for integer' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'integer'}, nil)
      expect(s.example).to eq(39)
    end

    it 'should be a float for float' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'number'}, nil)
      expect(s.example).to eq(39.4)
    end

    it 'should be a boolean for boolean' do
      s = SwaggerJekyll::Schema::Number.new('foo', {'type' => 'boolean'}, nil)
      expect(s.example).to eq(true)
    end
  end
end
