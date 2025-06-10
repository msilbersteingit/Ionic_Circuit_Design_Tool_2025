within Ionics.Basic;

model InterfaceSharp
  extends Ionics.Interfaces.TwoPortTwoMaterial(final no_accumulation = true, V_delta(start = 0.1));
  parameter SI.Voltage V_delta_capped = 0.3;
protected
  Real log_gamma_a[nC](each start = 1, each stateSelect = StateSelect.never); 
  Real log_gamma_b[nC](each start = 1, each stateSelect = StateSelect.never); 
  parameter Real[nC] x_limit = V_delta_capped.*abs(z).*Constants.F./(Constants.R.*T);
  
equation
  if MaterialA.has_constant_activity_coeff then
    log_gamma_a = MaterialA.log_activity_coeff_constant();
  else
    log_gamma_a = MaterialA.log_activity_coeff(material_state_a.state);
  end if;
  
  if MaterialB.has_constant_activity_coeff then
    log_gamma_b = MaterialB.log_activity_coeff_constant();
  else
    log_gamma_b = MaterialB.log_activity_coeff(material_state_b.state);
  end if;  
  
  if MaterialA.material_name == MaterialB.material_name then
// If we have the same material on both sides, then don't calculate any equilibrium.
//  This allows us to stick unnecessary sharp interfaces between materials that could be different
//  without incurring any computational cost if we do.
    for i loop
      material_state_b.Ci[i] = material_state_a.Ci[i];
    end for;
    V_delta = 0;
  else
    for i loop
      if z[i] == 0 then
        material_state_b.C[i] = material_state_a.C[i];
      else
        // Note that this formula is only valid when the chemical potential is in the standard form. This has to be done for numerical stability.
        //  The raw form of the true chemical potential is too unstable for large voltages, and we need to rearrange the equation in order to
        //  introduce an approximation at the right place.

        Functions.exp_lin_2(V_delta.*Constants.F.*z[i]./(Constants.R.*T), -x_limit[i], x_limit[i]) = exp(log_gamma_b[i])*material_state_b.C[i]./(exp(log_gamma_a[i])*material_state_a.C[i]);
      end if;
    end for;
  end if;
  annotation(
    Icon(graphics = {Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Line(points = {{-100, 0}, {-20, 0}}, color = {0, 85, 0}), Line(points = {{20, 0}, {100, 0}}, color = {0, 85, 0}), Rectangle(origin = {-10, 0}, lineColor = {0, 85, 0}, fillColor = annotation_color_a, fillPattern = FillPattern.Solid, extent = {{-10, 45}, {10, -45}}), Rectangle(origin = {10, 0}, lineColor = {0, 85, 0}, fillColor = annotation_color_b, fillPattern = FillPattern.Solid, extent = {{-10, 45}, {10, -45}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 0.645537, Tolerance = 1e-06, Interval = 0.00129107),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
end InterfaceSharp;