within Ionics.Interfaces;

partial model ThreePortThreeMaterial
  import Modelica.Constants;
  replaceable package MaterialA = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true, Dialog(tab = "General", group = "Material"));
  replaceable package MaterialB = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true, Dialog(tab = "General", group = "Material"));
  replaceable package MaterialC = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true, Dialog(tab = "General", group = "Material"));
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(
    choicesAllMatching = true, Dialog(tab = "General", group = "Material"));
  parameter SI.Temperature T = 293.15;
  constant Boolean no_accumulation = false;
  
  // Get the constants we need from material A. These should be the same as for B and C, since we're using the same species sets for them
  constant Integer nC = MaterialA.nC;
  constant Integer nCi = MaterialA.nCi;
  constant Species.ChargeNumber[nC] z = MaterialA.z;
  Ionics.Interfaces.DiffusionPort port_a(redeclare package Material = MaterialA) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_b(redeclare package Material = MaterialB) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_c(redeclare package Material = MaterialB) annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-0, 100}, extent = {{-10, -10}, {10, 10}})));
  MaterialA.BaseProperties material_state_a;
  MaterialB.BaseProperties material_state_b;
  MaterialC.BaseProperties material_state_c;
equation
//Tie port states to material states
  material_state_a.Ci = port_a.Ci;
  material_state_a.T = T;

  material_state_b.Ci = port_b.Ci;
  material_state_b.T = T;

  material_state_c.Ci = port_c.Ci;
  material_state_c.T = T;
  
//if ions aren't allowed to accumulate inside, then the fluxes from all ports must sum to zero
  if no_accumulation then
    port_a.j = -port_b.j - port_c.j;
  end if;
end ThreePortThreeMaterial;