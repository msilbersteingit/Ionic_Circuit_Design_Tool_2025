within Ionics.Materials.Activity;
package Davies
  extends Base;

  redeclare function extends log_activity_coeff
    protected
      SI.IonicStrength I;
      Real A;
      constant Real dielectric_constant = 78.4;

    algorithm
      A := 4.19e6*(dielectric_constant*state.T)^(-3/2);
      I := (sum(z.^2 .*state.C) + q_fixed/Constants.F)/2e3 ; // From https://doi.org/10.1016/j.fluid.2008.04.019 which is ionic strength modified for polyelectrolytes
      if I < 0 then
         I := Modelica.Constants.eps^2;
      end if;
      for i in 1:nC loop
        log_gamma[i] := -A*z[i]^2*((I)^(1/2)/(1+I) -0.3*I);
        //log_gamma[i] := 0;
      end for;
      
    annotation(LateInline = true);
  end log_activity_coeff;

end Davies;