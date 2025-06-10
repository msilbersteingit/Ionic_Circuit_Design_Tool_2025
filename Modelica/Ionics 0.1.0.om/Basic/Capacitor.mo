within Ionics.Basic;

model Capacitor "Two ionic charged regions separated by some distance"
  // TODO: We make assumptions that are only valid for neutral solutions, not polyelectrolytes
  extends Interfaces.TwoPortTwoMaterialUnconnected(redeclare replaceable package MaterialA = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Neutral(species_set = species_set_a) "Source connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material")), redeclare replaceable package MaterialB = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Neutral(species_set = species_set_b) "Source connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material")));
  
  parameter SI.Area area = 0.1 "Surface area for ions";
  
  parameter SI.Capacitance capacitance = 1/(1/MaterialA.epsilon_stern+1/MaterialA.epsilon_stern)*Constants.epsilon_0*area/length_stern "Capacitance of the stern layer";
  parameter SI.Length length_stern = 0.2e-9 "Thickness of the Stern layer";
  
  //constant SI.Length length_surface = 1e-8 "Characteristic length for the double layer";
  
  SI.Length length_debye_a(nominal=1e-8);
  SI.Length length_debye_b(nominal=1e-8);

  //Real der_v(start=0);
  Real n_a[nC_a](each nominal = 1e-8);
  Real n_b[nC_b](each nominal = 1e-8);
  SI.ElectricCharge Q;
    
  //Setup the voltage drops
  SI.Voltage V_diffuse_a;
  SI.Voltage V_diffuse_b;
  SI.Voltage V_capacitive;
  
  // This capacitor consists of two charged regions separated by some distance.
initial equation
  
  // Ionic surface concentrations start off equal to bulk within characteristic length
  // This implies that the ions have no affinity for the surface at all.
  n_a[nC_a] = material_state_a.C[nC_a]*area*length_debye_a*2;
  n_b[nC_b] = material_state_b.C[nC_b]*area*length_debye_b*2;

equation

  length_debye_a = sqrt(Constants.R*T*Constants.epsilon_0*MaterialA.epsilon/Constants.F^2/sum((z_a.^2).*material_state_a.C));
  length_debye_b = sqrt(Constants.R*T*Constants.epsilon_0*MaterialB.epsilon/Constants.F^2/sum((z_b.^2).*material_state_b.C));

  //Total charge on each plate is equal and opposite
  Q = sum(n_a.*z_a)*Constants.F;
  Q = -sum(n_b.*z_b)*Constants.F;
  
  //Derive voltage drops
  V_capacitive = Q/(capacitance);
  V_delta = V_capacitive - V_diffuse_a + V_diffuse_b;
  //V_delta = V_capacitive;
  
  //Mass conservation for surface charges
  port_a.j = der(n_a);
  port_b.j = der(n_b);

  // Surface concentrations are always in equilibrium with the bulk
  //  TODO: replace with chemical potential based equilibrium
  
  for i loop
    n_a[i] = 2*area*length_debye_a*material_state_a.C[i]*(exp(-z_a[i].*Constants.F*V_diffuse_a/(2*Constants.R*T)));
    n_b[i] = 2*area*length_debye_b*material_state_b.C[i]*(exp(-z_b[i].*Constants.F*V_diffuse_b/(2*Constants.R*T)));
  end for;
  
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {
      Line(points = {{-20, 50}, {-20, -50}}, color = {0, 85, 0}),
      Line(points = {{20, 50}, {20, -50}}, color = {0, 85, 0}),
      Line(points = {{-20, 0}, {-100, 0}}, color = {0, 85, 0}), 
      Line(points = {{20, 0}, {100, 0}}, color = {0, 85, 0}),
      Text(origin = {0, -70}, textColor = {170, 0, 0}, extent = {{-80, 20}, {80, -20}}, textString = "c=%capacitance"),
      Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name")}));
end Capacitor;