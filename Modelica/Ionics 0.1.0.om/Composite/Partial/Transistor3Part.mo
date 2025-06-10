within Ionics.Composite.Partial;

model Transistor3Part
  extends Interfaces.Transistor;
  replaceable package MaterialSInner = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Source connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  replaceable package MaterialBInner = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Base connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  replaceable package MaterialDInner = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Drain connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  
  constant Integer[3] annotation_color_s_inner = MaterialSInner.annotation_color;
  constant Integer[3] annotation_color_b_inner = MaterialBInner.annotation_color;
  constant Integer[3] annotation_color_d_inner = MaterialDInner.annotation_color;
  
  parameter SI.Area area_source_drain = 1 "Cross sectional area of source" annotation(Dialog(tab="General", group="Geometry"));
  //parameter SI.Area area_drain = area_source "Cross sectional area of drain" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Area area_base = 1 "Cross sectional area of base" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_source = 1 "Length of the source prism" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_drain = 1 "Length of the drain prism" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_base = 1 "Length of the base prism" annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Length length_center = 1 "Length of the center prism" annotation(Dialog(tab="General", group="Geometry"));
  parameter Integer n_seg = 4 "Number of sub-segments per internal prism";
  parameter Real k = 10 "Sharpness of element sizing";
  
  parameter SI.MolarConcentration[nC] C_initial_source annotation(Dialog(tab="Initialization"));
  parameter SI.MolarConcentration[nC] C_initial_base annotation(Dialog(tab="Initialization"));
  parameter SI.MolarConcentration[nC] C_initial_drain annotation(Dialog(tab="Initialization"));
  
  Ionics.Geometric.UniformPrism base_prism(C_initial = C_initial_base, redeclare package Material = MaterialBInner, area = area_base, length= length_base, n_seg = n_seg, species_set = species_set) annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Ionics.Geometric.UniformPrism source_prism(C_initial = C_initial_source, redeclare package Material = MaterialSInner, area = area_source_drain, length= length_source, n_seg = n_seg, species_set = species_set, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {-80, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp drain_junction( redeclare package MaterialB = MaterialDInner, species_set = species_set, V_delta(start = -0.1), redeclare package MaterialA = MaterialBInner) annotation(
    Placement(transformation(origin = {52, -60}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Ionics.Basic.InterfaceSharp source_junction(redeclare package MaterialA = MaterialSInner, species_set = species_set, redeclare package MaterialB = MaterialBInner) annotation(
    Placement(transformation(origin = {-48, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism drain_prism(length = length_drain, n_seg = n_seg, C_initial = C_initial_drain, area = area_source_drain, species_set = species_set, redeclare package Material = MaterialDInner, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {82, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism base_prism_inner_a(n_seg = n_seg, C_initial = C_initial_base, length = length_center/2, area = area_source_drain, species_set = species_set, redeclare package Material = MaterialBInner, initial_source_of_right_concentration_truth = false, initial_source_of_left_concentration_truth = true) annotation(
    Placement(transformation(origin = {-18, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Geometric.UniformPrism base_prism_inner_b(length = length_center/2, C_initial = C_initial_base, n_seg = n_seg, area = area_source_drain, species_set = species_set, redeclare package Material = MaterialBInner) annotation(
    Placement(transformation(origin = {20, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp drain_junction_outer( redeclare package MaterialB = MaterialDOuter, species_set = species_set, redeclare package MaterialA = MaterialDInner) annotation(
    Placement(transformation(origin = {114, -60}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Ionics.Basic.InterfaceSharp source_junction_outer(species_set = species_set, redeclare package MaterialB = MaterialSInner, redeclare package MaterialA = MaterialSOuter) annotation(
    Placement(transformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Basic.InterfaceSharp base_junction_outer(redeclare package MaterialA = MaterialBInner, species_set = species_set, redeclare package MaterialB = MaterialBOuter) annotation(
    Placement(transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(source_junction.port_b, base_prism_inner_a.port_a) annotation(
    Line(points = {{-38, -60}, {-28, -60}}, color = {0, 85, 0}));
  connect(source_junction.port_a, source_prism.port_b) annotation(
    Line(points = {{-58, -60}, {-70, -60}}, color = {0, 85, 0}));
  connect(source_prism.port_a, source_junction_outer.port_b) annotation(
    Line(points = {{-90, -60}, {-100, -60}}, color = {0, 85, 0}));
  connect(drain_junction.port_b, drain_prism.port_a) annotation(
    Line(points = {{62, -60}, {72, -60}}, color = {0, 85, 0}));
  connect(drain_junction.port_a, base_prism_inner_b.port_b) annotation(
    Line(points = {{42, -60}, {30, -60}}, color = {0, 85, 0}));
  connect(base_junction_outer.port_a, base_prism.port_a) annotation(
    Line(points = {{0, 66}, {0, 50}}, color = {0, 85, 0}));
  connect(drain_prism.port_b, drain_junction_outer.port_a) annotation(
    Line(points = {{92, -60}, {104, -60}}, color = {0, 85, 0}));
  connect(source_junction_outer.port_a, port_s) annotation(
    Line(points = {{-120, -60}, {-132, -60}, {-132, 0}, {-100, 0}}, color = {0, 85, 0}));
  connect(drain_junction_outer.port_b, port_d) annotation(
    Line(points = {{124, -60}, {134, -60}, {134, 0}, {100, 0}}, color = {0, 85, 0}));
  connect(base_junction_outer.port_b, port_b) annotation(
    Line(points = {{0, 86}, {0, 100}}, color = {0, 85, 0}));
  connect(base_prism_inner_b.port_a, base_prism.port_b) annotation(
    Line(points = {{10, -60}, {0, -60}, {0, 30}}, color = {0, 85, 0}));
  connect(base_prism_inner_a.port_b, base_prism.port_b) annotation(
    Line(points = {{-8, -60}, {0, -60}, {0, 30}}, color = {0, 85, 0}));
  annotation(
    uses(Modelica(version = "4.0.0"), Ionics(version = "0.1.0")),
    Diagram(coordinateSystem(extent = {{-140, 120}, {160, -80}})),
    version = "",
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-10, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", nls = "kinsol", s = "dassl", variableFilter = ".*"),
    Icon(graphics = {Polygon(origin = {-46, 27}, lineColor = {0, 85, 0}, fillColor = annotation_color_s_outer, fillPattern = FillPattern.Solid, points = {{0, 0}, {-10, 0}, {-40, 10}, {-30, 10}, {0, 0}}), Polygon(origin = {-56, -8}, lineColor = {0, 85, 0}, fillColor = annotation_color_s_outer, fillPattern = FillPattern.Solid, points = {{0, 35}, {-30, 45}, {-30, -25}, {0, -35}, {0, 35}}), Rectangle(origin = {-46, -8}, lineColor = {0, 85, 0}, fillColor = annotation_color_s_outer, fillPattern = FillPattern.Solid, extent = {{-10, 35}, {0, -35}}), Rectangle(origin = {-14, -8}, lineColor = {0, 85, 0}, fillColor = annotation_color_s_inner, fillPattern = FillPattern.Solid, extent = {{-32, 35}, {0, -35}}), Polygon(origin = {0, 27}, lineColor = {0, 85, 0}, fillColor = annotation_color_s_inner, fillPattern = FillPattern.Solid, points = {{-14, 0}, {-46, 0}, {-76, 10}, {-44, 10}, {-14, 0}}), Polygon(origin = {90, 27}, lineColor = {0, 85, 0}, fillColor = annotation_color_d_inner, fillPattern = FillPattern.Solid, points = {{-14, 0}, {-50, 0}, {-80, 10}, {-44, 10}, {-14, 0}}), Rectangle(origin = {76, -8}, lineColor = {0, 85, 0}, fillColor = annotation_color_d_inner, fillPattern = FillPattern.Solid, extent = {{-32, 35}, {0, -35}}), Rectangle(origin = {86, -8}, lineColor = {0, 85, 0}, fillColor = annotation_color_d_outer, fillPattern = FillPattern.Solid, extent = {{-10, 35}, {0, -35}}), Polygon(origin = {86, 27}, lineColor = {0, 85, 0}, fillColor = annotation_color_d_outer, fillPattern = FillPattern.Solid, points = {{0, 0}, {-10, 0}, {-40, 10}, {-30, 10}, {0, 0}}), Polygon(origin = {-10, 61}, lineColor = {0, 85, 0}, fillColor = annotation_color_b_inner, fillPattern = FillPattern.Solid, points = {{-4, -34}, {-34, -24}, {-34, 12}, {-4, 2}, {-4, -34}}), Polygon(origin = {-14, 108}, lineColor = {0, 85, 0}, fillColor = annotation_color_b_outer, fillPattern = FillPattern.Solid, points = {{58, -35}, {28, -25}, {-30, -25}, {0, -35}, {58, -35}}), Polygon(origin = {0, 73}, lineColor = {0, 85, 0}, fillColor = annotation_color_b_outer, fillPattern = FillPattern.Solid, points = {{-14, 0}, {-14, -10}, {-44, 0}, {-44, 10}, {-14, 0}}), Rectangle(origin = {44, 68}, lineColor = {0, 85, 0}, fillColor = annotation_color_b_outer, fillPattern = FillPattern.Solid, extent = {{-58, 5}, {0, -5}}), Rectangle(origin = {44, 10}, lineColor = {0, 85, 0}, fillColor = annotation_color_b_inner, fillPattern = FillPattern.Solid, extent = {{-58, 53}, {0, -53}}), Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Line(points = {{0, 100}, {0, 78}}, color = {0, 85, 0}), Line(rotation = -90, points = {{0, 100}, {0, 86}}, color = {0, 85, 0}), Line(rotation = 90, points = {{0, 100}, {0, 72}}, color = {0, 85, 0})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Transistor3Part;