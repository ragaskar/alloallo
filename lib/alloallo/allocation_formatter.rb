require_relative 'allocation'
module AlloAllo
  class AllocationFormatter
    def initialize
      @strings = {
        AlloAllo::Allocation::ROTATION => ['($office) $name moves from $from to $to'],
        AlloAllo::Allocation::LEAVING_ON_VACATION => ['($office) $name taking a vacation from $from'],
        AlloAllo::Allocation::RETURNING_FROM_VACATION => ['($office) $name returns from vacation to $to'],
        AlloAllo::Allocation::NEW_LABS_PIVOT => ['($office) $name, new Labs Pivot, joining $to'],
        AlloAllo::Allocation::NEW_HIRE => ['($office) $name, new CF Pivot, joining $to'],
        AlloAllo::Allocation::BACK_TO_LABS => ['($office) $name returns to Labs'],
        AlloAllo::Allocation::LEAVING_THE_COMPANY => ['($office) $name is leaving Pivotal'],
      }
    end

    def format(allocations)
      [
        render_section("New Hires", allocations.select { |a| [AlloAllo::Allocation::NEW_HIRE].include?(a.type) }),
        render_section("New Labs Pivots", allocations.select { |a| [AlloAllo::Allocation::NEW_LABS_PIVOT].include?(a.type) }),
        render_section("Exits", allocations.select { |a| [AlloAllo::Allocation::LEAVING_THE_COMPANY, AlloAllo::Allocation::BACK_TO_LABS].include?(a.type) }),
        render_section("Rotations", allocations.select { |a| a.type == AlloAllo::Allocation::ROTATION }),
        render_section("Going on Vacation", allocations.select { |a| a.type == AlloAllo::Allocation::LEAVING_ON_VACATION }),
        render_section("Returning from Vacation", allocations.select { |a| a.type == AlloAllo::Allocation::RETURNING_FROM_VACATION })
      ].compact.join("\n\n")
    end

    private
    def format_allocation(allocation)
      @strings[allocation.type].sample.
        gsub(/\$office/, allocation.office).
        gsub(/\$from/, allocation.from).
        gsub(/\$to/, allocation.to).
        gsub(/\$name/, allocation.name)
    end

    def render_section(section_title, allocations)
      return nil unless allocations.any?
      "#{section_title}\n#{allocations.map { |a| format_allocation(a) }.join("\n")}"
    end
  end
end
