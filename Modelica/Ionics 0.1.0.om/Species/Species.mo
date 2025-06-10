within Ionics.Species;

record Species
    constant String name;
    constant ChargeNumber z "Charge number of the ion";
    
    annotation(
      Icon(graphics = {Ellipse(fillColor = {255, 217, 181}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Line(points = {{0, -40}, {0, 40}}), Line(points = {{-40, 0}, {40, 0}})}));
end Species;
