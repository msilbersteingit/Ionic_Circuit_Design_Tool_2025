within Ionics;

package Functions
extends Modelica.Icons.FunctionsPackage;


  function exp_lin_2 "Exponential function linearly continued for x < MinExp and x > Maxexp"
    extends Modelica.Icons.Function;
    input Real x;
    input Real Minexp;
    input Real Maxexp;
    output Real y;
    //annotation(smoothOrder = 1);
  algorithm
    y := if x < Minexp then exp(Minexp)/(1 - x + Minexp) else if x > Maxexp then exp(Maxexp)*(1 + x - Maxexp) else exp(x);
    annotation(
      derivative(zeroDerivative = Minexp, zeroDerivative = Maxexp) = exp_lin_2_der1,
      smoothOrder = 1);
  end exp_lin_2;

  function exp_lin_2_der1 "Derivative of linearly continued exponential"
    extends Modelica.Icons.Function;
    input Real x;
    input Real Minexp;
    input Real Maxexp;
    input Real dx;
    output Real dy;
  algorithm
    dy := if x < Minexp then dx*exp(Minexp)/(1 - x + Minexp)^2 else if x > Maxexp then exp(Maxexp)*dx else exp(x)*dx;
  end exp_lin_2_der1;


end Functions;