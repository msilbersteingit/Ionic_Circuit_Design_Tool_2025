within Ionics.Basic;

model VolumeReaction
  extends Interfaces.OnePort;
  //extends Ionics.Interfaces.OnePort(material_state.Ci(each start = 1.0));
  parameter Boolean initial_source_of_concentration_truth = false annotation(
    Dialog(tab = "Initialization"),
    choices(checkBox = true));
  parameter Modelica.Units.SI.Volume volume = 1;
  
  Modelica.Units.SI.MolarConcentration[Material.nC] C(each start = 1, each nominal = 1e-8, fixed = cat(1, fill(initial_source_of_concentration_truth, Material.nCi), {false})) annotation(
    Dialog(tab = "Initialization"));
  Real[Material.nC] der_C(each nominal = 1e-6);
  
  // Reactions
  parameter Integer nR = 1  "Number of chemical reactions";
  parameter Integer[nR, Material.nC] rate_exponents "Exponent of each species in forward reaction's rate limiting step"; //Note that this should actually be activities, but we're not using them at the moment
  parameter Real[nR] rate_constants;
  parameter Integer[nR, Material.nC] stoichiometry "Stoichiometry of each species in overall forward reaction";
  
  SI.MolarFlowRate reaction_rate[nR] "reaction rate of each chemical reaction";
  SI.MolarFlowRate species_creation_rate[nR, Material.nC] "Creation rate of each species in each reaction";
  
protected
equation

  for i loop
    reaction_rate[i] =  (rate_constants[i]
                                   .*product(material_state.C .^ rate_exponents[i])
                                );
                                  
    species_creation_rate[i] = reaction_rate[i].*stoichiometry[i];
  end for;
  
//Set the internal concentration equal to the port material state
//  and to change as the flow of mols times the volume + the chemical reaction rate
// TODO: This might make more sense as a separate meta element that combines chemical reactions with the volume element,
//      so the chemical reaction element can be used elsewhere too as an ion source/sink
  C = material_state.C;
  der_C = der(C);
  volume*der_C = port.j + sum(species_creation_rate[i] for i);

  annotation(
    Icon(graphics = {Rectangle(origin = {0, 25}, rotation = 45, lineColor = {0, 85, 0}, fillColor = annotation_color, fillPattern = FillPattern.Solid, lineThickness = 0.27, extent = {{-55, -55}, {55, 55}}), Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(origin = {0, 26}, textColor = {170, 0, 0}, extent = {{-60, 20}, {60, -20}}, textString = "%volume")}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end VolumeReaction;