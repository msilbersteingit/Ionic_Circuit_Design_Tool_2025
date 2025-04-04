within NovelCircuitry;

model Actuator_Single_Transistor_Response
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-36, -88}, extent = {{-10, -10}, {10, 10}})));
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
  Ionics.Geometric.UniformPrism oscillator_a_upper_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-80, -88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_lower_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-80, -164}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2, species_set = species_set) annotation(
    Placement(transformation(origin = {-52, -124}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_drain(Ci = {10}, species_set = species_set) annotation(
    Placement(transformation(origin = {-136, -64}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_source(Ci = {10}) annotation(
    Placement(transformation(origin = {-136, -190}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Electrodes.ConcentrationNonPolarizable electrode_base(Ci = {10}, species_set = species_set) annotation(
    Placement(transformation(origin = {-4, -124}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-160, -224}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage V_b annotation(
    Placement(transformation(origin = {32, -166}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.CombiTimeTable base_input_voltage(table = {{0, 0}, {400, 0.5}, {1200, -0.5}, {1600, 0}}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic) annotation(
    Placement(transformation(origin = {74, -166}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Ionics.Composite.NPN_NeutralCenter actuator_enrich_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_2_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter2, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialBath, area_base = 0.5e-3*100e-6, area_source_drain = 0.5e-3*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 2, species_set = species_set) annotation(
    Placement(transformation(origin = {-80, -124}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sources.RampVoltage V_ds(V = 1.0, duration = 100)  annotation(
    Placement(transformation(origin = {-160, -124}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(electrode_drain.port_b, oscillator_a_upper_wire.port_a) annotation(
    Line(points = {{-126, -64}, {-80, -64}, {-80, -78}}, color = {0, 85, 0}));
  connect(electrode_source.port_b, oscillator_a_lower_wire.port_b) annotation(
    Line(points = {{-126, -190}, {-80, -190}, {-80, -174}}, color = {0, 85, 0}));
  connect(electrode_base.port_b, oscillator_a_base_wire.port_b) annotation(
    Line(points = {{-14, -124}, {-42, -124}}, color = {0, 85, 0}));
  connect(ground.p, electrode_source.pin_a) annotation(
    Line(points = {{-160, -214}, {-160, -190}, {-146, -190}}, color = {0, 0, 255}));
  connect(V_b.v, base_input_voltage.y[1]) annotation(
    Line(points = {{44, -166}, {64, -166}}, color = {0, 0, 127}));
  connect(V_b.n, ground.p) annotation(
    Line(points = {{32, -176}, {32, -206}, {-160, -206}, {-160, -214}}, color = {0, 0, 255}));
  connect(V_b.p, electrode_base.pin_a) annotation(
    Line(points = {{32, -156}, {32, -124}, {6, -124}}, color = {0, 0, 255}));
  connect(oscillator_a_upper_wire.port_b, actuator_enrich_npn.port_d) annotation(
    Line(points = {{-80, -98}, {-80, -114}}, color = {0, 85, 0}));
  connect(oscillator_a_base_wire.port_a, actuator_enrich_npn.port_b) annotation(
    Line(points = {{-62, -124}, {-70, -124}}, color = {0, 85, 0}));
  connect(actuator_enrich_npn.port_s, oscillator_a_lower_wire.port_a) annotation(
    Line(points = {{-80, -134}, {-80, -154}}, color = {0, 85, 0}));
  connect(V_ds.p, electrode_drain.pin_a) annotation(
    Line(points = {{-160, -114}, {-160, -64}, {-146, -64}}, color = {0, 0, 255}));
  connect(V_ds.n, ground.p) annotation(
    Line(points = {{-160, -134}, {-160, -214}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-340, -20}, {160, -240}})),
    version = "",
    experiment(StartTime = 0, StopTime = 12000, Tolerance = 1e-08, Interval = 1),
    __OpenModelica_simulationFlags(lv = "-LOG_STDOUT,-LOG_ASSERT,LOG_EVENTS,LOG_STATS", s = "dassl", variableFilter = ".*", jacobian = "coloredSymbolical"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Actuator_Single_Transistor_Response;