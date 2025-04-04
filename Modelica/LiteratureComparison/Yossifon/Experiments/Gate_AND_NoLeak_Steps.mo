within LiteratureComparison.Yossifon.Experiments;

model Gate_AND_NoLeak_Steps
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-88, -32}, extent = {{-10, -10}, {10, 10}})));
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  package MaterialBath = Diode.MaterialBath;
  constant Real[2] bath_concentration = Diode.bath_concentration;
  
  Modelica.Electrical.Analog.Sources.PulseVoltage source_a(V = 1.0, offset = 0, period = 800, width = 50, startTime = 400) annotation(
    Placement(transformation(origin = {-122, -96}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(Ci = {bath_concentration[1]}, species_set = species_set, redeclare package Material = MaterialBath) annotation(
    Placement(transformation(origin = {-102, -66}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_b(Ci = {bath_concentration[1]}, species_set = species_set, redeclare package Material = MaterialBath) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Basic.Ground GND annotation(
    Placement(transformation(origin = {-140, -140}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.PulseVoltage source_b(V = 1.0, width = 50, period = 800, startTime = 200) annotation(
    Placement(transformation(origin = {-140, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage source_c(V = 1.0) annotation(
    Placement(transformation(origin = {38, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_c(Ci = {bath_concentration[1]}, species_set = species_set, redeclare package Material = MaterialBath) annotation(
    Placement(transformation(origin = {12, -34}, extent = {{10, 10}, {-10, -10}})));
  Gate_AND_NoLeak gate annotation(
    Placement(transformation(origin = {-30, -34}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
equation
  connect(source_a.n, GND.p) annotation(
    Line(points = {{-122, -106}, {-122, -118}, {-140, -118}, {-140, -130}}, color = {0, 0, 255}));
  connect(electrode_a.pin_a, source_a.p) annotation(
    Line(points = {{-112, -66}, {-122, -66}, {-122, -86}}, color = {0, 0, 255}));
  connect(electrode_b.pin_a, source_b.p) annotation(
    Line(points = {{-100, 0}, {-140, 0}, {-140, -38}}, color = {0, 0, 255}));
  connect(source_b.n, GND.p) annotation(
    Line(points = {{-140, -58}, {-140, -130}}, color = {0, 0, 255}));
  connect(source_c.p, electrode_c.pin_a) annotation(
    Line(points = {{38, -64}, {39, -64}, {39, -34}, {22, -34}}, color = {0, 0, 255}));
  connect(source_c.n, GND.p) annotation(
    Line(points = {{38, -84}, {38, -118}, {-140, -118}, {-140, -130}}, color = {0, 0, 255}));
  connect(gate.port_a, electrode_a.port_b) annotation(
    Line(points = {{-30, -44}, {-30, -66}, {-92, -66}}, color = {0, 85, 0}));
  connect(gate.port_b, electrode_b.port_b) annotation(
    Line(points = {{-30, -24}, {-30, 0}, {-80, 0}}, color = {0, 85, 0}));
  connect(gate.port_c, electrode_c.port_b) annotation(
    Line(points = {{-20, -34}, {2, -34}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-160, 40}, {80, -160}})),
    version = "",
    experiment(StartTime = 0, StopTime = 1200, Tolerance = 1e-08, Interval = 0.3),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS,LOG_SUCCESS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", cpu = "()", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Gate_AND_NoLeak_Steps;