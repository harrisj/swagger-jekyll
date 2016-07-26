require 'spec_helper'

describe SwaggerJekyll::Reference do
  let(:swagger) { SwaggerJekyll::Specification.load_json(fixture_path('basic_reference')) }

  describe 'dereference' do
    let(:ref) { swagger.definition("ThingRef") }
    let(:target) { swagger.definition("Thing") }

    it 'should not load the referenced object by default' do
      expect(ref).to be_a(SwaggerJekyll::Reference)
      expect(ref).to_not be_dereferenced
    end

    it 'should dereference when explicitly called' do
      ref.dereference
      expect(ref).to be_dereferenced
    end

    it 'should return the name of the pointer' do
      expect(ref.name).to eq('ThingRef')
      expect(ref).to_not be_dereferenced
    end

    it 'should dereference to return the title' do
      expect(ref.title).to eq(target.title)
      expect(ref).to be_dereferenced
    end

    it 'should dereference to return the description' do
      expect(ref.description).to eq(target.description)
      expect(ref).to be_dereferenced
    end

    it 'should dereference to return the properties' do
      expect(ref.properties).to eq(target.properties)
      expect(ref).to be_dereferenced
    end
  end
end
