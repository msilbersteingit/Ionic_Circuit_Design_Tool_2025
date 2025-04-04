within LiteratureComparison.Yossifon;

model Gate_AND_Leak
  extends Ionics.Interfaces.ThreePortThreeMaterial(species_set = Ionics.Species.Ions.Inorganic.NaCl, 
                                                   redeclare package MaterialA = MaterialBath,
                                                   redeclare package MaterialB = MaterialBath,
                                                   redeclare package MaterialC = MaterialBath);
                                                   
  package MaterialBath = Diode.MaterialBath;
  constant Real[2] bath_concentration = Diode.bath_concentration;
  
  //[1.13585940e-06 1.58367072e-06 3.50632975e-07]
  //[1.14491059e-06 1.61073252e-06 4.36490118e-05]
  //[1.14497235e-06 1.61087090e-06 4.31289754e-05]
  
  Ionics.Geometric.UniformResistor leak_a(redeclare package Material = MaterialBath, species_set = species_set, area = 2e-6*2e-6, length = 1.61e-06) annotation(
    Placement(transformation(origin = {-58, 28}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformResistor leak_b(redeclare package Material = MaterialBath, species_set = species_set, area = 2e-6*2e-6, length = 1.15e-06) annotation(
    Placement(transformation(origin = {66, 26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformResistor leak_c(redeclare package Material = MaterialBath, species_set = species_set, area = 2e-6*2e-6, length = 4.31e-05) annotation(
    Placement(transformation(origin = {-22, 72}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Diode diode_a annotation(
    Placement(transformation(origin = {-58, 0}, extent = {{10, -10}, {-10, 10}})));
  Diode diode_b annotation(
    Placement(transformation(origin = {66, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -0)));
  Diode diode_c annotation(
    Placement(transformation(origin = {0, 72}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Ionics.Basic.Volume volume_center(redeclare package Material = Diode.MaterialBath, species_set = species_set, volume = 25e-6*1e-3*1e-3, C(start = bath_concentration))  annotation(
    Placement(transformation(origin = {0, 22}, extent = {{-10, 10}, {10, -10}}, rotation = -180)));
equation
  connect(leak_a.port_b, diode_a.port_a) annotation(
    Line(points = {{-48, 28}, {-48, 0}}, color = {0, 85, 0}));
  connect(leak_a.port_a, diode_a.port_b) annotation(
    Line(points = {{-68, 28}, {-68, 0}}, color = {0, 85, 0}));
  connect(diode_c.port_b, leak_c.port_b) annotation(
    Line(points = {{0, 82}, {-22, 82}}, color = {0, 85, 0}));
  connect(diode_c.port_a, leak_c.port_a) annotation(
    Line(points = {{0, 62}, {-22, 62}}, color = {0, 85, 0}));
  connect(diode_a.port_b, port_a) annotation(
    Line(points = {{-68, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(diode_b.port_a, leak_b.port_a) annotation(
    Line(points = {{56, 0}, {56, 26}}, color = {0, 85, 0}));
  connect(leak_b.port_b, diode_b.port_b) annotation(
    Line(points = {{76, 26}, {76, 0}}, color = {0, 85, 0}));
  connect(diode_b.port_a, volume_center.port) annotation(
    Line(points = {{56, 0}, {28, 0}, {28, 40}, {0, 40}, {0, 32}}, color = {0, 85, 0}));
  connect(volume_center.port, diode_c.port_a) annotation(
    Line(points = {{0, 32}, {0, 62}}, color = {0, 85, 0}));
  connect(diode_a.port_a, volume_center.port) annotation(
    Line(points = {{-48, 0}, {-30, 0}, {-30, 40}, {0, 40}, {0, 32}}, color = {0, 85, 0}));
  connect(diode_b.port_b, port_b) annotation(
    Line(points = {{76, 0}, {100, 0}}, color = {0, 85, 0}));
  connect(diode_c.port_b, port_c) annotation(
    Line(points = {{0, 82}, {0, 100}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-120, 120}, {120, -20}})),
    version = "",
    experiment(StartTime = 0, StopTime = 1200, Tolerance = 1e-08, Interval = 0.3),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS,LOG_SUCCESS", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", cpu = "()", nlssMaxDensity = "0.01"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateSymbolicJacobian ");
end Gate_AND_Leak;