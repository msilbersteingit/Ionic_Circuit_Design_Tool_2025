within Ionics.Composite;

model NPN
  extends Partial.Transistor3Part(drain_junction(V_delta(start = -0.1, fixed)), source_junction_outer(V_delta(start = -0.1, fixed)), base_junction_outer(V_delta(start = -0.1, fixed)));
  redeclare replaceable package MaterialSInner = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Polyanion(species_set = species_set) "Source connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material"));
  redeclare replaceable package MaterialBInner = Materials.IdealPolyAnion constrainedby Materials.Partial.MaterialCategory.Charge.Polycation(species_set = species_set) "Base connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material"));
  redeclare replaceable package MaterialDInner = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Polyanion(species_set = species_set) "Drain connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material"));
   
  
  annotation(
    Icon(graphics = {Rectangle(origin = {-4, 5},rotation = 45, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-18, -1.5}, {5, 1.5}}),
    Rectangle(origin = {44, -7}, rotation = -45, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-20, -1.5}, {25, 1.5}}),
    Polygon(origin = {14, 0},lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-50, -28}, {-37, 1}, {-21, -15}, {-50, -28}}),
    Rectangle(origin = {14, 29}, lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-1.5, -17}, {1.5, 17}}),
    Rectangle(origin = {14, 10},lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-35, 4}, {35, -4}})
    }));
end NPN;