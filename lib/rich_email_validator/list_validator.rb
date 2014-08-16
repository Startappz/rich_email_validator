require 'resolv'
require 'forwardable'

module RichEmailValidator
  # Validates list of emails and return the valid ones
  class ListValidator
    class << self
      # Validates list of emails
      # @param list [Enumerator]
      # @param [Hash] options
      # @option options [#to_int] :threads_count number of threads that will
      #  be fired simultaneously to calculate the result. Default 20, max 100
      # @return [Array]
      def filter(list, options = {})
        new(list, options).filter
      end
    end

    attr_reader :list, :threads_count

    # Validates list of emails
    # @param list [Enumerator]
    # @param [Hash] options
    # @option options [#to_int] :threads_count number of threads that will
    #  be fired simultaneously to calculate the result. Default 20, max 100
    def initialize(list, options = {})
      @list = list
      @threads_count = options.fetch(:threads_count) { 20 }
      fail ArgumentError, "Threads can't exceed 100" if @threads_count > 100
      @result = []
      @total_slices = (@list.size / @threads_count.to_f).ceil
    end

    # Validates list of emails
    # @return [Array]
    def filter
      @filtered ||= run_filter
    end

    private

    attr_reader :result, :total_slices

    def run_filter
      threads = (0...total_slices).map do |slice_index|
        Thread.new { filter_slice(slice_index) }
      end
      threads.each { |thread| thread.join }
      result.select { |email| email }
    end

    def filter_slice(slice_index)
      start_index = (threads_count * slice_index)
      end_index = [start_index + threads_count, list.size].min
      (start_index...end_index).each do |list_index|
        email = list[list_index]
        result[list_index] = email if EmailValidator.valid?(email)
      end
      sleep_timer(start_index)
    end

    def sleep_timer(index)
      sleep(1) if (index % ((100 / threads_count) * threads_count)) == 0
    end
  end
end
