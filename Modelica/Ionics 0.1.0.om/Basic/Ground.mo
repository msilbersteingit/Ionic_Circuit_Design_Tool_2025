within Ionics.Basic;

model Ground
  extends Ionics.Interfaces.OnePort;
equation
//
port.V = 0;
port.j[1:Material.nCi] = {0 for i in 1:nCi};

annotation(
    Icon(graphics = {
      Line(points = {{-40, 30}, {40, 30}}, color = {0, 85, 0}),
      Line(points = {{-60, 50}, {60, 50}}, color = {0, 85, 0}),
      Line(points = {{-20, 10}, {20, 10}}, color = {0, 85, 0}),
      Line(points = {{0, 90}, {0, 50}}, color = {0, 85, 0}),
      Text( textColor = {0, 0, 255},extent = {{-150, -10}, {150, -50}}, textString = "%name")}));
end Ground;