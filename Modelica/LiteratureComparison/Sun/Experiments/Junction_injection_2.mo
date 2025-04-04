within LiteratureComparison.Sun.Experiments;

model Junction_injection_2
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-82, 24}, extent = {{-10, -10}, {10, 10}})));
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  
  package MaterialBath = Materials.water;
  package MaterialPolyanion = Materials.pSPA;
  package MaterialPolycation = Materials.pDADMA;
  
  parameter Real forward_duration = 90;
  parameter Real equilibration_duration = 30;
  parameter Real transition_duration = 0.05;
  parameter Real reverse_duration = 120;
  constant Real D_multiplier_polyanion = 0.84e-3;
  constant Real D_multiplier_polycation = 2e-1;
  parameter Real film_thickness_polyanion = 60e-6;
  parameter Real film_thickness_polycation = 0.4e-6;
  constant Real concentration_ionomer = 200;
  
  constant Real concentration_low = 3;
  constant Real[2] polyanion_concentration = {concentration_ionomer + concentration_low, concentration_low};
  constant Real[2] polycation_concentration = {concentration_low, concentration_ionomer + concentration_low};
  constant Real[2] bath_concentration = {100, 100};
  constant Integer k = 5;
  constant Integer n_seg = 5;
  Modelica.Electrical.Analog.Basic.Ground GND_Electrical annotation(
    Placement(transformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath, species_set = species_set) annotation(
    Placement(transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_b(Ci = {bath_concentration[1]}, redeclare package Material = MaterialBath, species_set = species_set) annotation(
    Placement(transformation(origin = {42, 4}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.01) annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  
  DiodeJunctionInjected diode annotation(
    Placement(transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}})));
  //Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table = {{0, 0}, {equilibration_duration - transition_duration, 0}, {transition_duration, -4}, {equilibration_duration + reverse_duration - transition_duration, -4}, {equilibration_duration + reverse_duration, 4}, {equilibration_duration + reverse_duration + forward_duration, 4}, {equilibration_duration + reverse_duration + forward_duration + transition_duration, -4}}) annotation(
  //  Placement(transformation(origin = {-4, -40}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.Volume injection_volume(redeclare package Material = MaterialBath, species_set = species_set, volume = 1.13e-13, C(each start = 100)) annotation(
    Placement(transformation(origin = {-4, 86}, extent = {{-10, 10}, {10, -10}})));
  Ionics.Basic.InterfaceSharp junction_base(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialPolyanion, V_delta(start = -0.1), V_delta_capped = 0.3, species_set = species_set) annotation(
    Placement(transformation(origin = {-4, 32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = -1) annotation(
    Placement(transformation(origin = {-4, -40}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism injection_connector(redeclare package Material = MaterialBath, area = (5e-6)^2, length = 1e-5, n_seg = 2, species_set = species_set, C_initial = {1, 1}) annotation(
    Placement(transformation(origin = {-4, 58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(GND_Electrical.p, electrode_b.pin_a) annotation(
    Line(points = {{60, -40}, {60, 4}, {52, 4}}, color = {0, 0, 255}));
  connect(resistor.p, electrode_a.pin_a) annotation(
    Line(points = {{-60, -40}, {-78, -40}, {-78, 4}, {-60, 4}}, color = {0, 0, 255}));
  connect(electrode_a.port_b, diode.port_s) annotation(
    Line(points = {{-40, 4}, {-14, 4}}, color = {0, 85, 0}));
  connect(electrode_b.port_b, diode.port_d) annotation(
    Line(points = {{32, 4}, {6, 4}}, color = {0, 85, 0}));
  connect(diode.port_b, junction_base.port_b) annotation(
    Line(points = {{-4, 14}, {-4, 22}}, color = {0, 85, 0}));
  connect(constantVoltage.p, resistor.n) annotation(
    Line(points = {{-14, -40}, {-40, -40}}, color = {0, 0, 255}));
  connect(constantVoltage.n, GND_Electrical.p) annotation(
    Line(points = {{6, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(junction_base.port_a, injection_connector.port_b) annotation(
    Line(points = {{-4, 42}, {-4, 48}}, color = {0, 85, 0}));
  connect(injection_connector.port_a, injection_volume.port) annotation(
    Line(points = {{-4, 68}, {-4, 76}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-100, 100}, {80, -60}})),
    version = "",
    experiment(StartTime = 0, StopTime = 310, Tolerance = 1e-08, Interval = 3.1),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5", variableFilter = ".*"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end Junction_injection_2;