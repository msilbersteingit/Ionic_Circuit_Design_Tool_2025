within LiteratureComparison.Berggren.Experiments;

model FullRectifier
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  package MaterialBath = Diode.MaterialBath;
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-104, 104}, extent = {{-10, -10}, {10, 10}})));
  constant Real[2] bath_concentration = Diode.bath_concentration;
  constant Real[2] center_concentration = bath_concentration;
  
  constant Integer k = 5;
  
  Diode diode_a2(film_thickness_polyanion = 0.5e-6) annotation(
    Placement(transformation(origin = {-22, 44}, extent = {{10, -10}, {-10, 10}})));
  Diode diode_b2(film_thickness_polyanion = 0.5e-6) annotation(
    Placement(transformation(origin = {14, 44}, extent = {{-10, -10}, {10, 10}})));
  Diode diode_a1(film_thickness_polyanion = 0.5e-6) annotation(
    Placement(transformation(origin = {-22, 86}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Diode diode_b1(film_thickness_polyanion = 0.5e-6) annotation(
    Placement(transformation(origin = {16, 86}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  
  Ionics.Electrodes.Blocking electrode_a(redeclare package Material = MaterialBath, species_set = species_set, capacitance(displayUnit = "F") = 200, area = 20e-3*30e-3) annotation(
    Placement(transformation(origin = {-56, 64}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.Blocking electrode_b(redeclare package Material = MaterialBath, species_set = species_set, capacitance(displayUnit = "uF") = 2e-4, area = 20e-3*30e-3) annotation(
    Placement(transformation(origin = {46, 64}, extent = {{10, -10}, {-10, 10}})));
  Ionics.Geometric.UniformResistor load(redeclare package Material = MaterialBath, species_set = species_set, area = 100e-6*2e-6, length = 1e-3) annotation(
    Placement(transformation(origin = {-4, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {16, 8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage trapezoidVoltage(V = 8, rising = 1, width = 300, falling = 1, period = 600, nperiod = -1, offset = -4) annotation(
    Placement(transformation(origin = {-24, 18}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(diode_b2.port_b, electrode_b.port_b) annotation(
    Line(points = {{24, 44}, {30, 44}, {30, 64}, {36, 64}}, color = {0, 85, 0}));
  connect(diode_a2.port_a, load.port_b) annotation(
    Line(points = {{-12, 44}, {-4, 44}, {-4, 54}}, color = {0, 85, 0}));
  connect(load.port_a, diode_a1.port_b) annotation(
    Line(points = {{-4, 74}, {-4, 86}, {-12, 86}}, color = {0, 85, 0}));
  connect(electrode_a.port_b, diode_a1.port_a) annotation(
    Line(points = {{-46, 64}, {-38, 64}, {-38, 86}, {-32, 86}}, color = {0, 85, 0}));
  connect(electrode_a.port_b, diode_a2.port_b) annotation(
    Line(points = {{-46, 64}, {-38, 64}, {-38, 44}, {-32, 44}}, color = {0, 85, 0}));
  connect(load.port_a, diode_b1.port_b) annotation(
    Line(points = {{-4, 74}, {-4, 86}, {6, 86}}, color = {0, 85, 0}));
  connect(diode_b1.port_a, electrode_b.port_b) annotation(
    Line(points = {{26, 86}, {26, 87}, {36, 87}, {36, 64}}, color = {0, 85, 0}));
  connect(ground.p, electrode_b.pin_a) annotation(
    Line(points = {{16, 18}, {56, 18}, {56, 64}}, color = {0, 0, 255}));
  connect(trapezoidVoltage.n, ground.p) annotation(
    Line(points = {{-14, 18}, {16, 18}}, color = {0, 0, 255}));
  connect(trapezoidVoltage.p, electrode_a.pin_a) annotation(
    Line(points = {{-34, 18}, {-66, 18}, {-66, 64}}, color = {0, 0, 255}));
  connect(load.port_b, diode_b2.port_a) annotation(
    Line(points = {{-4, 54}, {-4, 44}, {4, 44}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-120, 120}, {120, -20}})),
    version = "",
    experiment(StartTime = 0, StopTime = 1500, Tolerance = 1e-08, Interval = 0.375),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS,LOG_SUCCESS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", cpu = "()", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end FullRectifier;