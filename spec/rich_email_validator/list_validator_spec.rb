require 'helper'

ListValidator = RichEmailValidator::ListValidator

describe ListValidator do

  describe '#filter' do
    let(:list) { get_list('list_fixture.txt') }
    let(:valid_list) { get_list('valid_fixture.txt') }
    it 'returns a list of valid emails' do
      output = ListValidator.new(list).filter
      expect(output).to eq(valid_list)
    end
  end
end
