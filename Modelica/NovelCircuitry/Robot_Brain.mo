within NovelCircuitry;

model Robot_Brain
  constant Ionics.Species.SpeciesSet species_set = Ionics.Species.Ions.Inorganic.NaCl annotation(
    Placement(transformation(origin = {-302, -70}, extent = {{-10, -10}, {10, 10}})));
  constant Ionics.Species.SpeciesSet species_set_world = Ionics.Species.SpeciesSet(records = {Ionics.Species.Ions.Inorganic.Na_p1, Ionics.Species.Ions.Inorganic.Cl_n1}) annotation(
    Placement(transformation(origin = {-234, -148}, extent = {{-10, -10}, {10, 10}})));
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
  constant Real[2] bath_concentration_world = {5, 5};
  //  Ionics.Composite.NPN npn(redeclare package MaterialSOuter = MaterialBath, redeclare package MaterialBOuter = MaterialPolyanion, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialDInner = MaterialPolycation, area_source_drain = 1e-7, area_base = 1e-7, length_source = 2e-4, length_drain = 2e-4, length_base = 2e-5, length_center = 2.0e-4, species_set = species_set, C_initial_source = polycation_concentration, C_initial_drain = polycation_concentration, C_initial_base = polyanion_concentration) annotation(
  //    Placement(transformation(origin = {-46, -86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Composite.ElectrodialysisCell source_anions(C_initial_bath_a = {300, 300}, C_initial_bath_b = {10, 10}, C_initial_membrane_a = {1, 1.301e3}, C_initial_membrane_b = {1.301e3, 1}, redeclare package Material = Ionics.Materials.WaterIdeal, redeclare package MaterialMembraneA = FAS_30, redeclare package MaterialMembraneB = Nafion_117, area_bath = 30e-3*30e-3, area_membrane = 4e-4*4e-4, cell_count = 7, n_seg = 2, thickness_baths = 2000e-6, thickness_membrane_a = 100e-6, thickness_membrane_b = 100e-6) annotation(
    Placement(transformation(origin = {-320, -136}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Ionics.Basic.Ground ground annotation(
    Placement(transformation(origin = {-260, -218}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Composite.ElectrodialysisCellMismatched source_cations(C_initial_bath_a = {300, 300}, C_initial_bath_b = {10, 10}, C_initial_membrane_a = {1.301e3, 1}, C_initial_membrane_b = {1, 1.301e3}, redeclare package Material = Ionics.Materials.WaterIdeal, redeclare package MaterialMembraneA = Nafion_117, redeclare package MaterialMembraneB = FAS_30, area_bath = 10e-3*10e-3, area_membrane = 4e-4*4e-4, cell_count = 4, n_seg = 2, thickness_baths = 2000e-6, thickness_membrane_a = 100e-6, thickness_membrane_b = 100e-6) annotation(
    Placement(transformation(origin = {-298, -138}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism source_cations_bath_upper(C_initial = {100, 100}, redeclare package Material = MaterialBath, area = 10e-3*1e-3, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = true, length = 10e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-288, -108}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism source_bath_upper(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-3*10e-3, initial_source_of_right_concentration_truth = true, length = 10e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-298, -38}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism source_bath_lower(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-3*10e-3, initial_source_of_right_concentration_truth = true, length = 10e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-304, -186}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism source_cations_lower_prism(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-298, -162}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Basic.Capacitor sensor_capacitor_a(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialBath, area = 0.00602, species_set_a = species_set, species_set_b = species_set_world) annotation(
    Placement(transformation(origin = {88, -62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism sensor_wire_a(C_initial = bath_concentration_world, redeclare package Material = MaterialBath, area = 1e-9, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 5e-4, species_set = species_set_world, k = 1) annotation(
    Placement(transformation(origin = {98, -92}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.Capacitor sensor_capacitor_b(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialBath, area = 0.00602, species_set_a = species_set, species_set_b = species_set_world) annotation(
    Placement(transformation(origin = {140, -62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism sensor_wire_b(C_initial = bath_concentration_world, redeclare package Material = MaterialBath, area = 1e-9, initial_source_of_left_concentration_truth = false, initial_source_of_right_concentration_truth = true, length = 5e-4, species_set = species_set_world, k = 1) annotation(
    Placement(transformation(origin = {132, -92}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism sensor_wire_world(C_initial = bath_concentration_world, redeclare package Material = MaterialBath, area = 1e-3*3e-5, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 3e-5, species_set = species_set_world) annotation(
    Placement(transformation(origin = {114, -120}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism actuator_bilayer(C_initial = {10, 10}, redeclare package Material = MaterialSwelling, area = 100e-6*1e-3, initial_source_of_left_concentration_truth = true, length = 2e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-220, -110}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp actuator_interface_membrane_bilayer(redeclare package MaterialA = MaterialPolyanion, redeclare package MaterialB = MaterialSwelling, V_delta(start = -0.1)) annotation(
    Placement(transformation(origin = {-234, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism actuator_membrane_polyanion(C_initial = polyanion_concentration, redeclare package Material = MaterialPolyanion, area = 1e-3*1e-3, initial_source_of_right_concentration_truth = false, length = 100e-6, n_seg = 2) annotation(
    Placement(transformation(origin = {-246, -50}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp actuator_interface_power_membrane(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialPolyanion) annotation(
    Placement(transformation(origin = {-256, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Ionics.Composite.NPN_NeutralCenter actuator_enrich_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_2_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter2, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialSwelling, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialBath, area_base = 0.5e-3*100e-6, area_source_drain = 0.5e-3*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 2, species_set = species_set) annotation(
    Placement(transformation(origin = {-186, -138}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Ionics.Geometric.UniformPrism actuator_enrich_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 2e-8, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-156, -138}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism actuator_enrich_lower_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {-186, -168}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Composite.NPN_NeutralCenter actuator_deplete_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_2_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter2, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialSwelling, area_base = 0.5e-3*100e-6, area_source_drain = 0.5e-3*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 2, species_set = species_set) annotation(
    Placement(transformation(origin = {-186, -84}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Ionics.Geometric.UniformPrism actuator_deplete_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-8, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-156, -84}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism actuator_deplete_upper_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {-186, -54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Basic.Capacitor actuator_enrich_base_capacitor(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialBath, V_delta(start = 0), area = 0.000075, species_set_a = species_set, species_set_b = species_set) annotation(
    Placement(transformation(origin = {-118, -136}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism actuator_enrich_base_pulldown(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1.0e-10, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-142, -166}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Composite.NPN_NeutralCenter oscillator_a_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialBath, area_base = 100e-6*100e-6, area_source_drain = 100e-6*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {-76, -136}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Ionics.Geometric.UniformPrism oscillator_b_upper_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-9, initial_source_of_right_concentration_truth = true, length = 1.0e-3, n_seg = 3, k = 1) annotation(
    Placement(transformation(origin = {46, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_upper_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-9, initial_source_of_right_concentration_truth = true, length = 1.0e-3, n_seg = 3, k = 1) annotation(
    Placement(transformation(origin = {-76, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_lower_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {-76, -164}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Basic.Capacitor oscillator_a_capacitor(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialBath, V_delta(start = 0), area = 0.0002, species_set_a = species_set, species_set_b = species_set) annotation(
    Placement(transformation(origin = {-54, -96}, extent = {{-10, 10}, {10, -10}})));
  Ionics.Composite.NPN_NeutralCenter oscillator_b_npn(C_initial_base = polyanion_concentration, C_initial_center = polyanion_center_concentration, C_initial_drain = polycation_concentration, C_initial_source = polycation_concentration, redeclare package MaterialBInner = MaterialPolyanion, redeclare package MaterialBOuter = MaterialBath, redeclare package MaterialCenter = MaterialPolyanionCenter, redeclare package MaterialDInner = MaterialPolycation, redeclare package MaterialDOuter = MaterialBath, redeclare package MaterialSInner = MaterialPolycation, redeclare package MaterialSOuter = MaterialBath, area_base = 100e-6*100e-6, area_source_drain = 100e-6*20e-6, length_base = 100e-6, length_center = 100e-6, length_center_base = 10e-6, length_drain = 100e-6, length_source = 100e-6, n_seg = 3, species_set = species_set) annotation(
    Placement(transformation(origin = {46, -136}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_b_lower_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {46, -166}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_a_pullup(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1.2e-10, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {-30, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_b_pullup(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1.2e-10, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 3) annotation(
    Placement(transformation(origin = {-2, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism oscillator_b_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_right_concentration_truth = true, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {14, -136}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism oscillator_a_base_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 1e-6, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-48, -136}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.Capacitor oscillator_b_capacitor(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialBath, area = 0.0002, species_set_a = species_set, species_set_b = species_set, V_delta(start = 0)) annotation(
    Placement(transformation(origin = {22, -98}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Ionics.Geometric.UniformPrism actuator_bilayer_transistor_connector(C_initial = {10, 10}, redeclare package Material = MaterialSwelling, area = 500e-6*20e-6, initial_source_of_left_concentration_truth = true, length = 100e-6, n_seg = 2) annotation(
    Placement(transformation(origin = {-186, -112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism actuator_enrich_oscillator_wire(C_initial = bath_concentration, redeclare package Material = MaterialBath, area = 2e-8, initial_source_of_left_concentration_truth = true, initial_source_of_right_concentration_truth = false, length = 1e-3, n_seg = 2) annotation(
    Placement(transformation(origin = {-118, -170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Basic.Concentration sensor_external_world_concentration(redeclare package Material = MaterialBath, species_set = species_set_world, Ci = {bath_concentration_world[1]})  annotation(
    Placement(transformation(origin = {114, -154}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(source_cations.port_a, source_cations_bath_upper.port_a) annotation(
    Line(points = {{-298, -128}, {-298, -108}}, color = {0, 85, 0}));
  connect(source_anions.port_b, source_bath_upper.port_a) annotation(
    Line(points = {{-320, -126}, {-320, -38}, {-308, -38}}, color = {0, 85, 0}));
  connect(source_anions.port_a, source_bath_lower.port_a) annotation(
    Line(points = {{-320, -146}, {-320, -186}, {-314, -186}}, color = {0, 85, 0}));
  connect(source_cations_lower_prism.port_b, source_anions.port_a) annotation(
    Line(points = {{-298, -172}, {-320, -172}, {-320, -146}}, color = {0, 85, 0}));
  connect(source_cations_lower_prism.port_a, source_cations.port_b) annotation(
    Line(points = {{-298, -152}, {-298, -148}}, color = {0, 85, 0}));
  connect(sensor_capacitor_a.port_b, sensor_wire_a.port_a) annotation(
    Line(points = {{88, -72}, {88, -92}}, color = {0, 85, 0}));
  connect(sensor_wire_a.port_b, sensor_wire_b.port_a) annotation(
    Line(points = {{108, -92}, {122, -92}}, color = {0, 85, 0}));
  connect(sensor_wire_b.port_b, sensor_capacitor_b.port_b) annotation(
    Line(points = {{142, -92}, {142, -82}, {140, -82}, {140, -72}}, color = {0, 85, 0}));
  connect(sensor_wire_b.port_a, sensor_wire_world.port_a) annotation(
    Line(points = {{122, -92}, {122, -101}, {114, -101}, {114, -110}}, color = {0, 85, 0}));
  connect(actuator_interface_power_membrane.port_b, actuator_membrane_polyanion.port_a) annotation(
    Line(points = {{-256, -86}, {-256, -50}}, color = {0, 85, 0}));
  connect(actuator_interface_membrane_bilayer.port_a, actuator_membrane_polyanion.port_b) annotation(
    Line(points = {{-234, -64}, {-234, -50}, {-236, -50}}, color = {0, 85, 0}));
  connect(actuator_interface_membrane_bilayer.port_b, actuator_bilayer.port_a) annotation(
    Line(points = {{-234, -84}, {-234, -110}, {-230, -110}}, color = {0, 85, 0}));
  connect(actuator_interface_power_membrane.port_a, source_cations_bath_upper.port_b) annotation(
    Line(points = {{-256, -106}, {-256, -108}, {-278, -108}}, color = {0, 85, 0}));
  connect(actuator_enrich_base_wire.port_b, actuator_enrich_base_pulldown.port_a) annotation(
    Line(points = {{-146, -138}, {-142, -138}, {-142, -156}}, color = {0, 85, 0}));
  connect(oscillator_b_base_wire.port_b, oscillator_b_npn.port_b) annotation(
    Line(points = {{24, -136}, {36, -136}}, color = {0, 85, 0}));
  connect(oscillator_b_base_wire.port_a, oscillator_a_capacitor.port_b) annotation(
    Line(points = {{4, -136}, {-14, -136}, {-14, -96}, {-44, -96}}, color = {0, 85, 0}, smooth = Smooth.Bezier));
  connect(oscillator_a_base_wire.port_a, oscillator_a_npn.port_b) annotation(
    Line(points = {{-58, -136}, {-66, -136}}, color = {0, 85, 0}));
  connect(oscillator_a_base_wire.port_b, oscillator_b_capacitor.port_a) annotation(
    Line(points = {{-38, -136}, {-16, -136}, {-16, -98}, {12, -98}}, color = {0, 85, 0}, smooth = Smooth.Bezier));
  connect(oscillator_b_capacitor.port_b, oscillator_b_upper_wire.port_b) annotation(
    Line(points = {{32, -98}, {46, -98}, {46, -84}}, color = {0, 85, 0}));
  connect(oscillator_a_capacitor.port_a, oscillator_a_upper_wire.port_b) annotation(
    Line(points = {{-64, -96}, {-76, -96}, {-76, -84}}, color = {0, 85, 0}));
  connect(oscillator_a_upper_wire.port_a, oscillator_b_upper_wire.port_a) annotation(
    Line(points = {{-76, -64}, {-76, -42}, {46, -42}, {46, -64}}, color = {0, 85, 0}));
  connect(oscillator_a_pullup.port_a, oscillator_a_upper_wire.port_a) annotation(
    Line(points = {{-30, -64}, {-30, -42}, {-76, -42}, {-76, -64}}, color = {0, 85, 0}));
  connect(oscillator_b_pullup.port_a, oscillator_b_upper_wire.port_a) annotation(
    Line(points = {{-2, -64}, {-2, -42}, {46, -42}, {46, -64}}, color = {0, 85, 0}));
  connect(oscillator_b_pullup.port_b, oscillator_b_capacitor.port_a) annotation(
    Line(points = {{-2, -84}, {-2, -98}, {12, -98}}, color = {0, 85, 0}));
  connect(oscillator_a_capacitor.port_b, oscillator_a_pullup.port_b) annotation(
    Line(points = {{-44, -96}, {-30, -96}, {-30, -84}}, color = {0, 85, 0}));
  connect(actuator_deplete_upper_wire.port_a, oscillator_a_upper_wire.port_a) annotation(
    Line(points = {{-186, -44}, {-186, -38}, {-76, -38}, {-76, -64}}, color = {0, 85, 0}));
  connect(actuator_deplete_base_wire.port_b, oscillator_a_capacitor.port_a) annotation(
    Line(points = {{-146, -84}, {-114, -84}, {-114, -96}, {-64, -96}}, color = {0, 85, 0}));
  connect(oscillator_b_capacitor.port_b, sensor_capacitor_a.port_a) annotation(
    Line(points = {{32, -98}, {66, -98}, {66, -52}, {88, -52}}, color = {0, 85, 0}));
  connect(oscillator_a_lower_wire.port_b, oscillator_b_lower_wire.port_b) annotation(
    Line(points = {{-76, -174}, {-76, -186}, {46, -186}, {46, -176}}, color = {0, 85, 0}));
  connect(ground.port, oscillator_a_lower_wire.port_b) annotation(
    Line(points = {{-260, -208}, {-260, -186}, {-76, -186}, {-76, -174}}, color = {0, 85, 0}));
  connect(actuator_deplete_upper_wire.port_a, source_bath_upper.port_b) annotation(
    Line(points = {{-186, -44}, {-186, -38}, {-288, -38}}, color = {0, 85, 0}));
  connect(actuator_bilayer.port_b, actuator_bilayer_transistor_connector.port_b) annotation(
    Line(points = {{-210, -110}, {-202, -110}, {-202, -122}, {-186, -122}}, color = {0, 85, 0}));
  connect(actuator_enrich_base_wire.port_b, actuator_enrich_base_capacitor.port_a) annotation(
    Line(points = {{-146, -138}, {-136, -138}, {-136, -126}, {-118, -126}}, color = {0, 85, 0}));
  connect(actuator_enrich_base_capacitor.port_b, actuator_enrich_oscillator_wire.port_a) annotation(
    Line(points = {{-118, -146}, {-118, -160}}, color = {0, 85, 0}));
  connect(actuator_enrich_oscillator_wire.port_b, oscillator_b_capacitor.port_b) annotation(
    Line(points = {{-118, -180}, {-118, -214}, {66, -214}, {66, -98}, {32, -98}}, color = {0, 85, 0}));
  connect(actuator_deplete_upper_wire.port_b, actuator_deplete_npn.port_d) annotation(
    Line(points = {{-186, -64}, {-186, -74}}, color = {0, 85, 0}));
  connect(actuator_deplete_npn.port_s, actuator_bilayer_transistor_connector.port_a) annotation(
    Line(points = {{-186, -94}, {-186, -102}}, color = {0, 85, 0}));
  connect(actuator_deplete_base_wire.port_a, actuator_deplete_npn.port_b) annotation(
    Line(points = {{-166, -84}, {-176, -84}}, color = {0, 85, 0}));
  connect(actuator_enrich_base_wire.port_a, actuator_enrich_npn.port_b) annotation(
    Line(points = {{-166, -138}, {-176, -138}}, color = {0, 85, 0}));
  connect(actuator_enrich_npn.port_s, actuator_enrich_lower_wire.port_a) annotation(
    Line(points = {{-186, -148}, {-186, -158}}, color = {0, 85, 0}));
  connect(oscillator_a_lower_wire.port_a, oscillator_a_npn.port_s) annotation(
    Line(points = {{-76, -154}, {-76, -146}}, color = {0, 85, 0}));
  connect(oscillator_a_npn.port_d, oscillator_a_capacitor.port_a) annotation(
    Line(points = {{-76, -126}, {-76, -96}, {-64, -96}}, color = {0, 85, 0}));
  connect(oscillator_b_npn.port_d, oscillator_b_capacitor.port_b) annotation(
    Line(points = {{46, -126}, {46, -98}, {32, -98}}, color = {0, 85, 0}));
  connect(oscillator_b_npn.port_s, oscillator_b_lower_wire.port_a) annotation(
    Line(points = {{46, -146}, {46, -156}}, color = {0, 85, 0}));
  connect(source_bath_lower.port_b, ground.port) annotation(
    Line(points = {{-294, -186}, {-260, -186}, {-260, -208}}, color = {0, 85, 0}));
  connect(ground.port, actuator_enrich_lower_wire.port_b) annotation(
    Line(points = {{-260, -208}, {-260, -186}, {-186, -186}, {-186, -178}}, color = {0, 85, 0}));
  connect(actuator_enrich_base_pulldown.port_b, ground.port) annotation(
    Line(points = {{-142, -176}, {-142, -186}, {-260, -186}, {-260, -208}}, color = {0, 85, 0}));
  connect(actuator_bilayer_transistor_connector.port_b, actuator_enrich_npn.port_d) annotation(
    Line(points = {{-186, -122}, {-186, -128}}, color = {0, 85, 0}));
  connect(oscillator_b_capacitor.port_a, sensor_capacitor_b.port_a) annotation(
    Line(points = {{12, -98}, {10, -98}, {10, -88}, {58, -88}, {58, -48}, {140, -48}, {140, -52}}, color = {0, 85, 0}));
  connect(sensor_wire_world.port_b, sensor_external_world_concentration.port) annotation(
    Line(points = {{114, -130}, {114, -144}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-340, -20}, {160, -240}}), graphics = {Text(origin = {-27, -203}, extent = {{-33, 5}, {33, -5}}, textString = "Oscillator"), Text(origin = {-197, -205}, extent = {{-33, 5}, {33, -5}}, textString = "Actuator"), Rectangle(origin = {-305, -113}, fillColor = {229, 251, 255}, fillPattern = FillPattern.Solid, extent = {{29, 89}, {-29, -89}}), Text(origin = {-305, -209}, extent = {{-33, 5}, {33, -5}}, textString = "Power Supply"), Rectangle(origin = {-191, -114}, fillColor = {255, 252, 234}, fillPattern = FillPattern.Solid, extent = {{83, 82}, {-83, -82}}), Rectangle(origin = {114, -114}, fillColor = {255, 242, 253}, fillPattern = FillPattern.Solid, extent = {{38, 80}, {-38, -80}}), Text(origin = {113, -201}, extent = {{-33, 5}, {33, -5}}, textString = "Sensor"), Rectangle(origin = {-15, -114}, fillColor = {235, 255, 235}, fillPattern = FillPattern.Solid, extent = {{85, 82}, {-85, -82}})}),
    version = "",
    experiment(StartTime = 0, StopTime = 70000, Tolerance = 1e-08, Interval = 10),
    __OpenModelica_simulationFlags(lv = "-LOG_STDOUT,-LOG_ASSERT,LOG_EVENTS,LOG_SOLVER,LOG_STATS", s = "dassl", variableFilter = ".*", jacobian = "coloredSymbolical", idaLS = "klu"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection --parmodauto -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateDynamicJacobian=symbolic");
end Robot_Brain;