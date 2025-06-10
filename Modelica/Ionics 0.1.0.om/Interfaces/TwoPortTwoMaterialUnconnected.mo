within Ionics.Interfaces;
partial model TwoPortTwoMaterialUnconnected
  import Modelica.Constants;
  replaceable package MaterialA = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set_a) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  replaceable package MaterialB = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set_b) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  replaceable constant Species.SpeciesSet species_set_a = Species.Ions.Inorganic.NaCl annotation(
    choicesAllMatching = true,
    Dialog(tab = "General", group = "Material"));
  replaceable constant Species.SpeciesSet species_set_b = Species.Ions.Inorganic.NaCl annotation(
    choicesAllMatching = true,
    Dialog(tab = "General", group = "Material"));
  
  parameter Modelica.Units.SI.Temperature T = 293.15;
  constant Boolean no_accumulation = false;
  
  constant Integer nC_a = MaterialA.nC;
  constant Integer nCi_a = MaterialA.nCi;
  
  constant Integer nC_b = MaterialB.nC;
  constant Integer nCi_b = MaterialB.nCi;
  
  constant Species.ChargeNumber[nC_a] z_a = MaterialA.z;
  constant Species.ChargeNumber[nC_b] z_b = MaterialB.z;
  
  constant Integer[3] annotation_color_a = MaterialA.annotation_color;
  constant Integer[3] annotation_color_b = MaterialB.annotation_color;
  Interfaces.DiffusionPort port_a(redeclare package Material = MaterialA) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.DiffusionPort port_b(redeclare package Material = MaterialB) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MaterialA.BaseProperties material_state_a;
  MaterialB.BaseProperties material_state_b;
  Modelica.Units.SI.Voltage V_delta(start = 0);
  Modelica.Units.SI.Current i;
equation
//Tie port states to material states
  material_state_a.Ci = port_a.Ci;
  material_state_a.T = T;
  material_state_b.Ci = port_b.Ci;
  material_state_b.T = T;
  
//Compute helper variables
  V_delta = port_a.V - port_b.V;
  i = sum(port_a.j.*z_a)*Constants.F;

end TwoPortTwoMaterialUnconnected;