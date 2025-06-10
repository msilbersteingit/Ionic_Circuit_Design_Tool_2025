within Ionics.Materials;
package WaterIdeal
  extends Materials.Aqeous(redeclare package ActivityModel=Activity.Ideal, final q_fixed = 0, annotation_color = category_annotation_color_charge, material_name="Water Ideal Mixing");
  extends Partial.MaterialCategory.Charge.Neutral;
  extends Partial.MaterialCategory.Thermoelectric;
  
  redeclare function extends thermal_conductivity_constant "Return electrochemical potential for non-ideal solution mixing with activity coefficients"
    algorithm
    conductivity := 0.6; // 0.6 W/(m K) at near room temperature from https://www.engineeringtoolbox.com/water-liquid-gas-thermal-conductivity-temperature-pressure-d_2012.html 
  end thermal_conductivity_constant;

end WaterIdeal;