within Ionics.Species;

record SpeciesSet
    constant Species[:] records;
    constant Integer nC = size(records, 1);
    
    annotation(
      Icon(graphics = {Ellipse(origin = {-32, 62}, fillColor = {255, 217, 181}, fillPattern = FillPattern.Solid, extent = {{-36, 36}, {36, -36}}), Line(origin = {-32, 62}, points = {{-20, 0}, {20, 0}}), Line(origin = {-32, 62}, points = {{0, -20}, {0, 20}}), Ellipse(origin = {40, 16}, fillColor = {187, 214, 233}, fillPattern = FillPattern.Solid, extent = {{-27, 27}, {27, -27}}), Line(origin = {40, 16}, points = {{-13, 0}, {13, 0}}), Ellipse(origin = {-23, -20}, fillColor = {217, 217, 217}, fillPattern = FillPattern.Solid, extent = {{-32, 32}, {32, -32}}), Text(origin = {0, -80}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end SpeciesSet;