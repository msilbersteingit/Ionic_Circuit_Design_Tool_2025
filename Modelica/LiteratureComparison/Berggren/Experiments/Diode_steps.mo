within LiteratureComparison.Berggren.Experiments;

model Diode_steps
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-82, 24}, extent = {{-10, -10}, {10, 10}})));
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  package MaterialBath = Diode.MaterialBath;
  
  parameter Real forward_duration = 90;
  parameter Real equilibration_duration = 30;
  parameter Real transition_duration = 0.05;
  parameter Real reverse_duration = 120;
  
  parameter Real film_thickness_polyanion = 0.18e-6;  
  parameter Real film_thickness_polycation = 8.46e-6;
  
  parameter Real voltage_amplitude = 4.0;
  constant Real[2] bath_concentration = diode.bath_concentration;
  
  Modelica.Electrical.Analog.Basic.Ground GND_Electrical annotation(
    Placement(transformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath, species_set = species_set) annotation(
    Placement(transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_b(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath) annotation(
    Placement(transformation(origin = {42, 4}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.01) annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  Diode diode(film_thickness_polyanion = film_thickness_polyanion, film_thickness_polycation = film_thickness_polycation) annotation(
    Placement(transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}})));
  
  Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table = {{0, 0},
  {equilibration_duration - transition_duration, 0}, 
  {transition_duration, -voltage_amplitude},
  {equilibration_duration + reverse_duration - transition_duration, -voltage_amplitude},
  {equilibration_duration + reverse_duration, voltage_amplitude}, 
  {equilibration_duration + reverse_duration + forward_duration, voltage_amplitude}, 
  {equilibration_duration + reverse_duration + forward_duration + transition_duration, -voltage_amplitude},
  {equilibration_duration + reverse_duration + forward_duration + 2*transition_duration, -voltage_amplitude}
  }) annotation(
    Placement(transformation(origin = {-4, -40}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(GND_Electrical.p, electrode_b.pin_a) annotation(
    Line(points = {{60, -40}, {60, 4}, {52, 4}}, color = {0, 0, 255}));
  connect(resistor.p, electrode_a.pin_a) annotation(
    Line(points = {{-60, -40}, {-78, -40}, {-78, 4}, {-60, 4}}, color = {0, 0, 255}));
  connect(electrode_a.port_b, diode.port_a) annotation(
    Line(points = {{-40, 4}, {-14, 4}}, color = {0, 85, 0}));
  connect(electrode_b.port_b, diode.port_b) annotation(
    Line(points = {{32, 4}, {6, 4}}, color = {0, 85, 0}));
  connect(tableVoltage.n, GND_Electrical.p) annotation(
    Line(points = {{6, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(tableVoltage.p, resistor.n) annotation(
    Line(points = {{-14, -40}, {-40, -40}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-100, 40}, {80, -60}})),
    version = "",
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-08, Interval = 4),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5", variableFilter = ".*", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Diode_steps;