within LiteratureComparison.Sun;
model IonInjection
  extends Ionics.Interfaces.OnePort;
  
  import Modelica.Units.SI;
  parameter SI.Volume volume = 1;
  parameter SI.Time time_injected = 1;
  
  SI.MolarConcentration[Material.nC] C(each start = 1.0);
  
  parameter SI.MolarConcentration[Material.nC] C_injected = fill(1.0, Material.nC);
  
  Real[Material.nC] der_C;
  
  //Integer enabled(start=0);
 
equation
//Set the internal concentration equal to the port material state
//  and to change as the flow of mols times the volume only once we have injected the ions.
//  Before that, we behave like a static wall
  //enabled = if (time > time_injected) then 1 else 0;
  
  C = material_state.C;
  der_C = der(C);
  
  when (time >= time_injected) then
    reinit(port.Ci, {100});
  end when;
  
  //port.j = if (time > time_injected) then volume*der_C else fill(0.0, Material.nC);

  //port.j = fill(0.0, Material.nC);
  
  port.j = volume*der_C;
  
  annotation(
    Icon(graphics = {Rectangle(rotation = 45, lineColor = {0, 85, 0}, fillColor = annotation_color, fillPattern = FillPattern.Solid, lineThickness = 0.27, extent = {{-72, -72}, {72, 72}}), Text(origin = {0, 20}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Text(origin = {0, -20}, textColor = {170, 0, 0}, extent = {{-60, 20}, {60, -20}}, textString = "V=%volume")}));
end IonInjection;
