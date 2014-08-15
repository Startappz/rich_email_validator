require 'helper'
require 'fileutils'

FileValidator = RichEmailValidator::FileValidator

describe FileValidator do
  let(:invalid_fixture_path) { fixture_path('list_fixture.txt') }
  let(:valid_fixture_path) { fixture_path('valid_fixture.txt') }

  describe '#filter' do
    let(:valid_list) { get_list('valid_fixture.txt') }
    it 'returns a list of valid emails' do
      output = FileValidator.new(invalid_fixture_path).filter
      expect(output).to eq(valid_list)
    end
  end

  describe '#export_valid_list' do
    let(:output_path) { fixture_path('output.tmp') }
    after(:each) { FileUtils.rm_rf(output_path) }
    it 'creates new file with with valid emails' do
      FileValidator.new(invalid_fixture_path).export_valid_list(output_path)
      output_data = File.read(output_path)
      valid_fixture_data = File.read(valid_fixture_path)
      expect(output_data).to eq(valid_fixture_data)
    end
  end
end
