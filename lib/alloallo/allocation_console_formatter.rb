require_relative 'allocation_base_formatter'
module AlloAllo
  class AllocationConsoleFormatter < AllocationBaseFormatter
    def initialize
      @strings = {
        AlloAllo::Allocation::ROTATION => ['($office) $name moves from $from to $to'],
        AlloAllo::Allocation::LEAVING_ON_VACATION => ['($office) $name taking a vacation from $from'],
        AlloAllo::Allocation::RETURNING_FROM_VACATION => ['($office) $name returns from vacation to $to'],
        AlloAllo::Allocation::NEW_LABS_PIVOT => ['($office) $name, Labs Pivot joining $to'],
        AlloAllo::Allocation::NEW_HIRE => ['($office) $name, new CF Pivot, joining $to'],
        AlloAllo::Allocation::BACK_TO_LABS => ['($office) $name returns to Labs'],
        AlloAllo::Allocation::LEAVING_THE_COMPANY => ['($office) $name is leaving Pivotal'],
      }
    end
  end
end
