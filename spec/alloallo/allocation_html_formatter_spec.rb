require 'spec_helper'
require 'ffaker'
require 'alloallo/allocation'
require 'alloallo/allocation_html_formatter'
describe AlloAllo::AllocationHtmlFormatter do

  def allocation_factory(type)
    AlloAllo::Allocation.new(type: type, name: Faker::Name.name, office: ["SF", "NYC", "LDN", "TOR"].sample, from: "Some Project", to: "Some Other Project")
  end

  it "skips sections with no allocations" do
    vacation = allocation_factory(AlloAllo::Allocation::LEAVING_ON_VACATION)
    rotation1 = allocation_factory(AlloAllo::Allocation::ROTATION)
    allocations = [vacation, rotation1]
    #eventually we can pass different default strings to new
    string = AlloAllo::AllocationHtmlFormatter.new.format(allocations)
    expected_result =
    <<-EXPECTED
<em>Rotations</em><br />
(#{rotation1.office}) <strong>#{rotation1.name}</strong> moves from <strong>#{rotation1.from}</strong> to <strong>#{rotation1.to}</strong><br />
<br />
<em>Going on Vacation</em><br />
(#{vacation.office}) <strong>#{vacation.name}</strong> taking a vacation from <strong>#{vacation.from}</strong>
    EXPECTED
    expect(string).to eql expected_result.chomp.gsub("\n", "")
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
    string = AlloAllo::AllocationHtmlFormatter.new.format(allocations)
    expected_result =
    <<-EXPECTED
<em>New Faces</em><br />
(#{new_hire.office}) <strong>#{new_hire.name}</strong>, new CF Pivot, joining <strong>#{new_hire.to}</strong><br />
(#{new_labs_pivot.office}) <strong>#{new_labs_pivot.name}</strong>, Labs Pivot joining <strong>#{new_labs_pivot.to}</strong><br />
<br />
<em>Exits</em><br />
(#{back_to_labs.office}) <strong>#{back_to_labs.name}</strong> returns to Labs<br />
(#{exiting.office}) <strong>#{exiting.name}</strong> is leaving Pivotal<br />
<br />
<em>Rotations</em><br />
(#{rotation1.office}) <strong>#{rotation1.name}</strong> moves from <strong>#{rotation1.from}</strong> to <strong>#{rotation1.to}</strong><br />
(#{rotation2.office}) <strong>#{rotation2.name}</strong> moves from <strong>#{rotation2.from}</strong> to <strong>#{rotation2.to}</strong><br />
<br />
<em>Going on Vacation</em><br />
(#{vacation.office}) <strong>#{vacation.name}</strong> taking a vacation from <strong>#{vacation.from}</strong><br />
<br />
<em>Returning from Vacation</em><br />
(#{returning_vacation.office}) <strong>#{returning_vacation.name}</strong> returns from vacation to <strong>#{vacation.to}</strong>
    EXPECTED
    expect(string).to eql expected_result.chomp.gsub("\n", "")

  end
end

