require_relative 'allocation'
module AlloAllo
  class AllocationBaseFormatter
    NEW_FACES = "New Faces"
    EXITS = "Exits"
    ROTATIONS = "Rotations"
    GOING_ON_VACATION = "Going on Vacation"
    RETURNING_FROM_VACATION = "Returning from Vacation"

    class AbstractClassError < StandardError; end

    def format(allocations)
      raise AbstractClassError.new("No @strings defined -- are you trying to operate on a AllocationBaseFormatter instance directly?") unless @strings
      [
        render_section(NEW_FACES, allocations.select { |a| [AlloAllo::Allocation::NEW_HIRE, AlloAllo::Allocation::NEW_LABS_PIVOT].include?(a.type) }),
        render_section(EXITS, allocations.select { |a| [AlloAllo::Allocation::LEAVING_THE_COMPANY, AlloAllo::Allocation::BACK_TO_LABS].include?(a.type) }),
        render_section(ROTATIONS, allocations.select { |a| a.type == AlloAllo::Allocation::ROTATION }),
        render_section(GOING_ON_VACATION, allocations.select { |a| a.type == AlloAllo::Allocation::LEAVING_ON_VACATION }),
        render_section(RETURNING_FROM_VACATION, allocations.select { |a| a.type == AlloAllo::Allocation::RETURNING_FROM_VACATION })
      ].compact.join("#{join_with}#{join_with}")
    end

    protected
    def join_with
      "\n"
    end


    private
    def format_allocation(allocation)
      @strings[allocation.type].sample.
        gsub(/\$office/, allocation.office).
        gsub(/\$from/, allocation.from).
        gsub(/\$to/, allocation.to).
        gsub(/\$name/, allocation.name)
    end

    def format_title(title)
      (@headings && @headings[title]) || title
    end

    def render_section(section_title, allocations)
      return nil unless allocations.any?
      "#{format_title(section_title)}#{join_with}#{allocations.map { |a| format_allocation(a) }.join(join_with)}"
    end
  end
end
