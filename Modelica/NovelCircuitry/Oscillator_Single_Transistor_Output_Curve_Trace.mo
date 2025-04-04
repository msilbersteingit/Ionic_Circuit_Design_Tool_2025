within NovelCircuitry;

model Oscillator_Single_Transistor_Output_Curve_Trace
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-38, -72}, extent = {{-10, -10}, {10, 10}})));
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  package MaterialBath = Ionics.Materials.WaterIdeal;
  package MaterialPolyanion = polyanion;
  package MaterialPolycation = polycation;
  package MaterialSwelling = Ionics.Materials.WaterIdeal(annotation_color = {245, 255, 200}, material_name = "Swelling Gel");
  package MaterialPolyanionCenter = Ionics.Materials.Aqeous(redeclare package ActivityModel = ActivityModel, q_fixed = -Modelica.Constants.F*400, D_multiplier = 1.0, material_name = "pAMPSA more dilute", annotation_color = {255, 240, 220});
  package MaterialPolyanionCenter2 = Ionics.Materials.Aqeous(redeclare package ActivityModel = ActivityModel, q_fixed = -Modelica.Constants.F*200, D_multiplier = 1.0, material_name = "pAMPSA even more dilute");
  constant Real concentration_ionomer = 2000;
  constant Real concentration_low = 0.025;
  constant Real[2] polyanion_concentration = {concentration_ionomer + concentration_low, concentration_low};
  constant Real[2] polycation_concentration = {concentration_low, concentration_ionomer + concentration_low};
  constant Real[2] polyanion_center_concentration = {410, 10};
  constant Real[2] polyanion_center_2_concentration = {210, 10};
  constant Real[2] bath_concentration = {10, 10};
  constant Real[2] center_concentration = {10, 10};
  constant Real[2] bath_concentration_world = {3, 3};
  //  Ionics.Composite.NPN npn(redeclare package MaterialSOuter = MaterialBath, redeclare package MaterialBOuter = MaterialPolyanion, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialDInner = MaterialPolycation, area_source_drain = 1e-7, area_base = 1e-7, length_source = 2e-4, length_drain = 2e-4, length_base = 2e-5, length_center = 2.0e-4, species_set = species_set, C_initial_source = polycation_concentration, C_initial_drain = polycation_concentration, C_initial_base = polyanion_concentration) annotation(
  //    Placement(transformation(origin = {-46, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Composite.NPN_NeutralCenter oscillator_a_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialBath, area_base = 100e-6*100e-6, area_source_drain = 100e-6*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-82, -108}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Ionics.Geometric.UniformPrism oscillator_a_upper_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-82, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_lower_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-82, -148}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2, species_set = species_set) annotation(
    Placement(transformation(origin = {-54, -108}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_drain(Ci = {10}, species_set = species_set)  annotation(
    Placement(transformation(origin = {-138, -48}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_source(Ci = {10})  annotation(
    Placement(transformation(origin = {-138, -174}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_base(Ci = {10}, species_set = species_set)  annotation(
    Placement(transformation(origin = {-6, -108}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-162, -210}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable base_input(table = {{0, 1e-9}, {1000, 0.5e-6}, {2000, 1e-6}, {3000, 2e-6}, {4000, 3e-6}, {5000, 4e-6}}, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint)  annotation(
    Placement(transformation(origin = {96, -158}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage V_ds annotation(
    Placement(transformation(origin = {-162, -114}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.CombiTimeTable base_input_voltage1(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = {{0, 0}, {500, 2.0}, {1000, 0}}) annotation(
    Placement(transformation(origin = {-218, -114}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent i_b annotation(
    Placement(transformation(origin = {20, -158}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R(displayUnit = "MOhm") = 1e8)  annotation(
    Placement(transformation(origin = {-4, -158}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slew_limit(Rising = 1e-7)  annotation(
    Placement(transformation(origin = {60, -158}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(oscillator_a_base_wire.port_a, oscillator_a_npn.port_b) annotation(
    Line(points = {{-64, -108}, {-72, -108}}, color = {0, 85, 0}));
  connect(oscillator_a_lower_wire.port_a, oscillator_a_npn.port_s) annotation(
    Line(points = {{-82, -138}, {-82, -118}}, color = {0, 85, 0}));
  connect(oscillator_a_upper_wire.port_b, oscillator_a_npn.port_d) annotation(
    Line(points = {{-82, -82}, {-82, -98}}, color = {0, 85, 0}));
  connect(electrode_drain.port_b, oscillator_a_upper_wire.port_a) annotation(
    Line(points = {{-128, -48}, {-82, -48}, {-82, -62}}, color = {0, 85, 0}));
  connect(electrode_source.port_b, oscillator_a_lower_wire.port_b) annotation(
    Line(points = {{-128, -174}, {-82, -174}, {-82, -158}}, color = {0, 85, 0}));
  connect(electrode_base.port_b, oscillator_a_base_wire.port_b) annotation(
    Line(points = {{-16, -108}, {-44, -108}}, color = {0, 85, 0}));
  connect(ground.p, electrode_source.pin_a) annotation(
    Line(points = {{-162, -200}, {-162, -174}, {-148, -174}}, color = {0, 0, 255}));
  connect(V_ds.p, electrode_drain.pin_a) annotation(
    Line(points = {{-162, -104}, {-162, -48}, {-148, -48}}, color = {0, 0, 255}));
  connect(V_ds.n, ground.p) annotation(
    Line(points = {{-162, -124}, {-162, -200}}, color = {0, 0, 255}));
  connect(base_input_voltage1.y[1], V_ds.v) annotation(
    Line(points = {{-207, -114}, {-174, -114}}, color = {0, 0, 127}));
  connect(i_b.n, electrode_base.pin_a) annotation(
    Line(points = {{20, -148}, {20, -108}, {4, -108}}, color = {0, 0, 255}));
  connect(i_b.p, ground.p) annotation(
    Line(points = {{20, -168}, {20, -194}, {-162, -194}, {-162, -200}}, color = {0, 0, 255}));
  connect(resistor.p, i_b.n) annotation(
    Line(points = {{-4, -148}, {-4, -134}, {20, -134}, {20, -148}}, color = {0, 0, 255}));
  connect(i_b.p, resistor.n) annotation(
    Line(points = {{20, -168}, {20, -194}, {-4, -194}, {-4, -168}}, color = {0, 0, 255}));
  connect(slew_limit.y, i_b.i) annotation(
    Line(points = {{49, -158}, {31, -158}}, color = {0, 0, 127}));
  connect(base_input.y[1], slew_limit.u) annotation(
    Line(points = {{85, -158}, {71, -158}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-340, -20}, {160, -240}})),
    version = "",
    experiment(StartTime = 0, StopTime = 6000, Tolerance = 1e-08, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "-LOG_STDOUT,-LOG_ASSERT,LOG_EVENTS,LOG_STATS", s = "dassl", variableFilter = ".*", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Oscillator_Single_Transistor_Output_Curve_Trace;