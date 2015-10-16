require 'spec_helper'
require 'ffaker'
require 'alloallo/allocation'
require 'alloallo/allocation_formatter'
describe AlloAllo::AllocationFormatter do

  def allocation_factory(type)
    AlloAllo::Allocation.new(type: type, name: Faker::Name.name, office: ["SF", "NYC", "LDN", "TOR"].sample, from: "Some Project", to: "Some Other Project")
  end
  it "outputs a pretty summary of Allocations" do
    vacation = allocation_factory(AlloAllo::Allocation::LEAVING_ON_VACATION)
    returning_vacation = allocation_factory(AlloAllo::Allocation::RETURNING_FROM_VACATION)
    rotation1 = allocation_factory(AlloAllo::Allocation::ROTATION)
    rotation2 = allocation_factory(AlloAllo::Allocation::ROTATION)
    back_to_labs = allocation_factory(AlloAllo::Allocation::BACK_TO_LABS)
    exiting = allocation_factory(AlloAllo::Allocation::LEAVING_THE_COMPANY)
    new_hire = allocation_factory(AlloAllo::Allocation::NEW_HIRE)
    new_labs_pivot = allocation_factory(AlloAllo::Allocation::NEW_LABS_PIVOT)

    allocations = [vacation, returning_vacation, rotation1, rotation2, back_to_labs, exiting, new_hire, new_labs_pivot]
    #eventually we can pass different default strings to new
    string = AlloAllo::AllocationFormatter.new.format(allocations)
    expected_result =
    <<-EXPECTED
New Hires
(#{new_hire.office}) #{new_hire.name}, new CF Pivot, joining #{new_hire.to}

New Labs Pivots
(#{new_labs_pivot.office}) #{new_labs_pivot.name}, new Labs Pivot, joining #{new_labs_pivot.to}

Exits
(#{back_to_labs.office}) #{back_to_labs.name} returns to Labs
(#{exiting.office}) #{exiting.name} is leaving Pivotal

Rotations
(#{rotation1.office}) #{rotation1.name} moves from #{rotation1.from} to #{rotation1.to}
(#{rotation2.office}) #{rotation2.name} moves from #{rotation2.from} to #{rotation2.to}

Going on Vacation
(#{vacation.office}) #{vacation.name} taking a vacation from #{vacation.from}

Returning from Vacation
(#{returning_vacation.office}) #{returning_vacation.name} returns from vacation to #{vacation.to}
    EXPECTED
    expect(string).to eql expected_result.chomp

  end
end

