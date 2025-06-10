within Ionics.Icons;

partial model SquarePrism

constant Integer[3] icon_color_square_prism_main = {240, 240, 240};
constant Integer[3] icon_color_square_prism_outlining = {0, 85, 0};

annotation(
    Icon(graphics = {Rectangle(origin = {14, 0}, lineColor = icon_color_square_prism_outlining, fillColor = icon_color_square_prism_main, fillPattern = FillPattern.Solid, extent = {{-50, 30}, {50, -40}}),
    Polygon(origin = {-36, 0}, lineColor = icon_color_square_prism_outlining, fillColor = icon_color_square_prism_main, fillPattern = FillPattern.Solid, points = {{0, 30}, {-30, 40}, {-30, -30}, {0, -40}, {0, 30}}),
    Polygon(origin = {14, 30}, lineColor = icon_color_square_prism_outlining, fillColor = icon_color_square_prism_main, fillPattern = FillPattern.Solid, points = {{50, 0}, {-50, 0}, {-80, 10}, {20, 10}, {50, 0}})}),
    Diagram);
    
end SquarePrism;