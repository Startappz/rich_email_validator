require 'helper'

EmailValidator = RichEmailValidator::EmailValidator

describe EmailValidator do

  describe '#validate_email' do

    context 'valid email' do
      it 'returns true for valid email' do
        email = 'khellls@gmail.com'
        validator = EmailValidator.new(email)
        expect(validator.valid?).to eq(true)
      end
    end

    context 'non valid email' do
      it 'returns false for invalid email format' do
        email = '@gmail.com'
        validator = EmailValidator.new(email)
        expect(validator.valid?).to eq(false)
      end

      it 'returns false for invalid DNS' do
        email = 'koko@gsfsfsf.com'
        validator = EmailValidator.new(email)
        expect(validator.valid?).to eq(false)
      end
    end
  end

  describe '::regexp' do
    after(:each) { EmailValidator.email_regexp = nil }
    it 'returns default regexp if not set' do
      EmailValidator.email_regexp = nil
      expect(EmailValidator).to receive(:default_email_regexp)
      EmailValidator.email_regexp
    end

    it 'returns regexp if set' do
      EmailValidator.email_regexp = /\d/
      expect(EmailValidator).not_to receive(:default_email_regexp)
      EmailValidator.email_regexp
    end
  end

end
