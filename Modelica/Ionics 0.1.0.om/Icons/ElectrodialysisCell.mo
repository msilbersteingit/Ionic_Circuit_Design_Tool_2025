within Ionics.Icons;

partial model ElectrodialysisCell
  constant Integer[3] icon_color_electrodialysis_membrane_a = {0, 255, 0};
  constant Integer[3] icon_color_electrodialysis_membrane_b = {255, 0, 0};
  constant Integer[3] icon_color_electrodialysis_bath = {0, 0, 255};
protected
  constant Integer[3] icon_color_electrodialysis_bath_darkened = integer(floor(icon_color_electrodialysis_bath*0.9));
  annotation(
    Icon(graphics = {Rectangle(origin = {58, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, extent = {{-40, 35}, {0, -35}}),
                     Polygon(origin = {58, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, points = {{0, 0}, {-40, 0}, {-70, 10}, {-30, 10}, {0, 0}}),
                     Rectangle(origin = {10, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath_darkened, fillPattern = FillPattern.Solid, extent = {{-40, 35}, {0, -35}}),
                     Polygon(origin = {-46, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, points = {{0, 35}, {-30, 45}, {-30, -25}, {0, -35}, {0, 35}}),
                     Polygon(origin = {10, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath_darkened, fillPattern = FillPattern.Solid, points = {{0, 0}, {-40, 0}, {-70, 10}, {-30, 10}, {0, 0}}),
                     Rectangle(origin = {-30, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_a, fillPattern = FillPattern.Solid, extent = {{-8, 35}, {0, -35}}),
                     Rectangle(origin = {74, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, extent = {{-8, 35}, {0, -35}}),
                     Polygon(origin = {-30, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_a, fillPattern = FillPattern.Solid, points = {{0, 0}, {-8, 0}, {-38, 10}, {-30, 10}, {0, 0}}),
                     Polygon(origin = {18, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_b, fillPattern = FillPattern.Solid, points = {{0, 0}, {-8, 0}, {-38, 10}, {-30, 10}, {0, 0}}),
                     Rectangle(origin = {18, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_b, fillPattern = FillPattern.Solid, extent = {{-8, 35}, {0, -35}}),
                     Polygon(origin = {74, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, points = {{0, 0}, {-8, 0}, {-38, 10}, {-30, 10}, {0, 0}}),
                     Rectangle(origin = {66, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_a, fillPattern = FillPattern.Solid, extent = {{-8, 35}, {0, -35}}),
                     Polygon(origin = {66, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_membrane_a, fillPattern = FillPattern.Solid, points = {{0, 0}, {-8, 0}, {-38, 10}, {-30, 10}, {0, 0}}),
                     Rectangle(origin = {-38, 0}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, extent = {{-8, 35}, {0, -35}}),
                     Polygon(origin = {-38, 35}, lineColor = {0, 85, 0}, fillColor = icon_color_electrodialysis_bath, fillPattern = FillPattern.Solid, points = {{0, 0}, {-8, 0}, {-38, 10}, {-30, 10}, {0, 0}})}));
end ElectrodialysisCell;