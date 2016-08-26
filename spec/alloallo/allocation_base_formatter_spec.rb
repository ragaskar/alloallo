require 'spec_helper'
require 'ffaker'
require 'alloallo/allocation'
require 'alloallo/allocation_base_formatter'
describe AlloAllo::AllocationBaseFormatter do

  def allocation_factory(type)
    AlloAllo::Allocation.new(type: type, name: Faker::Name.name, office: ["SF", "NYC", "LDN", "TOR"].sample, from: "Some Project", to: "Some Other Project")
  end

  it "raises an error if you try to call it directly" do
    expect { AlloAllo::AllocationBaseFormatter.new.format([]) }.to raise_error(AlloAllo::AllocationBaseFormatter::AbstractClassError)
  end
end

