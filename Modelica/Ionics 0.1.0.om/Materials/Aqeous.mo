within Ionics.Materials;

package Aqeous
  extends Ionics.Materials.Partial.Material(redeclare package MobilityModel = Materials.Mobility.TableScaled(D_multiplier = D_multiplier, records_searched = {Properties.DiffusivitySimple.Inorganic_Aqeous._all}),
                                            epsilon=78.4,
                                            epsilon_stern=6.0);
  constant Real D_multiplier = 1;
  
  

  redeclare model extends BaseProperties
    equation
      state.C = C;
      state.T = T;
  end BaseProperties;

  redeclare replaceable record ThermodynamicState "Minimal variable set that is available as input argument to every material function"
    SI.Temperature T;
    Partial.Types.MolarConcentration[nC] C;
    extends Modelica.Icons.Record;
  end ThermodynamicState;
  
  
  redeclare function extends electrochemicalPotential "Return electrochemical potential for non-ideal solution mixing with activity coefficients"
    protected
      Real[nC] log_gamma;

    algorithm
      if has_constant_activity_coeff then
        log_gamma := log_activity_coeff_constant();
      else
        log_gamma := log_activity_coeff(state);
      end if;
 
      mu := Constants.R.*state.T.*(log(state.C) + log_gamma) + voltage.*z.*Constants.F;
    annotation(
      smoothOrder = 2,
      Inline = true);
  end electrochemicalPotential;


end Aqeous;