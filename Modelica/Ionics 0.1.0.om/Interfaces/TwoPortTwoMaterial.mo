within Ionics.Interfaces;
partial model TwoPortTwoMaterial
  import Modelica.Constants;
  replaceable package MaterialA = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  replaceable package MaterialB =  Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  replaceable constant Species.SpeciesSet species_set = Species.Ions.Inorganic.NaCl annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  
  parameter SI.Temperature T = 293.15;
  

  constant Boolean no_accumulation = false;
  
  // Get the constants we need from material A. These should be the same as for B, since we're using the same species sets for them
  constant Integer nC = MaterialA.nC;
  constant Integer nCi = MaterialA.nCi;
  constant Species.ChargeNumber[nC] z = MaterialA.z;
  
  constant Integer[3] annotation_color_a = MaterialA.annotation_color;
  constant Integer[3] annotation_color_b = MaterialB.annotation_color;
  
  Ionics.Interfaces.DiffusionPort port_a(redeclare package Material = MaterialA) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ionics.Interfaces.DiffusionPort port_b(redeclare package Material = MaterialB) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  MaterialA.BaseProperties material_state_a;
  MaterialB.BaseProperties material_state_b;
  
  //SI.MolarConcentration[nC] C_delta(each stateSelect = StateSelect.never) annotation(__OpenModelica_tearingSelect=always);
  //SI.MolarConcentration[nCi] Ci_delta(each stateSelect = StateSelect.never) annotation(__OpenModelica_tearingSelect=always);
  SI.Voltage V_delta(start = 0);
  SI.Current i; 
  
equation
  //Tie port states to material states
  material_state_a.Ci = port_a.Ci;
  material_state_a.T = T;
  material_state_b.Ci = port_b.Ci;
  material_state_b.T = T;
  
  //Compute helper variables
  V_delta  = port_a.V - port_b.V;
  i = sum(port_a.j .* z)*Constants.F;
  
  //if ions aren't allowed to accumulate inside, then the fluxes on both sides must be equal and opposite
  if no_accumulation then
    port_a.j = -port_b.j;
  end if;

  
end TwoPortTwoMaterial;
