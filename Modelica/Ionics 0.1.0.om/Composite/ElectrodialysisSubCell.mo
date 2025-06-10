within Ionics.Composite;

model ElectrodialysisSubCell
  extends Interfaces.TwoPortOneMaterial;
  
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_bath_a = {1.0 for i in 1:nC} annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_bath_b = {10.0 for i in 1:nC} annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_membrane_a annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_membrane_b annotation(
    Dialog(tab = "Initialization"));
  
  replaceable package MaterialMembraneA = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  replaceable package MaterialMembraneB = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  
  parameter Modelica.Units.SI.Area area_bath = 1 "Cross sectional area of baths" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Area area_membrane = area_bath "Cross sectional area of membranes" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_membrane_a = 10e-6 "Thickness of the polyanion membrane" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_membrane_b = 10e-6 "Thickness of the polyanion membrane" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_baths = 1e-3 "Thickness of each of the neutral layers";
  
  parameter Integer n_seg = 3 "Number of segments for each layer. Higher is better fidelity, but takes longer to simulate" annotation(
    Dialog(tab = "General", group = "Geometry"));
  
  Basic.InterfaceSharp junction_a_m1(redeclare package MaterialA = Material, redeclare package MaterialB = MaterialMembraneA, species_set = species_set) annotation(
    Placement(transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}})));
  Geometric.UniformPrism membrane_1(redeclare package Material = MaterialMembraneA, species_set = species_set, length = thickness_membrane_a, area = area_membrane, C_initial = C_initial_membrane_a, n_seg = n_seg, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {-54, 0}, extent = {{-10, 10}, {10, -10}})));
  Geometric.UniformPrism bath_1(redeclare package Material = Material, species_set = species_set, length = thickness_baths, area = area_bath, C_initial = C_initial_bath_a, n_seg = n_seg, initial_source_of_left_concentration_truth = true) annotation(
    Placement(transformation(origin = {-14, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Basic.InterfaceSharp junction_m1_b1(redeclare package MaterialA = MaterialMembraneA, redeclare package MaterialB = Material, species_set = species_set, V_delta(start = -0.1)) annotation(
    Placement(transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}})));
  Basic.InterfaceSharp junction_b1_m2(redeclare package MaterialA = Material, redeclare package MaterialB = MaterialMembraneB, species_set = species_set, V_delta(start = -0.1)) annotation(
    Placement(transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}})));
  Basic.InterfaceSharp junction_m2_b2(redeclare package MaterialA = MaterialMembraneB, redeclare package MaterialB = Material, species_set = species_set) annotation(
    Placement(transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}})));
  Geometric.UniformPrism bath_2(redeclare package Material = Material, area = area_bath, length = thickness_baths, species_set = species_set, C_initial = C_initial_bath_b, n_seg = n_seg, initial_source_of_left_concentration_truth = true) annotation(
    Placement(transformation(origin = {66, 0}, extent = {{-10, 10}, {10, -10}})));
  Geometric.UniformPrism membrane_2(redeclare package Material = MaterialMembraneB, area = area_membrane, length = thickness_membrane_b, species_set = species_set, C_initial = C_initial_membrane_b, n_seg = n_seg, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {26, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
equation
  connect(junction_a_m1.port_a, port_a) annotation(
    Line(points = {{-84, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(junction_a_m1.port_b, membrane_1.port_a) annotation(
    Line(points = {{-64, 0}, {-64, 0}}, color = {0, 85, 0}));
  connect(junction_m1_b1.port_a, membrane_1.port_b) annotation(
    Line(points = {{-44, 0}, {-44, 0}}, color = {0, 85, 0}));
  connect(junction_b1_m2.port_a, bath_1.port_b) annotation(
    Line(points = {{-4, 0}, {-4, 0}}, color = {0, 85, 0}));
  connect(junction_m1_b1.port_b, bath_1.port_a) annotation(
    Line(points = {{-24, 0}, {-24, 0}}, color = {0, 85, 0}));
  connect(bath_2.port_b, port_b) annotation(
    Line(points = {{76, 0}, {100, 0}}, color = {0, 85, 0}));
  connect(junction_m2_b2.port_b, bath_2.port_a) annotation(
    Line(points = {{56, 0}, {56, 0}}, color = {0, 85, 0}));
  connect(junction_b1_m2.port_b, membrane_2.port_a) annotation(
    Line(points = {{16, 0}, {16, 0}}, color = {0, 85, 0}));
  connect(junction_m2_b2.port_a, membrane_2.port_b) annotation(
    Line(points = {{36, 0}, {36, 0}}, color = {0, 85, 0}));
  annotation(
    Diagram,
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end ElectrodialysisSubCell;