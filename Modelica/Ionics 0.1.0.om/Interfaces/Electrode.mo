within Ionics.Interfaces;

partial model Electrode
  import Modelica.Constants;
  
  replaceable package Material = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  
  parameter SI.Temperature T = 293.15;
  Ionics.Interfaces.DiffusionPort port_b(redeclare package Material = Material) annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.Pin pin_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  
  Material.BaseProperties material_state_b;
  
  constant Integer nC = Material.nC;
  constant Integer nCi = Material.nCi;
  constant Species.ChargeNumber[nC] z = Material.z;
  
  constant Integer[3] annotation_color_b = Material.annotation_color;
  
  SI.Voltage V_delta;
  SI.Current i;
equation
//Tie port states to material states
  material_state_b.Ci = port_b.Ci;
  material_state_b.T = T;

//Compute helper variables
  V_delta = pin_a.v - port_b.V;
  
  // Tie electrical current to overall current. Derived class must compute i
  pin_a.i = i;
  
end Electrode;
