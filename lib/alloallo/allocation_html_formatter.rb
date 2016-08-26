require_relative 'allocation_base_formatter'
module AlloAllo
  class AllocationHtmlFormatter < AllocationBaseFormatter
    def initialize
      @strings = {
        AlloAllo::Allocation::ROTATION => ['($office) <strong>$name</strong> moves from <strong>$from</strong> to <strong>$to</strong>'],
        AlloAllo::Allocation::LEAVING_ON_VACATION => ['($office) <strong>$name</strong> taking a vacation from <strong>$from</strong>'],
        AlloAllo::Allocation::RETURNING_FROM_VACATION => ['($office) <strong>$name</strong> returns from vacation to <strong>$to</strong>'],
        AlloAllo::Allocation::NEW_LABS_PIVOT => ['($office) <strong>$name</strong>, Labs Pivot joining <strong>$to</strong>'],
        AlloAllo::Allocation::NEW_HIRE => ['($office) <strong>$name</strong>, new CF Pivot, joining <strong>$to</strong>'],
        AlloAllo::Allocation::BACK_TO_LABS => ['($office) <strong>$name</strong> returns to Labs'],
        AlloAllo::Allocation::LEAVING_THE_COMPANY => ['($office) <strong>$name</strong> is leaving Pivotal'],
      }
    @headings = {
      AlloAllo::AllocationBaseFormatter::NEW_FACES => "<em>New Faces</em>",
      AlloAllo::AllocationBaseFormatter::EXITS => "<em>Exits</em>",
      AlloAllo::AllocationBaseFormatter::ROTATIONS => "<em>Rotations</em>",
      AlloAllo::AllocationBaseFormatter::GOING_ON_VACATION => "<em>Going on Vacation</em>",
      AlloAllo::AllocationBaseFormatter::RETURNING_FROM_VACATION => "<em>Returning from Vacation</em>",
    }
    end

    protected
    def join_with
      "<br />"
    end
  end
end
