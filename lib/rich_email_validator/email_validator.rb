require 'resolv'

module RichEmailValidator
  # Validate email address
  class EmailValidator
    class << self
      attr_writer :email_regexp

      def valid?(email)
        new(email).valid?
      end

      def email_regexp
        @email_regexp || default_email_regexp
      end

      private

      def default_email_regexp
        @default_email_regexp ||=
          /\A[\w!#$%&'*+\/=?`{|}~^-]+(?:\.[\w!#$%&'*+\/=?`{|}~^-]+)*@(?:[A-Z0-9-]+\.)+[A-Z]{2,6}\Z/i
      end
    end

    attr_reader :email

    # Validates an email
    # @param email [String]
    def initialize(email)
      @email = email
    end

    # Validates an email
    # @return [Boolean]
    def valid?
      @valid ||= valid_form? && valid_mx_record?
    end

    # Validates an email
    # @return [Boolean]
    def valid_form?
      @valid_form ||= check_form
    end

    # Validates an email
    # @return [Boolean]
    def valid_mx_record?
      @validate_mx_record ||= check_mx_record
    end

    private

    def check_form
      (email =~ (self.class.email_regexp)) == 0
    end

    def check_mx_record
      domain = email.match(/\@(.+)/)[1]
      mx = 0
      Resolv::DNS.open do |dns|
        mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX) +
          dns.getresources(domain, Resolv::DNS::Resource::IN::A)
      end
      mx.size > 0 ? true : false
    end
  end
end
