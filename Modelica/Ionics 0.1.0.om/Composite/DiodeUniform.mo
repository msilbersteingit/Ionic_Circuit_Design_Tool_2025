within Ionics.Composite;

model DiodeUniform
  extends Interfaces.TwoPortTwoMaterial;
  extends Ionics.Icons.UniformDiode(icon_color_diode_material_a = MaterialPolyanion.annotation_color,
                                    icon_color_diode_material_b = MaterialPolycation.annotation_color,
                                    icon_color_diode_bath_a = MaterialA.annotation_color,
                                    icon_color_diode_bath_b = MaterialB.annotation_color
                                  );
                                  
  replaceable package MaterialPolyanion = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.Charge.Polyanion(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  replaceable package MaterialPolycation =  Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Polycation(species_set = species_set) annotation(choicesAllMatching=true, Dialog(tab = "General", group = "Material"));
  
  constant Integer[3] annotation_color_a_inner = MaterialPolyanion.annotation_color;
  constant Integer[3] annotation_color_b_inner = MaterialPolycation.annotation_color;
  
  parameter SI.Area area  = 1 "Cross sectional area" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_polyanion = 1 "Length of the polyanion" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_polycation = 1 "Length of the polyanion" annotation(Dialog(tab="General", group="Geometry"));
  parameter Integer n_seg = 4 "Number of sub-segments" annotation(Dialog(tab="General", group="Geometry"));
  parameter Real k = 10 "Sharpness of element sizing" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.MolarConcentration[nC] C_initial_polyanion = {1.0 for i in 1:nC} annotation(Dialog(tab="Initialization"));
  parameter SI.MolarConcentration[nC] C_initial_polycation = {1.0 for i in 1:nC} annotation(Dialog(tab="Initialization"));
  
  
  Ionics.Geometric.UniformPrism polyanion(redeclare package Material = MaterialPolyanion,
                                          area = area,
                                          length (displayUnit = "m")= length_polyanion,
                                          species_set = species_set,
                                          C_initial = C_initial_polyanion,
                                          n_seg = n_seg,
                                          k = k, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism polycation(redeclare package Material = MaterialPolycation,
                                           area = area,
                                           length (displayUnit = "m")= length_polycation,
                                           species_set = species_set,
                                           C_initial = C_initial_polycation,
                                           n_seg = n_seg,
                                           k = k, initial_source_of_right_concentration_truth = false, initial_source_of_left_concentration_truth = true) annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}})));
  
  Ionics.Basic.InterfaceSharp junction_inner(species_set = species_set,
                                       redeclare package MaterialA = MaterialPolyanion,
                                       redeclare package MaterialB = MaterialPolycation, V_delta(start = -0.1))  annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_a(species_set = species_set,
                                         redeclare package MaterialA = MaterialA,
                                         redeclare package MaterialB = MaterialPolyanion)  annotation(
    Placement(transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp junction_outer_b(species_set = species_set,
                                         redeclare package MaterialA = MaterialPolycation,
                                         redeclare package MaterialB = MaterialB)  annotation(
    Placement(transformation(origin = {66, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(junction_outer_a.port_b, polyanion.port_a) annotation(
    Line(points = {{-58, 0}, {-44, 0}}, color = {0, 85, 0}));
  connect(polyanion.port_b, junction_inner.port_a) annotation(
    Line(points = {{-24, 0}, {-24, 1}, {-12, 1}, {-12, 0}}, color = {0, 85, 0}));
  connect(junction_inner.port_b, polycation.port_a) annotation(
    Line(points = {{8, 0}, {18, 0}}, color = {0, 85, 0}));
  connect(polycation.port_b, junction_outer_b.port_a) annotation(
    Line(points = {{38, 0}, {56, 0}}, color = {0, 85, 0}));
  connect(port_b, junction_outer_b.port_b) annotation(
    Line(points = {{100, 0}, {76, 0}}, color = {0, 85, 0}));
  connect(junction_outer_a.port_a, port_a) annotation(
    Line(points = {{-78, 0}, {-100, 0}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"),
    Text(origin = {6, -64}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "A=%area")}),
    Diagram(coordinateSystem(extent = {{-120, 20}, {120, -20}})),
    version = "",
  experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-8, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");


end DiodeUniform;