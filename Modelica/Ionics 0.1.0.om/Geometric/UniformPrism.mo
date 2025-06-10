within Ionics.Geometric;

model UniformPrism
  extends Interfaces.TwoPortOneMaterial;
  extends Icons.SquarePrism(icon_color_square_prism_main = annotation_color);
  
  parameter SI.Length length = 1 "Length" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Area area = 1 "Cross sectional area" annotation(Dialog(tab="General", group="Geometry"));
  parameter Integer n_seg = 4 "Number of sub-segments" annotation(Dialog(tab="General", group="Geometry"));
  parameter Real k = 10 "Sharpness of element sizing" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.MolarConcentration[nC] C_initial = {1.0 for i in 1:nC} annotation(Dialog(tab = "Initialization"));
  
  parameter Boolean initial_source_of_left_concentration_truth = false annotation(Dialog(tab = "Initialization"), choices(checkBox=true));
  parameter Boolean initial_source_of_right_concentration_truth = true annotation(Dialog(tab = "Initialization"), choices(checkBox=true));
  
  SI.MolarConcentration[n_seg + 1] C1 = volumes.C[1]; // For visualization purposes collect everything in an array
  SI.MolarConcentration[n_seg + 1] C2 = volumes.C[2]; // For visualization purposes collect everything in an array. Hardcoded to just two species
  
  
  SI.Voltage[n_seg + 1] V = volumes.port.V;
  
  // Construct all of the sub-elements and give them the same material
  Geometric.UniformResistor[n_seg] resistors(redeclare package Material = Material,
                                             each species_set = species_set,
                                             length = lengths_resistor,
                                             each area = area) annotation(
    Placement(transformation(origin = {12, 0}, extent = {{-10, -10}, {10, 10}})));
  
  replaceable Basic.Volume[n_seg + 1] volumes constrainedby Basic.Volume(redeclare package Material = Material,
                                  each species_set = species_set,
                                  volume = area*lengths_volume,
                                  each C(start = C_initial),
                                  initial_source_of_concentration_truth = initial_source_of_concentration_truth) annotation(
    Placement(transformation(origin = {-32, 6}, extent = {{-10, 10}, {10, -10}})));

protected
  parameter SI.Length[n_seg + 1] lengths_volume_unnormalized = {1/(exp(-k*i/(n_seg)) + exp(-k*(1 - i/(n_seg)))) for i in 0:n_seg} "Unnormalized istances between volume center";
  parameter SI.Length lengths_volume_unnormalized_sum = sum(lengths_volume_unnormalized) "Distances between volume center";
  parameter SI.Length[n_seg + 1] lengths_volume = length*lengths_volume_unnormalized./lengths_volume_unnormalized_sum "Lengths of sub-segments";
  parameter SI.Length[n_seg] lengths_resistor = {(if i == 1 then 
                                                     lengths_volume[1] + lengths_volume[2]/2 
                                                  elseif i == n_seg then 
                                                     lengths_volume[n_seg + 1] + lengths_volume[n_seg]/2
                                                  else 
                                                     lengths_volume[i]/2 + lengths_volume[i + 1]/2) 
                                                 for i in 1:n_seg} "Lengths of sub-segments";
  
  // Compute which volumes should be treated as constant for initialization
  parameter Boolean[n_seg + 1] initial_source_of_concentration_truth = {(if i == 1 then
                                                                            initial_source_of_left_concentration_truth
                                                                         elseif i == n_seg + 1 then
                                                                            initial_source_of_right_concentration_truth
                                                                         else
                                                                            true) for i in 1:n_seg+1};
public
equation
  connect(volumes[1].port, port_a);
  connect(volumes[n_seg + 1].port, port_b);
  for i in 1:(n_seg) loop
    connect(resistors[i].port_a, volumes[i].port);
    connect(resistors[i].port_b, volumes[i + 1].port);
  end for;
  annotation(
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(origin = {6, -60}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "L=%length"), Text(origin = {6, -100}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "A=%area"), Line(points = {{-100, 0}, {-52, 0}}, color = {0, 85, 0}), Line(points = {{64, 0}, {100, 0}}, color = {0, 85, 0})}),
    Diagram,
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateSymbolicJacobian ",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end UniformPrism;