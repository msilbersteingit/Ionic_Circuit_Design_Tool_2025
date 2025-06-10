within Ionics.Basic;

model ConcentrationSignal
  extends Ionics.Interfaces.OnePort;
  Modelica.Blocks.Interfaces.RealInput[Material.nCi] Ci(each unit="mol/m3") annotation (
      Placement(transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, -80}, extent = {{-20, 20}, {20, -20}}, rotation = 90)));
equation
// Concentrations always equal to constant
  material_state.Ci = Ci;
// No current may flow
  sum(port.j.*z) = 0 annotation(
    Icon(graphics = {Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(textColor = {170, 0, 0}, extent = {{-60, 20}, {60, -20}}, textString = "C=%C"), Rectangle(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.27, extent = {{-50, -50}, {50, 50}}), Line(origin = {0, 86}, points = {{0, -36}, {0, 14}}, color = {0, 85, 0})}));
  annotation(
    Diagram,
    Icon(graphics = {Rectangle(lineColor = {0, 85, 0}, fillColor = {222, 222, 222}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-50, 50}, {50, -50}}), Line(points = {{0, 50}, {0, 100}}, color = {0, 85, 0}, thickness = 0.5), Line(points = {{0, -50}, {0, -100}}, color = {0, 0, 255})}));
end ConcentrationSignal;