within Ionics.Basic;

model Volume
  extends Ionics.Interfaces.OnePort;

  parameter Boolean initial_source_of_concentration_truth = false annotation(Dialog(tab = "Initialization"), choices(checkBox=true));
  
  parameter SI.Volume volume = 1;
  
  SI.MolarConcentration[Material.nC] C(each start = 1, 
                                       each nominal = 1e-8,
                                       fixed = cat(1, fill(initial_source_of_concentration_truth, Material.nCi), {false})) annotation(Dialog(tab = "Initialization"));
                                       
  Real[Material.nC] der_C(each nominal = 1e-6);
  
protected
  

  
equation
//Set the internal concentration equal to the port material state
//  and to change as the flow of mols times the volume
  C = material_state.C;
  der_C = der(C);
  volume*der_C = port.j;

  annotation(
    Icon(graphics = {Rectangle(origin = {0, 25},rotation = 45, lineColor = {0, 85, 0}, fillColor = annotation_color, fillPattern = FillPattern.Solid, lineThickness = 0.27, extent = {{-55, -55}, {55, 55}}), Text(origin = {0, -80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(origin = {0, 26}, textColor = {170, 0, 0}, extent = {{-60, 20}, {60, -20}}, textString = "%volume")}));
end Volume;