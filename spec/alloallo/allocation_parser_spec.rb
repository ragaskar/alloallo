require 'spec_helper'
require 'alloallo/allocation_parser'
describe AlloAllo::AllocationParser do
  it "identifies if the allocation is a rotation" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from CF - LDN - Services	to CF - LDN - Enablement (Cloud Foundry)");
    expect(allocation.from).to eq "Services"
    expect(allocation.to).to eq "Enablement (Cloud Foundry)"
    expect(allocation.type).to eql AlloAllo::Allocation::ROTATION
  end

  it "identifies if the allocation is going on vacation" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from  CF - LDN - Services	to  vacation");
    expect(allocation.type).to eql AlloAllo::Allocation::LEAVING_ON_VACATION
    expect(allocation.from).to eq "Services"
    expect(allocation.to).to eq "vacation"
  end

  it "identifies if the allocation is returning from vacation" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from  vacation	to  CF - LDN - Services");
    expect(allocation.type).to eql AlloAllo::Allocation::RETURNING_FROM_VACATION
    expect(allocation.from).to eq "vacation"
    expect(allocation.to).to eq "Services"
  end

  it "identifies if the allocation is leaving the company" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from  CF - LDN - Services to  the farm");
    expect(allocation.type).to eql AlloAllo::Allocation::LEAVING_THE_COMPANY
    expect(allocation.from).to eq "Services"
    expect(allocation.to).to eq "the farm"
  end

  it "identifies if the allocation is rolling off to a Labs project" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from CF - LDN - Services  to Some Non Prefixed Project");
    expect(allocation.type).to eql AlloAllo::Allocation::BACK_TO_LABS
    expect(allocation.from).to eq "Services"
    expect(allocation.to).to eq "Some Non Prefixed Project"
  end

  it "identifies if the allocation is a new hire" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from the farm to CF - LDN - Services");
    expect(allocation.type).to eql AlloAllo::Allocation::NEW_HIRE
    expect(allocation.from).to eq "the farm"
    expect(allocation.to).to eq "Services"
  end

  it "identifies if the allocation is a new Labs pivot" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from Some Non Prefixed Project  to CF - LDN - Services");
    expect(allocation.type).to eql AlloAllo::Allocation::NEW_LABS_PIVOT
    expect(allocation.from).to eq "Some Non Prefixed Project"
    expect(allocation.to).to eq "Services"
  end

  it "identifies the Pivot name" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ MiddleName Hobgood	moved from Some Non Prefixed Project  to CF - LDN - Services");
    expect(allocation.name).to eql "CJ MiddleName Hobgood"
  end

  it "identifies the office" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from CF - LDN - Services	to CF - LDN - Enablement (Cloud Foundry)");
    expect(allocation.office).to eql "LDN"
  end
  it "identifies when there is a cross office move" do
    parser = AlloAllo::AllocationParser.new
    allocation = parser.parse("CJ Hobgood	moved from CF - LDN - Services	to CF - TOR - Enablement (Cloud Foundry)");
    expect(allocation.office).to eql "LDN -> TOR"
  end
end

