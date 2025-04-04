within NovelCircuitry;

model warburg
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.SpeciesSet(records = {Ionics.Species.Ions.Inorganic.Na_p1, Ionics.Species.Ions.Inorganic.Zn_p2, Ionics.Species.Ions.Inorganic.Cl_n1}) annotation(
    Placement(transformation(origin = {86, -4}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism uniformPrism(redeclare package Material = Ionics.Materials.WaterIdeal(D_multiplier= 1), n_seg = 10, area = 1, length = 1e-2, k = 10, C_initial = {1000, 10e-3, 1000 + 2*10e-3}, species_set = species_set)  annotation(
    Placement(transformation(origin = {-16, 14}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_a(redeclare package Material = Ionics.Materials.WaterIdeal, Ci = {1000, 10e-3}, species_set = species_set)  annotation(
    Placement(transformation(origin = {-66, 14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {16, -38}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.Tafel tafel(C_reference = {1000, 10e-3, 1000}, nR = 2, stoichiometry = {{0, -1, 0}, {0, 1, 0}}, rate_exponents = {{0, 1, 0}, {0, 0, 0}}, V_reduction = {0, 0}, J_0 = {1e-1, 1e-1}, redeclare package Material = Ionics.Materials.WaterIdeal, n = {-2, 2}, area = 1, species_set = species_set)  annotation(
    Placement(transformation(origin = {36, 14}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(f = 74438.03013251681, V = 0.001)  annotation(
    Placement(transformation(origin = {-16, -20}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(uniformPrism.port_a, electrode_a.port_b) annotation(
    Line(points = {{-26, 14}, {-56, 14}}, color = {0, 85, 0}));
  connect(tafel.port_b, uniformPrism.port_b) annotation(
    Line(points = {{26, 14}, {-6, 14}}, color = {0, 85, 0}));
  connect(ground.p, tafel.pin_a) annotation(
    Line(points = {{16, -28}, {16, -20}, {66, -20}, {66, 14}, {46, 14}}, color = {0, 0, 255}));
  connect(sineVoltage.p, electrode_a.pin_a) annotation(
    Line(points = {{-26, -20}, {-86, -20}, {-86, 14}, {-76, 14}}, color = {0, 0, 255}));
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-6, -20}, {16, -20}, {16, -28}}, color = {0, 0, 255}));
  annotation(
    uses(Ionics(version = "0.1.0"), Modelica(version = "4.0.0")),
  experiment(StartTime = 0, StopTime = 8.06039599559340884394e-5, Tolerance = 1e-08, Interval = 6e-10),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic ",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end warburg;