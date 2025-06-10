within Ionics.Materials.Mobility;

partial package Base
  constant Species.SpeciesSet species_set;
  constant SI.VolumeDensityOfCharge q_fixed;
  
  constant Integer nC;
  constant Real[nC] z = species_set.records.z;
  
  constant Boolean is_state_independent = false;

  replaceable partial record ThermodynamicState "Minimal variable set that is available as input argument to every material function"
    // This will be replaced with each material's definition of of its ThermodynamicState
    extends Modelica.Icons.Record;
  end ThermodynamicState;

  partial function mobility_constant
    extends Modelica.Icons.Function;
    //constant input Species.SpeciesSet species_set;
    output Partial.Types.Mobility[nC] mobility;
    annotation(
      Inline = true);
  end mobility_constant;

  partial function mobility
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    //constant input Species.SpeciesSet species_set;
    output Partial.Types.Mobility[nC] mobility;
    annotation(
      Inline = true,
      smoothOrder = 2);
  end mobility;

end Base;
