within Ionics.Interfaces;
connector DiffusionPort
    replaceable package Material = Ionics.Materials.Partial.Material annotation(choicesAllMatching=true);
    SI.ElectricPotential V(start = 0.0);
    Materials.Partial.Types.MolarConcentration Ci[Material.nCi](each stateSelect = StateSelect.prefer);
    
    // Include the ion and material names so that we generate assert statements that they are equal.
    //  We're only allowed to implictly connect materials to the same material.
    //  Connecting different materials together requires an explicit interface element.
    constant String[:] species_names = Material.species_names;
    constant String material_name = Material.material_name;
    
    flow Real[Material.nC] j(each nominal = 1e-10, each unit="mol/s", quantity = fill("MolarFlowRate." + Material.material_name + ".", Material.nC ) + Material.species_names);
    annotation(
    Icon(graphics = {
      Rectangle(lineColor={0,85,0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-75, 75}, {75, -75}}),
      Text(origin = {0, -150}, extent = {{-300, 50}, {300, -50}}, textString = DynamicSelect("J[1]", String(((sign(j[1])*3)*(((abs(j[1])/9.5e-12))^0.5)), 2, 0, true))),
      Text(origin = {0, -250}, extent = {{-300, 50}, {300, -50}}, textString = DynamicSelect("J[2]", String(((sign(j[2])*3)*(((abs(j[2])/9.5e-12))^0.5)), 2, 0, true)))
      }),
    Diagram(graphics = {
      Text(textColor = {0, 85, 0}, extent = {{-160, 110}, {40, 50}}, textString = "%name"),
      Rectangle(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}})}));
      
end DiffusionPort;