require 'spec_helper'

describe SwaggerJekyll::Schema::Array do
  describe '#compact_type' do
    context 'for an array of simple types' do
      let(:array) { SwaggerJekyll::Schema::Array.new('Name', {'type' => 'array', 'items' => {'type' => 'string'}}, nil) }

      it 'should return a simple string' do
        expect(array.compact_type).to eq('string[] array')
      end

    end

    context 'for an array of objects' do
      let(:array) { SwaggerJekyll::Schema::Array.new('Name', {'type' => 'array', 'items' => {'$ref' => "#\/definitions\/Thing"}}, nil) }

      it 'should not dereference pointers' do
        expect(array.compact_type).to eq('<Thing>[] array')
      end
    end
  end
end
