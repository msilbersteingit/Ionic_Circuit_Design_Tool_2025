within Ionics.Composite;

model ElectrodialysisCellMismatched
  extends Interfaces.TwoPortOneMaterial;
  extends Icons.ElectrodialysisCellMismatched(icon_color_electrodialysis_membrane_a = MaterialMembraneA.annotation_color, icon_color_electrodialysis_membrane_b = MaterialMembraneB.annotation_color, icon_color_electrodialysis_bath = Material.annotation_color);
  
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
  Composite.ElectrodialysisSubCell[cell_count] subcell(each area_bath = area_bath, each area_membrane = area_membrane, each thickness_membrane_a = thickness_membrane_a, each thickness_membrane_b = thickness_membrane_b, each species_set = species_set, each C_initial_bath_a = C_initial_bath_a, each C_initial_bath_b = C_initial_bath_b, each C_initial_membrane_a = C_initial_membrane_a, each C_initial_membrane_b = C_initial_membrane_b, each n_seg = n_seg, redeclare package Material = Material, redeclare package MaterialMembraneA = MaterialMembraneA, redeclare package MaterialMembraneB = MaterialMembraneB) annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(subcell[1].port_a, port_a) annotation(
    Line(points = {{-12, 0}, {-100, 0}}, color = {0, 85, 0}));
  for i in 1:(cell_count - 1) loop
    connect(subcell[i].port_b, subcell[i + 1].port_a);
  end for;
  connect(port_b, subcell[cell_count].port_b) annotation(
    Line(points = {{100, 0}, {-50, 0}}, color = {0, 85, 0}));
  annotation(
    Diagram,
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"),
    Icon(graphics = {Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name")}));
end ElectrodialysisCellMismatched;