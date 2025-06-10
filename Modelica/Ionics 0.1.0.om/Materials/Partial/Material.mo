within Ionics.Materials.Partial;

partial package Material
  constant Integer nC = species_set.nC "Number of mobile species concentrations";
  constant Integer nCi = nC - 1 "Number of structurally independent mobile species concentrations (see docu for details)";
  constant Species.ChargeNumber z[nC] = species_set.records.z;
  constant Species.ChargeNumber zi[nCi] = z[1:nCi];
  constant String[nC] species_names = species_set.records.name;
  constant String material_name;
  constant Integer[3] annotation_color = {240, 240, 240};
  constant SI.VolumeDensityOfCharge q_fixed annotation(
    Dialog);
  constant Species.SpeciesSet species_set = Species.SpeciesSet(records = {Species.Species(name = "Default Species", z = 0)}) annotation(
    Dialog);
 
  constant SI.RelativePermittivity epsilon = 1;
  constant SI.RelativePermittivity epsilon_stern = 1;
  
  constant Boolean has_constant_mobility = MobilityModel.is_state_independent;
  constant Boolean has_constant_activity_coeff = ActivityModel.is_state_independent;
  constant Boolean has_constant_thermal_conductivity = true;
  constant Boolean has_constant_heat_of_transport = true;

  replaceable partial model BaseProperties
    SI.Temperature T;
    //SI.Voltage V(start = 0);
    Types.MolarConcentration C[nC](each nominal=1e-6);
    Types.MolarConcentration Ci[nCi](each nominal=1e-6, each start = 1e-8);
    ThermodynamicState state;
  equation
// All but one ion concentrations are independent (and solvent, which is currently modelled implicitly)
// TODO: We actually need to choose a set of species where the last one doesn't have zero charge. Not just hope it doesn't.
    Ci = C[1:nCi];
// Last species is calculated based on electroneutrality.
// TODO: Let's hope it's not electrically neutral
    sum(C.*z) + q_fixed/Constants.F = 0;
  end BaseProperties;

  replaceable partial record ThermodynamicState "Minimal variable set that is available as input argument to every material function"
    extends Modelica.Icons.Record;
  end ThermodynamicState;

  replaceable partial function electrochemicalPotential "Return electrochemical potential for each mobile species"
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    input SI.Voltage voltage;
    output SI.ChemicalPotential[nC] mu;
  end electrochemicalPotential;
  
  
  replaceable package ActivityModel = Materials.Activity.Ideal constrainedby Activity.Base(redeclare record ThermodynamicState = ThermodynamicState, nC = nC, species_set = species_set, q_fixed = q_fixed) annotation(choicesAllMatching=true);
  replaceable package MobilityModel = Materials.Mobility.TableScaled constrainedby Materials.Mobility.Base(redeclare record ThermodynamicState = ThermodynamicState, nC = nC, species_set = species_set, q_fixed = q_fixed) annotation(choicesAllMatching=true);
  // Need to use Materials.Mobility in the above since Mobility is already defined as a type here. Also true for any material that inherets from this
  
  function log_activity_coeff = ActivityModel.log_activity_coeff; 
  function log_activity_coeff_constant = ActivityModel.log_activity_coeff_constant;
  function mobility_constant = MobilityModel.mobility_constant;
  function mobility = MobilityModel.mobility;
 
  replaceable partial function thermal_conductivity_constant
    extends Modelica.Icons.Function;
    output SI.ThermalConductivity conductivity;
  end thermal_conductivity_constant;
  
  replaceable partial function thermal_conductivity
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output SI.ThermalConductivity conductivity;
  end thermal_conductivity;
  
  replaceable partial function heat_of_transport_constant
    extends Modelica.Icons.Function;
    output SI.Heat heat[nC];
  end heat_of_transport_constant;
  
  replaceable partial function heat_of_transport
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output SI.Heat heat[nC];
  end heat_of_transport;
  
protected
  encapsulated function concatenate "Concatenate strings together for printing"
    input String strings[:];
    output String string;
  algorithm
    string := " {";
    for i in 1:size(strings, 1) loop
      if i == 1 then
        string := string + strings[1];
      else
        string := string + ", " + strings[i];
      end if;
    end for;
    string := string + "}";
  end concatenate;public
  annotation(
    Icon(graphics = {Ellipse(lineColor = {102, 102, 102}, fillColor = annotation_color, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-100, -100}, {100, 100}})}));
end Material;