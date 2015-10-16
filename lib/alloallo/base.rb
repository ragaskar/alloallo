require_relative 'allocation_formatter'
require_relative 'allocation_parser'

module AlloAllo
  class Base
    def initialize
      @parser = AlloAllo::AllocationParser.new
      @formatter = AlloAllo::AllocationFormatter.new
    end

    def format(file_handle)
      allocations = []
      file_handle.each_line do |allocation_string|
        begin
        allocations << @parser.parse(allocation_string)
        rescue InvalidAllocationStringError
        end
      end
      @formatter.format(allocations)
    end
  end
end
