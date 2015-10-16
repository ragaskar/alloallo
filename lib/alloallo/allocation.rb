module AlloAllo
  class Allocation
    ROTATION = :rotation
    LEAVING_ON_VACATION = :leaving_on_vacation
    RETURNING_FROM_VACATION = :returning_from_vacation
    LEAVING_THE_COMPANY = :leaving_the_company
    NEW_HIRE = :new_hire
    NEW_LABS_PIVOT = :new_labs_pivot
    BACK_TO_LABS = :back_to_labs

    attr_reader :type, :name, :office, :from, :to
    def initialize(attrs)
      @type = attrs.fetch(:type)
      @name = attrs.fetch(:name)
      @office = attrs.fetch(:office)
      @from = attrs.fetch(:from)
      @to = attrs.fetch(:to)
    end

  end
end
