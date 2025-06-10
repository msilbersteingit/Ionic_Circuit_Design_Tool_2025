within Ionics.Electrodes;

model ConcentrationNonPolarizable
  extends Interfaces.Electrode;
  parameter SI.MolarConcentration[Material.nCi] Ci = fill(1, Material.nCi);
equation
  Ci = material_state_b.Ci;
  V_delta = 0;
// Ignore dielectric charging/displacement current
  i = -sum(port_b.j.*z)*Constants.F;
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(points = {{0, 0}, {-100, 0}}, color = {0, 0, 255}),
                     Line(points = {{0, 0}, {100, 0}}, color = {0, 85, 0}),
                     Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"),
                     Ellipse(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}, startAngle = 90, endAngle = 270, closure = EllipseClosure.Chord),
                     Ellipse(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}, startAngle = -90, endAngle = 90, closure = EllipseClosure.Chord),
                     Rectangle(origin = {50, -55}, lineColor = {0, 85, 0}, fillColor = annotation_color_b, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-25, 25}, {25, -25}}),
                     Line(origin = {70, 20}, points = {{-18, -49}, {-18, -20}}, color = {0, 85, 0}),
                     Text(origin = {0, 36}, textColor = {170, 0, 0}, extent = {{-150, 20}, {150, -20}}, textString = "Ci=%Ci")}));
end ConcentrationNonPolarizable;