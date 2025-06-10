within Ionics.Composite;

model PNP_NeutralCenter
  extends Partial.Transistor4Part(source_junction(V_delta(start = -0.1)), drain_junction(V_delta(start = 0.1, fixed)), base_junction(V_delta(start = -0.1, fixed)), base_junction_outer(V_delta(start = 0.1, fixed)));
  redeclare replaceable package MaterialSInner = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.Charge.Polyanion(species_set = species_set) "Source connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  redeclare replaceable package MaterialBInner = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Polycation(species_set = species_set) "Base connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  redeclare replaceable package MaterialDInner = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.Charge.Polyanion(species_set = species_set) "Drain connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));
  redeclare replaceable package MaterialCenter = Materials.WaterIdeal constrainedby Materials.Partial.MaterialCategory.BaseCategory(species_set = species_set) "Drain connector material" annotation(
     choicesAllMatching = true, Dialog(tab="General", group="Material"));  
  
  annotation(
    Icon(graphics = {Rectangle(origin = {-24, -15},rotation = 45, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-18, -1.5}, {5, 1.5}}),
    Rectangle(origin = {44, -7}, rotation = -45, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-20, -1.5}, {25, 1.5}}),
    Polygon(origin = {14, 0},lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-16, 6}, {-43, -7}, {-29, -21}, {-16, 6}}),
    Rectangle(origin = {14, 29}, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-1.5, -17}, {1.5, 17}}),
    Rectangle(origin = {14, 10},lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-35, 4}, {35, -4}})
    }));
end PNP_NeutralCenter;