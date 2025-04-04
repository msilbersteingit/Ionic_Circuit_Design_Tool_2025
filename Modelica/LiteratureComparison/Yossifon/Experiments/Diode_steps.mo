within LiteratureComparison.Yossifon.Experiments;

model Diode_steps
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-82, 24}, extent = {{-10, -10}, {10, 10}})));
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  package MaterialBath = Diode.MaterialBath;
  constant Real[2] bath_concentration = Diode.bath_concentration;
  parameter Real transition_duration = 0.05;
  parameter Real switching_period = 200;
  Modelica.Electrical.Analog.Basic.Ground GND_Electrical annotation(
    Placement(transformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath, species_set = species_set) annotation(
    Placement(transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_b(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath) annotation(
    Placement(transformation(origin = {42, 4}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.01) annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  Diode diode annotation(
    Placement(transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable base_input(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = {{0, 0}, {200, -1}, {400, 1}, {600, -1}, {800, 0}}, shiftTime = -5) annotation(
    Placement(transformation(origin = {58, -82}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage source annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slew_limit(Rising = 1) annotation(
    Placement(transformation(origin = {18, -82}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(GND_Electrical.p, electrode_b.pin_a) annotation(
    Line(points = {{60, -40}, {60, 4}, {52, 4}}, color = {0, 0, 255}));
  connect(resistor.p, electrode_a.pin_a) annotation(
    Line(points = {{-60, -40}, {-78, -40}, {-78, 4}, {-60, 4}}, color = {0, 0, 255}));
  connect(electrode_a.port_b, diode.port_a) annotation(
    Line(points = {{-40, 4}, {-14, 4}}, color = {0, 85, 0}));
  connect(electrode_b.port_b, diode.port_b) annotation(
    Line(points = {{32, 4}, {6, 4}}, color = {0, 85, 0}));
  connect(source.p, resistor.n) annotation(
    Line(points = {{-10, -40}, {-40, -40}}, color = {0, 0, 255}));
  connect(source.n, GND_Electrical.p) annotation(
    Line(points = {{10, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(base_input.y[1], slew_limit.u) annotation(
    Line(points = {{48, -82}, {30, -82}}, color = {0, 0, 127}));
  connect(slew_limit.y, source.v) annotation(
    Line(points = {{8, -82}, {0, -82}, {0, -52}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-100, 40}, {80, -60}})),
    version = "",
    experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-08, Interval = 1.2),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Diode_steps;