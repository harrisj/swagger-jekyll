require 'spec_helper'

describe SwaggerJekyll::Schema::Object do
  let(:object) { SwaggerJekyll::Schema::Object.new('Name', {"description" => 'description', "title" => 'title'}, nil) }

  describe '#title' do
    it 'should return the title of the object' do
      expect(object.title).to eq('title')
    end
  end

  describe '#description' do
    it 'should return the description the object' do
      expect(object.description).to eq('description')
    end
  end

  describe '#example' do
    it "should return ''" do
      expect(object.example).to eq('')
    end
  end

  describe '#display_type' do
    context 'when an object has no properties' do
      it 'should display the object name' do
        expect(object.display_type).to eq('<Name object>')
      end
    end

    context 'when an object has only 2 properties or less' do
      let(:object) { SwaggerJekyll::Schema::Object.new('Name', {'properties' => {
                                                                  "foo" => {"type" => "string"},
                                                                  "bar" => {"type" => "integer"}}})}

      it 'should display them inline within braces' do
        expect(object.display_type).to eq('<Name {"foo": string, "bar": integer}>')
      end
    end

    context 'when an object has more than 2 properties' do
      let(:object) { SwaggerJekyll::Schema::Object.new('Name', {'properties' => {
                                                                  "foo" => {"type" => "string"},
                                                                  "bar" => {"type" => "integer"},
                                                                  "baz" => {"type" => "string"}}})}

      it 'should just display the name' do
        expect(object.display_type).to eq('<Name object>')
      end
    end
  end
end
