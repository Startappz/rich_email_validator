require_relative 'rich_email_validator/version'
require_relative 'rich_email_validator/email_validator'
require_relative 'rich_email_validator/list_validator'
require_relative 'rich_email_validator/file_validator'

# RichEmailValidator top level module
module RichEmailValidator
  class << self
    # Validates an email
    # @param email [String]
    # @return [Boolean]
    def valid_email?(email)
      EmailValidator.valid?(email)
    end

    # Validates list of emails
    # @param list [Enumerator]
    # @param [Hash] options
    # @option options [#to_int] :threads_count number of threads that will
    #  be fired simultaneously to calculate the result
    # @return [Array]
    def filter_list(list, options = {})
      ListValidator.filter(list, options)
    end

    # Validates input from file
    # @param input_file_path [File]
    # @param [Hash] options
    # @option options [#to_int] :threads_count number of threads that will
    #  be fired simultaneously to calculate the result
    # @return [Array]
    def filter_file(input_file_path, options = {})
      FileValidator.filter(input_file_path, options)
    end

    # Validates input from file and writes to file
    # @param input_file_path [File]
    # @param output_file_path [File]
    # @param [Hash] options
    # @option options [#to_int] :threads_count number of threads that will
    #  be fired simultaneously to calculate the result
    def export_valid_list(input_file_path, output_file_path, options = {})
      FileValidator.export_valid_list(input_file_path,
                                      output_file_path,
                                      options)
    end
  end
end
