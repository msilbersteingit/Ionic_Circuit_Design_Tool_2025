within Ionics.Composite;

model ElectrodialysisCell
  extends Interfaces.TwoPortOneMaterial;
  extends Ionics.Icons.ElectrodialysisCell(icon_color_electrodialysis_membrane_a = MaterialMembraneA.annotation_color, icon_color_electrodialysis_membrane_b = MaterialMembraneB.annotation_color, icon_color_electrodialysis_bath = Material.annotation_color);
  replaceable package MaterialMembraneA = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  replaceable package MaterialMembraneB = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) annotation(
     choicesAllMatching = true,
     Dialog(tab = "General", group = "Material"));
  
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_bath_a = {1.0 for i in 1:nC} annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_bath_b = {10.0 for i in 1:nC} annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_membrane_a annotation(
    Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.MolarConcentration[nC] C_initial_membrane_b annotation(
    Dialog(tab = "Initialization"));
  
  parameter Modelica.Units.SI.Area area_bath = 1 "Cross sectional area of baths" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Area area_membrane = area_bath "Cross sectional area of membranes" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_membrane_a = 10e-6 "Thickness of the polyanion membrane" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_membrane_b = 10e-6 "Thickness of the polyanion membrane" annotation(
    Dialog(tab = "General", group = "Geometry"));
  parameter Modelica.Units.SI.Length thickness_baths = 1e-3 "Thickness of each of the neutral layers" annotation(
    Dialog(tab = "General", group = "Geometry"));
  
  parameter Integer n_seg = 3 "Number of segments for each layer. Higher is better fidelity, but takes longer to simulate" annotation(
    Dialog(tab = "General", group = "Geometry"));
  
  
  parameter Integer cell_count = 1;
  Basic.InterfaceSharp junction_bn_mn(redeclare package MaterialA = Material, redeclare package MaterialB = MaterialMembraneA, species_set = species_set) annotation(
    Placement(transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}})));
  Geometric.UniformPrism membrane_n(redeclare package Material = MaterialMembraneA, species_set = species_set, length = thickness_membrane_a, area = area_membrane, C_initial = C_initial_membrane_a, n_seg = n_seg, initial_source_of_right_concentration_truth = false) annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}})));
  Basic.InterfaceSharp junction_mn_b(redeclare package MaterialA = MaterialMembraneA, redeclare package MaterialB = Material, species_set = species_set, V_delta(start = -0.1)) annotation(
    Placement(transformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}})));
  Ionics.Composite.ElectrodialysisSubCell[cell_count] subcell(each area_bath = area_bath,
                                                              each area_membrane = area_membrane,
                                                              each thickness_membrane_a = thickness_membrane_a,
                                                              each thickness_membrane_b = thickness_membrane_b,
                                                              each species_set = species_set,
                                                              each C_initial_bath_a = C_initial_bath_a,
                                                              each C_initial_bath_b = C_initial_bath_b,
                                                              each C_initial_membrane_a = C_initial_membrane_a,
                                                              each C_initial_membrane_b = C_initial_membrane_b,
                                                              each n_seg = n_seg,
                                                              redeclare package Material = Material,
                                                              redeclare package MaterialMembraneA = MaterialMembraneA,
                                                              redeclare package MaterialMembraneB = MaterialMembraneB
                                                             ) annotation(
    Placement(transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(junction_bn_mn.port_b, membrane_n.port_a) annotation(
    Line(points = {{-4, 0}, {18, 0}}, color = {0, 85, 0}));
  connect(junction_mn_b.port_a, membrane_n.port_b) annotation(
    Line(points = {{52, 0}, {38, 0}}, color = {0, 85, 0}));
  connect(junction_mn_b.port_b, port_b) annotation(
    Line(points = {{72, 0}, {100, 0}}, color = {0, 85, 0}));
  connect(subcell[1].port_a, port_a) annotation(
    Line(points = {{-70, 0}, {-100, 0}}, color = {0, 85, 0}));
  for i in 1:(cell_count - 1) loop
    connect(subcell[i].port_b, subcell[i + 1].port_a);
  end for;
  connect(junction_bn_mn.port_a, subcell[cell_count].port_b) annotation(
    Line(points = {{-24, 0}, {-50, 0}}, color = {0, 85, 0}));
  annotation(
    Diagram,
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"),
    Icon(graphics = {Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name")}));
end ElectrodialysisCell;