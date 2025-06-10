within Ionics.Geometric;

model UniformResistor
  extends Ionics.Interfaces.TwoPortOneMaterial(final no_accumulation = true);
  extends Icons.SquarePrism(icon_color_square_prism_main = annotation_color);
  
  import Modelica.Constants;
  parameter SI.Area area = 1.0 "Cross sectional area";
  parameter SI.Length length =1.0 "Length";
  Real log_gamma_a[nC];
  Real log_gamma_b[nC];
protected
  SI.MolarConcentration[nC] C_effective;
  SI.DiffusionCoefficient[nC] D_effective;
  SI.DiffusionCoefficient[nC] D_a;
  SI.DiffusionCoefficient[nC] D_b; 

  Real delta_log_gamma[nC];
public
equation
// Upwinding C into an effective concentration.
  for i loop
    C_effective[i] = noEvent(if V_delta*z[i] > 0 then material_state_a.C[i] else material_state_b.C[i]);  
 end for;

  if Material.has_constant_mobility then
    D_a = Material.mobility_constant() .* material_state_a.T .* Modelica.Constants.k;
    D_b = Material.mobility_constant() .* material_state_a.T .* Modelica.Constants.k;
  else
    D_a = Material.mobility(material_state_a.state) .* material_state_a.T .* Constants.k;
    D_b = Material.mobility(material_state_b.state) .* material_state_a.T .* Constants.k;
  end if;

  if Material.has_constant_activity_coeff then
    log_gamma_a = Material.log_activity_coeff_constant();
    log_gamma_b = Material.log_activity_coeff_constant();
  else
    log_gamma_a = Material.log_activity_coeff(material_state_a.state);
    log_gamma_b = Material.log_activity_coeff(material_state_b.state);
  end if;

  delta_log_gamma = log_gamma_a - log_gamma_b;
  D_effective = (D_a .+ D_b)./2;
  port_a.j = area.*D_effective.*(  (Constants.F
                                    ./(Constants.R*T)
                                    .*Material.z
                                    .*V_delta./length // E field approximation 
                                    .*C_effective) 
                                 + (material_state_a.C - material_state_b.C)/length // Concentration gradient approximation
                                 + (C_effective
                                    .*delta_log_gamma./length // Log activity gradient approximation
                                   )
                                 );
  annotation(
    Icon(graphics = {Text(origin = {0, -75}, textColor = {170, 0, 0}, extent = {{-100, 23}, {100, -23}}, textString = "R=%R"), Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Line(origin = {0, -5},points = {{-30, 0}, {-26, 0}, {-18, -20}, {-2, 20}, {14, -20}, {30, 20}, {46, -20}, {54, 0}, {58, 0}}, color = {0, 85, 0}), Line(points = {{-100, 0}, {-52, 0}}, color = {0, 85, 0}), Line(points = {{64, 0}, {100, 0}}, color = {0, 85, 0})}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end UniformResistor;