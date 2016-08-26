require 'spec_helper'
require 'tempfile'
require 'alloallo/base'
require 'alloallo/allocation_console_formatter'

describe AlloAllo::Base do
  it "nicely formats a chunk of text from allocations" do
    chunk = <<-CHUNK

Kelly Slater	moved from CF - SF - Routing (Cloud Foundry OSS)	to CF - CHI - Lattice
John John Florence	moved from the farm	to CF - DEN - JARVICE

    CHUNK

    file = StringIO.new(chunk)

    result = AlloAllo::Base.new.format(file)

    expected_result =
    <<-EXPECTED
<em>New Faces</em><br />
(DEN) <strong>John John Florence</strong>, new CF Pivot, joining <strong>JARVICE</strong><br />
<br />
<em>Rotations</em><br />
(SF -> CHI) <strong>Kelly Slater</strong> moves from <strong>Routing</strong> to <strong>Lattice</strong>
    EXPECTED
    expect(result).to eql expected_result.chomp.gsub("\n", "")
  end

  it "takes an optional alternative formatter" do
    chunk = <<-CHUNK

Kelly Slater	moved from CF - SF - Routing (Cloud Foundry OSS)	to CF - CHI - Lattice
John John Florence	moved from the farm	to CF - DEN - JARVICE

    CHUNK

    file = StringIO.new(chunk)

    result = AlloAllo::Base.new.format(file, AlloAllo::AllocationConsoleFormatter.new)

    expected_result =
    <<-EXPECTED
New Faces
(DEN) John John Florence, new CF Pivot, joining JARVICE

Rotations
(SF -> CHI) Kelly Slater moves from Routing to Lattice
    EXPECTED
    expect(result).to eql expected_result.chomp
  end
end


