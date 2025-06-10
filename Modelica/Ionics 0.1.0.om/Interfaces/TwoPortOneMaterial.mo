within Ionics.Interfaces;
partial model TwoPortOneMaterial
  import Modelica.Constants;
  replaceable package Material = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  
  parameter SI.Temperature T = 293.15;
  
  constant Boolean no_accumulation = false;
  
  Ionics.Interfaces.DiffusionPort port_a(redeclare package Material = Material) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_b(redeclare package Material = Material) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  constant Integer nC = Material.nC;
  constant Integer nCi = Material.nCi;
  constant Species.ChargeNumber[nC] z = Material.z;
  
  constant Integer[3] annotation_color = Material.annotation_color;
  
  Material.BaseProperties material_state_a;
  Material.BaseProperties material_state_b;
  
  SI.MolarConcentration[nC] C_delta(each stateSelect = StateSelect.never);
  SI.MolarConcentration[nCi] Ci_delta(each stateSelect = StateSelect.never);
  SI.Voltage V_delta;
  SI.Current i;
  
equation
  //Tie port states to material states
  material_state_a.Ci = port_a.Ci;
  material_state_a.T = T;
  material_state_b.Ci = port_b.Ci;
  material_state_b.T = T;
  
  //Compute helper variables
  V_delta  = port_a.V - port_b.V;
  C_delta = material_state_a.C - material_state_b.C;
  Ci_delta = material_state_a.Ci - material_state_b.Ci;
  i = sum(port_a.j .*z)*Constants.F;
  
  //if ions aren't allowed to accumulate inside, then the fluxes on both sides must be equal

  if no_accumulation then
    port_a.j = -port_b.j;
  end if;

end TwoPortOneMaterial;