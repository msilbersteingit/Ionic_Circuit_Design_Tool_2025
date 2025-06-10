within Ionics.Electrodes;

model Blocking
  // Currently only supports neutral polymers
  extends Interfaces.Electrode(redeclare replaceable package Material = Materials.IdealPolyCation constrainedby Materials.Partial.MaterialCategory.Charge.Neutral(species_set = species_set) "Source connector material" annotation(
     choicesAllMatching = true,  Dialog(tab="General", group="Material")));
  import Modelica.Constants;
  parameter SI.Capacitance capacitance = Material.epsilon*Constants.epsilon_0*area/length_stern "Capacitance of the stern layer";
  parameter SI.Length length_stern = 0.2e-9 "Thickness of the Stern layer";
  parameter SI.Area area = 0.1 "Surface area for ions";
  //SI.ElectricCharge q_a(start=0);
  Real n_b[nC](each nominal = 1e-8);
  SI.ElectricCharge Q(nominal=1e-3);
  //Setup the diffuse voltage drops
  SI.Voltage V_diffuse_b(nominal=1e-6);
  SI.Voltage V_capacitive;
  SI.Length length_debye(nominal=1e-8); // Replace with a realtime calculated debye length.
  
initial equation
// Ionic surface excess concentrations start off equal to bulk
   n_b = 2*area*length_debye*material_state_b.C;
equation

  length_debye = sqrt(Constants.R*T*Constants.epsilon_0*Material.epsilon/Constants.F^2/sum((z.^2).*material_state_b.C));
  //length_debye = 1e-8;
  
  
  // Total charge on each plate is equal and opposite
  Q = -sum(n_b.*z)*Constants.F;

  //Derive current and voltage drop
  i = der(Q);
  V_capacitive = Q/capacitance;

  //V_delta = V_capacitive;
  V_delta = V_capacitive + V_diffuse_b;
  
  //Mass conservation for surface charges
  port_b.j = der(n_b);

  // Surface concentrations are always in equilibrium with the bulk
  //  TODO: replace with chemical potential based equilibrium
  //    This should take into account the surface isotherm and the bulk chemical potential
  //    This maybe should be in another model, and rename this one ElectrodeBlockingSimple
  for i loop
    n_b[i] = 2*area*length_debye*material_state_b.C[i]*(exp(-z[i].*Constants.F*V_diffuse_b/(2*Constants.R*T)));
  end for;
  
  //TODO: It would be nice if modelica implemented a numerically efficient version of expm1,
  //       since then we would have a better approximation for the excess charge at small voltages. 
  //       see https://numpy.org/doc/stable/reference/generated/numpy.expm1.html
  //port_b.j = der(n_b) + 2*area*length_debye*der(material_state_b.C);
  //for i loop
  //  n_b[i] = 2*area*length_debye*material_state_b.C[i]*(expm1(-z[i].*Constants.F*V_diffuse_b/(2*Constants.R*T)));
  //end for;
  
  
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(points = {{-20, 50}, {-20, -50}}, color = {0, 0, 255}), Line(points = {{20, 50}, {20, -50}}, color = {0, 85, 0}), Line(points = {{-20, 0}, {-100, 0}}, color = {0, 0, 255}), Line(points = {{20, 0}, {100, 0}}, color = {0, 85, 0}), Text(origin = {0, -70}, textColor = {170, 0, 0}, extent = {{-80, 20}, {80, -20}}, textString = "c=%capacitance"), Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name")}));
end Blocking;