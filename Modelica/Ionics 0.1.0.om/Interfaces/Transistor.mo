within Ionics.Interfaces;

partial model Transistor
  import Modelica.Constants;
  replaceable package MaterialSOuter = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Source connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  replaceable package MaterialBOuter = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Base connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  replaceable package MaterialDOuter = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Drain connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  
  constant Integer[3] annotation_color_s_outer = MaterialSOuter.annotation_color;
  constant Integer[3] annotation_color_b_outer = MaterialBOuter.annotation_color;
  constant Integer[3] annotation_color_d_outer = MaterialDOuter.annotation_color;
  
  
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(
    choicesAllMatching = true, Dialog(tab="General", group="Material"));
  parameter SI.Temperature T = 293.15;
  constant Boolean no_accumulation = false;
  // Get the constants we need from material S Outer. These should be the same as for the other materials, since we're using the same species sets for them
  constant Integer nC = MaterialSOuter.nC;
  constant Integer nCi = MaterialSOuter.nCi;
  constant Species.ChargeNumber[nC] z = MaterialSOuter.z;
  Ionics.Interfaces.DiffusionPort port_s(redeclare package Material = MaterialSOuter) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_d(redeclare package Material = MaterialDOuter) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_b(redeclare package Material = MaterialBOuter) annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-0, 100}, extent = {{-10, -10}, {10, 10}})));
  MaterialSOuter.BaseProperties material_state_s(T = T);
  MaterialBOuter.BaseProperties material_state_b(T = T);
  MaterialDOuter.BaseProperties material_state_d(T = T);
equation
//Tie port states to material states
  material_state_s.Ci = port_s.Ci;
  material_state_b.Ci = port_b.Ci;
  material_state_d.Ci = port_d.Ci;

//if ions aren't allowed to accumulate inside, then the fluxes from all ports must sum to zero
  if no_accumulation then
    port_b.j = -port_s.j - port_d.j;
  end if;
end Transistor;