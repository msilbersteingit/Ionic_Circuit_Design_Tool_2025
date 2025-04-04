within LiteratureComparison.Yossifon;

model Diode
  extends Ionics.Interfaces.TwoPortOneMaterial(redeclare package Material = MaterialBath,
                                               final species_set = Ionics.Species.Ions.Inorganic.NaCl);
                                               
  extends Ionics.Icons.UniformDiode(icon_color_diode_material_a = MaterialPolyanion.annotation_color,
                                    icon_color_diode_material_b = MaterialPolycation.annotation_color,
                                    icon_color_diode_bath_a = Material.annotation_color,
                                    icon_color_diode_bath_b = Material.annotation_color
                                    );
  
  package MaterialBath = Ionics.Materials.WaterIdeal;
  package MaterialPolyanion = pAMPSA;
  package MaterialPolycation = pDADMA;
  
  //[ 4.28446833e-03  2.08901748e-04  8.64807688e-04 -5.77009258e+03  1.44471873e+03  3.58098801e-01  1.66957016e-01] Best fit for just forward
  //[ 4.17532748e-03  2.34153561e-04  9.91311761e-04 -5.89373980e+02 9.18530465e+02  1.39205578e-01  1.73224261e-01]
  
  
  Ionics.Geometric.UniformPrism bath_a(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*6e-3, length = 4.2e-3, C_initial = bath_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-140, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism bath_b(redeclare package Material = MaterialBath, species_set = species_set, area = 25e-6*6e-3, length = 4.2e-3, C_initial = bath_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {134, -26}, extent = {{-10, -10}, {10, 10}})));
  
  constant Real concentration_fixed_polyanion = -MaterialPolyanion.q_fixed/Modelica.Constants.F;
  constant Real concentration_fixed_polycation = MaterialPolycation.q_fixed/Modelica.Constants.F;
  constant Real concentration_low = bath_concentration/concentration_fixed_polyanion * bath_concentration / 2;
  
  constant Real[2] polyanion_concentration = {concentration_fixed_polyanion + concentration_low, concentration_low};
  constant Real[2] polycation_concentration = {concentration_low, concentration_fixed_polycation + concentration_low};
  
  constant Real[2] bath_concentration = {10, 10};
  constant Integer k = 5;
  constant Integer n_seg = 5;
  
  Ionics.Geometric.UniformPrism polyanion_thin(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 25e-6*880e-6, length = 110e-6, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-42, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polyanion_thick(redeclare package Material = MaterialPolyanion, species_set = species_set, area = 25e-6*1030e-6, length = 110e-6, C_initial = polyanion_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {-78, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thin(redeclare package Material = MaterialPolycation, species_set = species_set, area = 25e-6*1150e-6, length = 500e-6, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {24, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation_thick(redeclare package Material = MaterialPolycation, species_set = species_set, area = 25e-6*1860e-6, length = 500e-6, C_initial = polycation_concentration, n_seg = n_seg) annotation(
    Placement(transformation(origin = {60, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_inner(redeclare package MaterialA = MaterialPolyanion, redeclare package MaterialB = MaterialPolycation, species_set = species_set, V_delta(start = -0.1)) annotation(
    Placement(transformation(origin = {-10, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_a(redeclare package MaterialA = MaterialBath, redeclare package MaterialB = MaterialPolyanion, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {-110, -26}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_b(redeclare package MaterialA = MaterialPolycation, redeclare package MaterialB = MaterialBath, species_set = species_set, V_delta(start = 0.1)) annotation(
    Placement(transformation(origin = {96, -26}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(junction_inner.port_b, polycation_thin.port_a) annotation(
    Line(points = {{0, -26}, {14, -26}}, color = {0, 85, 0}));
  connect(polyanion_thin.port_a, polyanion_thick.port_b) annotation(
    Line(points = {{-52, -26}, {-68, -26}}, color = {0, 85, 0}));
  connect(polycation_thick.port_a, polycation_thin.port_b) annotation(
    Line(points = {{50, -26}, {34, -26}}, color = {0, 85, 0}));
  connect(polycation_thick.port_b, junction_outer_b.port_a) annotation(
    Line(points = {{70, -26}, {86, -26}}, color = {0, 85, 0}));
  connect(junction_outer_a.port_b, polyanion_thick.port_a) annotation(
    Line(points = {{-100, -26}, {-88, -26}}, color = {0, 85, 0}));
  connect(bath_b.port_a, junction_outer_b.port_b) annotation(
    Line(points = {{124, -26}, {106, -26}}, color = {0, 85, 0}));
  connect(junction_outer_a.port_a, bath_a.port_b) annotation(
    Line(points = {{-120, -26}, {-130, -26}}, color = {0, 85, 0}));
  connect(junction_inner.port_a, polyanion_thin.port_b) annotation(
    Line(points = {{-20, -26}, {-32, -26}}, color = {0, 85, 0}));
  connect(bath_a.port_a, port_a) annotation(
    Line(points = {{-150, -26}, {-156, -26}, {-156, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(bath_b.port_b, port_b) annotation(
    Line(points = {{144, -26}, {152, -26}, {152, 0}, {100, 0}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"),
Text(origin = {0, -80}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "Yossifon Diode")}),
    Diagram(coordinateSystem(extent = {{-160, 20}, {160, -40}})),
    version = "",
  experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-10, Interval = 0.100025),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*", noEquidistantTimeGrid = "()", idaMaxNonLinIters = "5"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,evaluateAllParameters,NLSanalyticJacobian --generateSymbolicJacobian ");
end Diode;