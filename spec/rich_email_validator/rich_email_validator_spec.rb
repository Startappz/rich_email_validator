require 'helper'

describe RichEmailValidator do
  describe '::valid_email' do
    let(:email) { 'somehting' }
    let(:result) { [true, false].sample }

    before(:each) do
      allow(RichEmailValidator::EmailValidator)
      .to receive(:valid?).with(email).and_return(result)
    end

    it 'delegates to EmailValidator' do
      expect(RichEmailValidator::EmailValidator)
      .to receive(:valid?).with(email).and_return(result)
      RichEmailValidator.valid_email?(email)
    end

    it 'returns the same delegated call result' do
      expect(RichEmailValidator.valid_email?(email)).to eq(result)
    end
  end

  describe '::filter_list' do
    let(:list) { %w(one, two) }
    let(:options) { { o: 1, t: 2 } }
    let(:result) { [true, false].sample }

    before(:each) do
      allow(RichEmailValidator::ListValidator)
      .to receive(:filter).with(list, options).and_return(result)
    end

    it 'delegates to EmailValidator' do
      expect(RichEmailValidator::ListValidator)
      .to receive(:filter).with(list, options).and_return(result)
      RichEmailValidator.filter_list(list, options)
    end

    it 'returns the same delegated call result' do
      expect(RichEmailValidator.filter_list(list, options)).to eq(result)
    end
  end

  describe '::filter_file' do
    let(:file_path) { 'somewhere' }
    let(:options) { { o: 1, t: 2 } }
    let(:result) { [true, false].sample }

    before(:each) do
      allow(RichEmailValidator::FileValidator)
      .to receive(:filter).with(file_path, options).and_return(result)
    end

    it 'delegates to EmailValidator' do
      expect(RichEmailValidator::FileValidator)
      .to receive(:filter).with(file_path, options).and_return(result)
      RichEmailValidator.filter_file(file_path, options)
    end

    it 'returns the same delegated call result' do
      expect(RichEmailValidator.filter_file(file_path, options)).to eq(result)
    end
  end

  describe '::export_valid_list' do
    let(:file_path) { 'somewhere' }
    let(:output_file_path) { 'somewhere' }
    let(:options) { { o: 1, t: 2 } }
    let(:result) { [true, false].sample }

    before(:each) do
      allow(RichEmailValidator::FileValidator)
      .to receive(:export_valid_list)
      .with(file_path, options)
    end

    it 'delegates to EmailValidator' do
      expect(RichEmailValidator::FileValidator)
      .to receive(:export_valid_list)
      .with(file_path, output_file_path, options)
      RichEmailValidator.export_valid_list(file_path, output_file_path, options)
    end
  end

end
