within Ionics.Interfaces;
partial model OnePort
  replaceable package Material = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab="General", group="Material"));
  Material.BaseProperties material_state;
  Ionics.Interfaces.DiffusionPort port(redeclare package Material = Material) annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(choicesAllMatching=true, Dialog(tab="General", group="Material"));
  
  parameter SI.Temperature T = 293.15;
  
  constant Integer nC = Material.nC;
  constant Integer nCi = Material.nCi;
  constant Species.ChargeNumber[nC] z = Material.z;
  
  constant Integer[3] annotation_color = Material.annotation_color;
  
equation
  //Connect internal material to port
  material_state.Ci = port.Ci;

  material_state.T = T;
  
end OnePort;