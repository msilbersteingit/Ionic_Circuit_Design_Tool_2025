within LiteratureComparison.Berggren;

model Diode
  extends Ionics.Interfaces.TwoPortOneMaterial(redeclare package Material = MaterialBath,
                                               final species_set = Ionics.Species.Ions.Inorganic.NaCl);
                                               
  extends Ionics.Icons.UniformDiode(icon_color_diode_material_a = MaterialPolyanion.annotation_color,
                                    icon_color_diode_material_b = MaterialPolycation.annotation_color,
                                    icon_color_diode_bath_a = Material.annotation_color,
                                    icon_color_diode_bath_b = Material.annotation_color
                                   );
  
  constant Integer[3] annotation_color_a_inner = MaterialPolyanion.annotation_color;
  constant Integer[3] annotation_color_b_inner = MaterialPolycation.annotation_color;
  
  package MaterialBath = Ionics.Materials.WaterIdeal;
  package MaterialPolyanion = Materials.PEDOT_PSS;
  package MaterialPolycation = Materials.pVBPPh3;
  
  Ionics.Geometric.UniformPrism bath_a(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*4.8e-3, length = 1.2e-3, C_initial = bath_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-134, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism bath_b(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*4.8e-3, length = 1.2e-3, C_initial = bath_concentration, n_seg = n_seg, initial_source_of_left_concentration_truth = false, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {140, -24}, extent = {{-10, -10}, {10, 10}})));
  
  parameter Real film_thickness_polyanion = 0.18e-6;  
  parameter Real film_thickness_polycation = 8.46e-6;
  
  constant Real concentration_fixed_polyanion = -MaterialPolyanion.q_fixed/Modelica.Constants.F;
  constant Real concentration_fixed_polycation = MaterialPolycation.q_fixed/Modelica.Constants.F;
  
  constant Real concentration_low = 3;
  constant Real[2] polyanion_concentration = {concentration_fixed_polyanion + concentration_low, concentration_low};
  constant Real[2] polycation_concentration = {concentration_low, concentration_fixed_polycation + concentration_low};
  constant Real[2] bath_concentration = {100, 100};
  constant Integer k = 5;
  constant Integer n_seg = 5;
  
  Ionics.Geometric.UniformPrism polyanion_thin(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 50e-6*film_thickness_polyanion, length = 1.0e-4, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-36, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polyanion_thick(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 100e-6*film_thickness_polyanion, length = 3.75e-4, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-72, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thin(redeclare package Material = MaterialPolycation, species_set = species_set, area = 50e-6*film_thickness_polycation, length = 1.0e-4, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {30, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thick(redeclare package Material = MaterialPolycation, species_set = species_set, area = 100e-6*film_thickness_polycation, length = 3.75e-4, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {66, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_inner(redeclare package MaterialA = MaterialPolyanion, redeclare package MaterialB = MaterialPolycation, species_set = species_set, V_delta(start = -0.1), V_delta_capped = 0.3) annotation(
    Placement(transformation(origin = {-4, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_a(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialPolyanion, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {-104, -24}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_b(redeclare package MaterialA = MaterialPolycation, redeclare package MaterialB = MaterialBath, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {102, -24}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(junction_inner.port_b, polycation_thin.port_a) annotation(
    Line(points = {{6, -24}, {20, -24}}, color = {0, 85, 0}));
  connect(polyanion_thin.port_a, polyanion_thick.port_b) annotation(
    Line(points = {{-46, -24}, {-62, -24}}, color = {0, 85, 0}));
  connect(polycation_thick.port_a, polycation_thin.port_b) annotation(
    Line(points = {{56, -24}, {40, -24}}, color = {0, 85, 0}));
  connect(polycation_thick.port_b, junction_outer_b.port_a) annotation(
    Line(points = {{76, -24}, {92, -24}}, color = {0, 85, 0}));
  connect(junction_outer_a.port_b, polyanion_thick.port_a) annotation(
    Line(points = {{-94, -24}, {-82, -24}}, color = {0, 85, 0}));
  connect(bath_b.port_a, junction_outer_b.port_b) annotation(
    Line(points = {{130, -24}, {112, -24}}, color = {0, 85, 0}));
  connect(junction_outer_a.port_a, bath_a.port_b) annotation(
    Line(points = {{-114, -24}, {-124, -24}}, color = {0, 85, 0}));
  connect(junction_inner.port_a, polyanion_thin.port_b) annotation(
    Line(points = {{-14, -24}, {-26, -24}}, color = {0, 85, 0}));
  connect(bath_a.port_a, port_a) annotation(
    Line(points = {{-144, -24}, {-156, -24}, {-156, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(bath_b.port_b, port_b) annotation(
    Line(points = {{150, -24}, {150, 0}, {100, 0}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"),
         Text(origin = {6, -64}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "Berggren Diode")
         }),
    Diagram(coordinateSystem(extent = {{-160, 20}, {160, -40}})),
    version = "",
  experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-10, Interval = 0.100025),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end Diode;