require_relative 'allocation_html_formatter'
require_relative 'allocation_parser'

module AlloAllo
  class Base
    def initialize
      @parser = AlloAllo::AllocationParser.new
    end

    def format(file_handle, formatter = nil)
      allocations = []
      file_handle.each_line do |allocation_string|
        begin
        allocations << @parser.parse(allocation_string)
        rescue InvalidAllocationStringError
        end
      end
      (formatter || AlloAllo::AllocationHtmlFormatter.new).format(allocations)
    end
  end
end
