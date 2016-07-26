require 'spec_helper'

describe SwaggerJekyll::Schema::AllOf do
  let(:swagger) { SwaggerJekyll::Specification.load_json(fixture_path('basic_reference')) }
  let(:all_of) { swagger.definition("AllOfThing") }

  describe 'properties' do
    it 'should concatenate properties from its members' do
      properties = all_of.properties
      expect(properties.map(&:name)).to eq(['name', 'numbers', 'added_field'])
    end
  end
end
