within LiteratureComparison.Sun;

model DiodeJunctionInjected
  extends Ionics.Interfaces.Transistor(redeclare package MaterialSOuter = MaterialBath, redeclare package MaterialBOuter = MaterialPolyanion, redeclare package MaterialDOuter = MaterialBath, final species_set = Ionics.Species.Ions.Inorganic.NaCl);
  
  extends Ionics.Icons.UniformDiode(icon_color_diode_material_a = MaterialPolyanion.annotation_color,
                                    icon_color_diode_material_b = MaterialPolycation.annotation_color,
                                    icon_color_diode_bath_a = MaterialBath.annotation_color,
                                    icon_color_diode_bath_b = MaterialBath.annotation_color
                                   );
  
  constant Integer[3] annotation_color_a_inner = MaterialPolyanion.annotation_color;
  constant Integer[3] annotation_color_b_inner = MaterialPolycation.annotation_color;
  constant Integer[3] annotation_color_bath = MaterialBath.annotation_color;
  package ActivityModel = Ionics.Materials.Activity.Ideal;
  
  package MaterialBath = Materials.water;
  package MaterialPolyanion = Materials.pSPA;
  package MaterialPolycation = Materials.pDADMA;
  
  Ionics.Geometric.UniformPrism bath_s(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*4.8e-3, length = 1.2e-3, C_initial = bath_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-138, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism bath_d(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*4.8e-3, length = 1.2e-3, C_initial = bath_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {136, 30}, extent = {{-10, -10}, {10, 10}})));
  constant Real D_multiplier_polyanion = 2e-2;
  constant Real D_multiplier_polycation = 2e-2;
  parameter Real film_thickness_polyanion = 50e-6;
  parameter Real film_thickness_polycation = 50e-6;
  parameter Real area_junction_hole = (5e-6)^2;
  constant Real concentration_fixed_polyanion = -Materials.pSPA.q_fixed/Modelica.Constants.F;
  constant Real concentration_fixed_polycation = Materials.pDADMA.q_fixed/Modelica.Constants.F;
  constant Real concentration_low = 50;//bath_concentration/concentration_fixed_polyanion * bath_concentration;
  constant Real[2] polyanion_concentration = {concentration_fixed_polyanion + concentration_low, concentration_low};
  constant Real[2] polycation_concentration = {concentration_low, concentration_fixed_polycation + concentration_low};
  constant Real[2] bath_concentration = {100, 100};
  constant Integer k = 5;
  constant Integer n_seg = 5;
  Ionics.Geometric.UniformPrism polyanion_thin(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 200e-6*film_thickness_polyanion, length = 100e-6, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polyanion_thick(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 670e-6*film_thickness_polyanion, length = 350e-6, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-76, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thin(redeclare package Material = MaterialPolycation, species_set = species_set, area = 200e-6*film_thickness_polycation, length = 100e-6, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {26, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thick(redeclare package Material = MaterialPolycation, species_set = species_set, area = 670e-6*film_thickness_polycation, length = 350e-6, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {62, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_inner(redeclare package MaterialA = MaterialPolyanion, redeclare package MaterialB = MaterialPolycation, species_set = species_set, V_delta(start = -0.1), V_delta_capped = 0.35) annotation(
    Placement(transformation(origin = {-8, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_s(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialPolyanion, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {-108, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_d(redeclare package MaterialA = MaterialPolycation, redeclare package MaterialB = MaterialBath, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {98, 30}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polyanion_injection(C_initial = polyanion_concentration, redeclare package Material = MaterialPolyanion, area = area_junction_hole*10, length = 5e-6, n_seg = 6, species_set = species_set) annotation(
    Placement(transformation(origin = {-18, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(junction_inner.port_b, polycation_thin.port_a) annotation(
    Line(points = {{2, 30}, {16, 30}}, color = {0, 85, 0}));
  connect(polyanion_thin.port_a, polyanion_thick.port_b) annotation(
    Line(points = {{-50, 30}, {-66, 30}}, color = {0, 85, 0}));
  connect(polycation_thick.port_a, polycation_thin.port_b) annotation(
    Line(points = {{52, 30}, {36, 30}}, color = {0, 85, 0}));
  connect(polycation_thick.port_b, junction_outer_d.port_a) annotation(
    Line(points = {{72, 30}, {88, 30}}, color = {0, 85, 0}));
  connect(junction_outer_s.port_b, polyanion_thick.port_a) annotation(
    Line(points = {{-98, 30}, {-86, 30}}, color = {0, 85, 0}));
  connect(bath_d.port_a, junction_outer_d.port_b) annotation(
    Line(points = {{126, 30}, {108, 30}}, color = {0, 85, 0}));
  connect(junction_outer_s.port_a, bath_s.port_b) annotation(
    Line(points = {{-118, 30}, {-128, 30}}, color = {0, 85, 0}));
  connect(junction_inner.port_a, polyanion_thin.port_b) annotation(
    Line(points = {{-18, 30}, {-30, 30}}, color = {0, 85, 0}));
  connect(bath_s.port_a, port_s) annotation(
    Line(points = {{-148, 30}, {-158, 30}, {-158, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(port_d, bath_d.port_b) annotation(
    Line(points = {{100, 0}, {156, 0}, {156, 30}, {146, 30}}, color = {0, 85, 0}));
  connect(junction_inner.port_a, polyanion_injection.port_b) annotation(
    Line(points = {{-18, 30}, {-18, 60}}, color = {0, 85, 0}));
  connect(polyanion_injection.port_a, port_b) annotation(
    Line(points = {{-18, 80}, {-18, 100}, {0, 100}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"),
                     Text(origin = {0, -80}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "Injected Diode")
                     }),
    Diagram(coordinateSystem(extent = {{-160, 120}, {160, -40}})),
    version = "",
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-10, Interval = 0.100025),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end DiodeJunctionInjected;