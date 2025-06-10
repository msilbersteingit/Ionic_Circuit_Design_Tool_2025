within Ionics.Materials.Activity;
package Ideal
extends Base(is_state_independent = true);

  redeclare function extends log_activity_coeff_constant
  algorithm
    for i in 1:nC loop
      log_gamma[i] := 0;
    end for;
    annotation(smoothOrder = 2, derivative = log_activity_coeff_der);
  end log_activity_coeff_constant;
  
  redeclare function extends log_activity_coeff
  algorithm
    for i in 1:nC loop
      log_gamma[i] := 0;
    end for;
    annotation(smoothOrder = 2, derivative = log_activity_coeff_der);
  end log_activity_coeff;
  
end Ideal;