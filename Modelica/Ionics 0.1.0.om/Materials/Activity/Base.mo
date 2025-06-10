within Ionics.Materials.Activity;
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
  
  type LogActivityCoeff = Real(unit="1");

  partial function log_activity_coeff_constant
    extends Modelica.Icons.Function;
    //constant input Species.SpeciesSet species_set;
    annotation(Inline = true);
    output LogActivityCoeff[nC] log_gamma;
  end log_activity_coeff_constant;

  partial function log_activity_coeff
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    //constant input Species.SpeciesSet species_set;
    annotation(Inline = true, smoothOrder = 2);
    output LogActivityCoeff[nC] log_gamma;
  end log_activity_coeff;
  
  partial function log_activity_coeff_der
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    input ThermodynamicState state_der;
    annotation(Inline = true);
    output Real[nC] log_gamma_der;
  end log_activity_coeff_der;

end Base;