within Ionics.Electrodes;

model Tafel
  extends Interfaces.Electrode;
  import Modelica.Constants;
  parameter Modelica.Units.SI.Area area = 0.1 "Surface area for ions";
  parameter Materials.Partial.Types.MolarConcentration[nC] C_reference = fill(1, nC) "Reference molar concentration for exchange current";
  
  parameter Real[nR] alpha(each unit = "1") = fill(0.5, nR) "Charge transfer coefficient"; //What part of the voltage participates in the rate limiting electron transfer step
  parameter Integer nR = 1 "Number of chemical reactions";
  parameter Integer[nR] n = fill(1, nR) "Number of electrons transferred to electrode in each reaction (positive is oxidation)";
  parameter Integer[nR, nC] stoichiometry "Stoichiometry of each species in each reaction";
  parameter Integer[nR, nC] rate_exponents "Exponent of each species in reaction's rate limiting step";
  parameter Modelica.Units.SI.Voltage[nR] V_reduction "Standard reduction potential vs SHE for each reaction";
  parameter Modelica.Units.SI.CurrentDensity[nR] J_0 "Exchange current density";
  parameter Real reaction_rate_reference[nR](each final quantity="Mobility", each final unit="mol/(m2.s)") = J_0./(Constants.F.*abs(n)) "Reference reaction rate";
 
  parameter Boolean use_reaction_rate_maximum = false "clamp reaction rates to the maximum" annotation(
    choices(checkBox = true));
  parameter Modelica.Units.SI.MolarFlowRate[nR] reaction_rate_maximum = fill(0, nR) "Maximum rate possible for each reaction" annotation(
    Dialog(enable = use_reaction_rate_maximum));
  parameter Real reaction_post_maximum_slope(final quantity = "MolarFlowRatePerVolt", final unit = "mol/(V.s)") = 0.1 "Slope of post maximum current vs voltage" annotation(
    Dialog(enable = use_reaction_rate_maximum)); 
  
  Modelica.Units.SI.Voltage[nR] V_overpotential(each start = 0, each nominal = 0.1) annotation(
    Dialog(tab = "Initialization")); 
  Modelica.Units.SI.MolarFlowRate reaction_rate[nR](each start = 1e-10) "Reaction rate of each chemical reaction" annotation(
    Dialog(tab = "Initialization"));
  Modelica.Units.SI.MolarFlowRate reaction_rate_clamped[nR](each start = 1e-10) "Limited reaction rate of each chemical reaction" annotation(
    Dialog(tab = "Initialization"));
  Modelica.Units.SI.MolarFlowRate species_creation_rate[nR, nC](each start = 1e-10) "Creation rate of each species in each reaction" annotation(
    Dialog(tab = "Initialization"));
  
equation

  for i loop

    // Note that this implies that 0V inside an ionic circuit using this electrode is also vs a SHE, instead of absolute.
    // Be careful when combining this with other idealized electrodes that may not include an interfacial drop.
    V_overpotential[i] = V_delta - V_reduction[i];
    
    //ν = C/C° * e^(αnFη/RT)
    reaction_rate[i] = (area*reaction_rate_reference[i].*product(material_state_b.C.^rate_exponents[i])./product(C_reference.^rate_exponents[i]).*exp(alpha[i]*n[i]*Constants.F*V_overpotential[i]/(Constants.R*T)));
    
    if use_reaction_rate_maximum then
      reaction_rate_clamped[i] = 1/(sqrt(1/(Modelica.Constants.small + reaction_rate[i]^2) + 1/(reaction_post_maximum_slope*abs(V_overpotential[i]) + reaction_rate_maximum[i])^2));
    else
      reaction_rate_clamped[i] = reaction_rate[i];
    end if;
    
    species_creation_rate[i] = if reaction_rate_clamped[i] > 1e-20 then reaction_rate_clamped[i].*stoichiometry[i] else fill(0.0, nC);
  
  end for;
  
  //Ion flux is equal to reaction rate
  for i loop
    port_b.j[i] = -sum(species_creation_rate[:, i]);
  end for;
  
  //Current Continuity
  i = -sum(port_b.j.*z)*Constants.F;
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Line(origin = {10, 0}, points = {{0, 50}, {0, -50}}, color = {0, 85, 0}, pattern = LinePattern.Dash), Line(origin = {-36, 0}, points = {{0, 50}, {0, -50}}, color = {0, 0, 255}), Line(points = {{-36, 0}, {-100, 0}}, color = {0, 0, 255}), Line(points = {{10, 0}, {100, 0}}, color = {0, 85, 0}), Text(origin = {0, 80}, textColor = {0, 0, 255}, extent = {{-150, 20}, {150, -20}}, textString = "%name"), Ellipse(origin = {-6, 28}, fillColor = {255, 225, 210}, fillPattern = FillPattern.Solid, extent = {{-14, 14}, {14, -14}}), Ellipse(origin = {20, -26}, fillColor = {255, 225, 210}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}), Ellipse(origin = {-36, 0}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Line(points = {{-85, 4}, {-47, 4}}, color = {109, 109, 109}, thickness = 1, arrow = {Arrow.Open, Arrow.Open}), Line(origin = {20, -26}, points = {{-10, 0}, {10, 0}}), Line(origin = {20, -26}, points = {{0, 10}, {0, -10}}), Ellipse(origin = {11, 18}, lineColor = {109, 109, 109}, lineThickness = 1, extent = {{-15, 30}, {15, -30}}, startAngle = 169.5, endAngle = 120, closure = EllipseClosure.None), Line(origin = {-3.68, 12.29}, rotation = -55, points = {{0, 0}, {8, 0}}, color = {109, 109, 109}, thickness = 1), Ellipse(origin = {-30, 13}, lineColor = {109, 109, 109}, lineThickness = 1, extent = {{-24, 13}, {24, -13}}, startAngle = 81, endAngle = 2.5, closure = EllipseClosure.None), Ellipse(origin = {10, 17}, lineColor = {109, 109, 109}, lineThickness = 1, extent = {{-16, 31}, {16, -31}}, startAngle = 171.5, endAngle = 120, closure = EllipseClosure.None), Rectangle(origin = {-36, 0}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-4, 0.5}, {4, -0.5}}), Line(origin = {1.76, -9.64}, rotation = 155, points = {{0, 0}, {8, 0}}, color = {109, 109, 109}, thickness = 1), Line(origin = {-8.21, 12.16}, rotation = -155, points = {{0, 0}, {8, 0}}, color = {109, 109, 109}, thickness = 1), Line(origin = {-26.1, 0.16}, rotation = -15, points = {{0, 0}, {8, 0}}, color = {109, 109, 109}, thickness = 1), Line(points = {{14, 28}, {28, 28}, {46, 6}, {80, 6}}, color = {109, 109, 109}, thickness = 1, arrow = {Arrow.Open, Arrow.Open}, smooth = Smooth.Bezier), Line(origin = {0, -0.13}, points = {{44, -26}, {57, -26}, {65, -6}, {80, -6}}, color = {109, 109, 109}, thickness = 1, arrow = {Arrow.Open, Arrow.Open}, smooth = Smooth.Bezier), Line(points = {{-85, 4}, {-47, 4}}, color = {109, 109, 109}, thickness = 1, arrow = {Arrow.Open, Arrow.Open}), Rectangle(origin = {-26, 42}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-4, 0.5}, {4, -0.5}}), Ellipse(origin = {-10, 32}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Rectangle(origin = {-10, 32}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-4, 0.5}, {4, -0.5}}), Line(origin = {-5.3132, 27.8145}, points = {{-10, 0}, {10, 0}}), Line(origin = {-5.3132, 27.8145}, points = {{0, 10}, {0, -10}}), Ellipse(origin = {-30, 13}, lineColor = {109, 109, 109}, lineThickness = 1, extent = {{-22, 11}, {22, -11}}, startAngle = 81, endAngle = 2.5, closure = EllipseClosure.None)}),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end Tafel;