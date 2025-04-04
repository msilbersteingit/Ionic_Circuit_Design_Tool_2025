within NovelCircuitry;

model WireEnrichmentBaseCase
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  Ionics.Basic.InterfaceSharp interface_a(redeclare package MaterialA = Ionics.Materials.WaterIdeal, redeclare package MaterialB = NovelCircuitry.Nafion_117_Neutral_Equivalent) annotation(
    Placement(transformation(origin = {-26, 20}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp interface_b(redeclare package MaterialA = NovelCircuitry.Nafion_117_Neutral_Equivalent, redeclare package MaterialB = Ionics.Materials.WaterIdeal) annotation(
    Placement(transformation(origin = {36, 20}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism load(redeclare package Material = NovelCircuitry.Nafion_117_Neutral_Equivalent, C_initial = {10, 10}, initial_source_of_right_concentration_truth = false, length = 1e-4, area = 1e-8, initial_source_of_left_concentration_truth = false, n_seg = 6) annotation(
    Placement(transformation(origin = {4, 20}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(redeclare package Material = Ionics.Materials.WaterIdeal, Ci = {10}) annotation(
    Placement(transformation(origin = {-86, 20}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_b(redeclare package Material = Ionics.Materials.WaterIdeal, Ci = {10}) annotation(
    Placement(transformation(origin = {98, 20}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {60, -34}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism bath_a(C_initial = {10, 10}, redeclare package Material = Ionics.Materials.WaterIdeal, area = 1e-8, initial_source_of_right_concentration_truth = true, length = 1e-3) annotation(
    Placement(transformation(origin = {-54, 20}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism bath_b(C_initial = {10, 10}, redeclare package Material = Ionics.Materials.WaterIdeal, area = 1e-8, initial_source_of_right_concentration_truth = false, length = 1e-3, initial_source_of_left_concentration_truth = true) annotation(
    Placement(transformation(origin = {62, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage source annotation(
    Placement(transformation(origin = {0, -14}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Sources.CombiTimeTable input_table(table = {{0, 0}, {1000, 0}, {1001, 1.0}, {3000, 1.0}, {3001, 0.}}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint)  annotation(
    Placement(transformation(origin = {-34, -38}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ground.p, electrode_b.pin_a) annotation(
    Line(points = {{60, -24}, {60, -14}, {108, -14}, {108, 20}}, color = {0, 0, 255}));
  connect(interface_a.port_b, load.port_a) annotation(
    Line(points = {{-16, 20}, {-6, 20}}, color = {0, 85, 0}));
  connect(interface_b.port_a, load.port_b) annotation(
    Line(points = {{26, 20}, {14, 20}}, color = {0, 85, 0}));
  connect(electrode_a.port_b, bath_a.port_a) annotation(
    Line(points = {{-76, 20}, {-64, 20}}, color = {0, 85, 0}));
  connect(bath_a.port_b, interface_a.port_a) annotation(
    Line(points = {{-44, 20}, {-36, 20}}, color = {0, 85, 0}));
  connect(electrode_b.port_b, bath_b.port_b) annotation(
    Line(points = {{88, 20}, {72, 20}}, color = {0, 85, 0}));
  connect(bath_b.port_a, interface_b.port_b) annotation(
    Line(points = {{52, 20}, {46, 20}}, color = {0, 85, 0}));
  connect(source.p, electrode_a.pin_a) annotation(
    Line(points = {{-10, -14}, {-108, -14}, {-108, 20}, {-96, 20}}, color = {0, 0, 255}));
  connect(source.n, ground.p) annotation(
    Line(points = {{10, -14}, {60, -14}, {60, -24}}, color = {0, 0, 255}));
  connect(input_table.y[1], source.v) annotation(
    Line(points = {{-23, -38}, {0, -38}, {0, -26}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 5000, Tolerance = 1e-06, Interval = 1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*", jacobian = "coloredSymbolical", noEquidistantTimeGrid = "()"),
    Diagram(coordinateSystem(extent = {{-120, 40}, {140, -40}})));
end WireEnrichmentBaseCase;