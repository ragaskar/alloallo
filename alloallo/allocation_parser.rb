require_relative 'allocation'
class AlloAllo
  class AllocationParser
    def parse(allocation_string)
      result = allocation_string.match(/(.*)\s+moved from\s+(.*)\s+to\s+(.*)/)
      name = result[1]
      from = result[2]
      to = result[3]
      type = get_type(from, to)
      office = get_office(from, to)
      Allocation.new(type: type, name: name, office: office)
    end

    private
    def get_type(from, to)
      # p "from #{from}"
      # p "to #{to}"
      return AlloAllo::Allocation::LEAVING_ON_VACATION if to == 'vacation'
      return AlloAllo::Allocation::RETURNING_FROM_VACATION if from == 'vacation'
      return AlloAllo::Allocation::LEAVING_THE_COMPANY if to == 'the farm'
      return AlloAllo::Allocation::NEW_HIRE if from == 'the farm'
      return AlloAllo::Allocation::NEW_LABS_PIVOT if !from.include?("CF")
      return AlloAllo::Allocation::BACK_TO_LABS if !to.include?("CF")
      return AlloAllo::Allocation::ROTATION
    end

    def get_office(from, to)
      from_office = parse_office(from)
      to_office = parse_office(to)
      [from_office, to_office].compact.uniq.join(" -> ")
    end

    def parse_office(string)
      return nil unless string.include?("CF")
      string.match(/CF - (.*) -/)[1]
    end
  end
end
