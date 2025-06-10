within Ionics.Icons;

model UniformDiode
  constant Integer[3] icon_color_diode_material_a = {255, 0, 0};
  constant Integer[3] icon_color_diode_material_b = {0, 255, 0};
  constant Integer[3] icon_color_diode_bath_b = {0, 0, 255};
  constant Integer[3] icon_color_diode_bath_a = {0, 0, 155};
  constant Integer[3] icon_color_diode_outlines = {0, 85, 0};
  annotation(
    Icon(graphics = {Rectangle(origin = {64, -5}, lineColor = {0, 85, 0}, fillColor = icon_color_diode_material_b, fillPattern = FillPattern.Solid, extent = {{-50, 35}, {0, -35}}),
    Polygon(origin = {64, 30}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_material_b, fillPattern = FillPattern.Solid, points = {{0, 0}, {-50, 0}, {-80, 10}, {-30, 10}, {0, 0}}),
    Rectangle(origin = {14, -5}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_material_a, fillPattern = FillPattern.Solid, extent = {{-50, 35}, {0, -35}}),
    Polygon(origin = {-46, 0}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_bath_a, fillPattern = FillPattern.Solid, points = {{0, 30}, {-30, 40}, {-30, -30}, {0, -40}, {0, 40}, {0, 30}}),
    Polygon(origin = {14, 30}, fillColor = icon_color_diode_material_a, fillPattern = FillPattern.Solid, points = {{0, 0}, {-50, 0}, {-80, 10}, {-30, 10}, {0, 0}}),
    Rectangle(origin = {-36, -5}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_bath_a, fillPattern = FillPattern.Solid, extent = {{-10, 35}, {0, -35}}),
    Rectangle(origin = {74, -5}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_bath_b, fillPattern = FillPattern.Solid, extent = {{-10, 35}, {0, -35}}),
    Polygon(origin = {-36, 30}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_bath_a, fillPattern = FillPattern.Solid, points = {{0, 0}, {-10, 0}, {-40, 10}, {-30, 10}, {0, 0}}),
    Line(points = {{-32, -5}, {-10, -5}}, color = icon_color_diode_outlines),
    Polygon(origin = {10, -5}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_outlines, fillPattern = FillPattern.Solid, points = {{-20, 23}, {-20, -23}, {20, 0}, {-20, 23}}),
    Line(origin = {10, -5}, points = {{20, 20}, {20, -20}}, color = icon_color_diode_outlines, thickness = 1),
    Line(points = {{30, -5}, {60, -5}}, color = icon_color_diode_outlines),
    Polygon(origin = {74, 30}, lineColor = icon_color_diode_outlines, fillColor = icon_color_diode_bath_b, fillPattern = FillPattern.Solid, points = {{0, 0}, {-10, 0}, {-40, 10}, {-30, 10}, {0, 0}}),
    Line(points = {{-100, 0}, {-60, 0}}, color = icon_color_diode_outlines),
    Line(points = {{74, 0}, {100, 0}}, color = icon_color_diode_outlines)}));
end UniformDiode;