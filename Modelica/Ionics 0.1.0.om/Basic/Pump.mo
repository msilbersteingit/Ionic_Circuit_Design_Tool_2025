within Ionics.Basic;
model Pump
extends Ionics.Interfaces.TwoPortOneMaterial(final no_accumulation = true);
parameter SI.MolarFlowRate[Material.nC] j_fixed;
equation
port_a.j = j_fixed;
annotation(
    Diagram,
    Icon(graphics = {Line(origin = {40, 0},points = {{-100, 0}, {20, 0}}, color = {0, 85, 0}, arrow = {Arrow.None, Arrow.Open}, arrowSize = 15), Text(origin = {0, 34}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(origin = {0, -40}, textColor = {170, 0, 0}, extent = {{-80, 20}, {80, -20}}, textString = "j=%flux"), Ellipse(lineColor = {0, 85, 0},lineThickness = 0.27, extent = {{-100, 100}, {100, -100}})}));
end Pump;