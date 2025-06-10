within Ionics.Basic;

model Resistor
  extends Ionics.Interfaces.TwoPortOneMaterial(final no_accumulation = true);
  
  import Modelica.Constants;
  parameter Real conductance[nC] = fill(1.0, nC) "Per species conductance";
  Real log_gamma_a[nC];
  Real log_gamma_b[nC];
protected
  SI.MolarConcentration[nC] C_effective;
  Real delta_log_gamma[nC];
public
equation
  for i loop
    C_effective[i] = noEvent(if V_delta*z[i] > 0 then material_state_a.C[i] else material_state_b.C[i]);
  end for;

  if Material.has_constant_activity_coeff then
    log_gamma_a = Material.log_activity_coeff_constant();
    log_gamma_b = Material.log_activity_coeff_constant();
  else
    log_gamma_a = Material.log_activity_coeff(material_state_a.state);
    log_gamma_b = Material.log_activity_coeff(material_state_b.state);
  end if;

  delta_log_gamma = log_gamma_a - log_gamma_b;
  
  port_a.j = conductance.*(  (Constants.F
                                    ./(Constants.R*T)
                                    .*Material.z
                                    .*V_delta
                                    .*C_effective) 
                                 + (material_state_a.C - material_state_b.C)
                                 + (C_effective
                                    .*delta_log_gamma
                                   )
                                 )
  
annotation(
    Icon(graphics = {Line(points = {{-100, 0}, {-60, 0}, {-50, 40}, {-30, -40}, {-10, 40}, {10, -40}, {30, 40}, {50, -40}, {60, 0}, {100, 0}}, color = {0, 85, 0}), Text(origin = {0, -75}, textColor = {170, 0, 0}, extent = {{-100, 23}, {100, -23}}, textString = "R=%R"), Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name")}));
annotation(
    Diagram(graphics),
    Icon(graphics = {Line(points = {{-100, 0}, {-60, 0}, {-50, 40}, {-30, -40}, {-10, 40}, {10, -40}, {30, 40}, {50, -40}, {60, 0}, {100, 0}}, color = {0, 85, 0})}));
end Resistor;