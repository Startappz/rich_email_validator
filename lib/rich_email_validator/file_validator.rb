module RichEmailValidator
  # Validate input file emails and save valid ones to another output file
  class FileValidator
    attr_reader :input_file_path

    class << self
      # Validates input from file
      # @param input_file_path [File]
      # @param [Hash] options
      # @option options [#to_int] :threads_count number of threads that will
      #  be fired simultaneously to calculate the result. Default 20, max 100
      # @return [Array]
      def filter(input_file_path, options = {})
        new(input_file_path, options).filter
      end

      # Validates input from file and write to file
      # @param input_file_path [File]
      # @param output_file_path [File]
      # @param [Hash] options
      # @option options [#to_int] :threads_count number of threads that will
      #  be fired simultaneously to calculate the result. Default 20, max 100
      def export_valid_list(input_file_path, output_file_path, options = {})
        new(input_file_path, options).export_valid_list(output_file_path)
      end
    end

    # Validates input from file
    # @param input_file_path [File]
    # @param [Hash] options
    # @option options [#to_int] :threads_count number of threads that will
    #  be fired simultaneously to calculate the result. Default 20, max 100
    def initialize(input_file_path, options = {})
      @input_file_path = input_file_path
      @options = options
    end

    # Validates input from file
    # @return [Array]
    def filter
      @filtered ||= run_filter
    end

    # Validates input from file and writes to file
    def export_valid_list(output_file_path)
      File.open(output_file_path, 'w') do |file|
        filter.each { |email| file.puts(email) }
      end
    end

    private

    def run_filter
      list = File.readlines(@input_file_path).map(&:chomp)
      ListValidator.filter(list, @options)
    end
  end
end
