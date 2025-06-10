within Ionics.Materials;
package IdealPolyCation
  extends Ionics.Materials.IdealMixingAqeousMaterial(q_fixed = 1.0*Modelica.Constants.F, annotation_color = category_annotation_color_charge, material_name = "Ideal Polycation");
  extends Partial.MaterialCategory.Charge.Polycation;
  annotation(
    Icon);
    
end IdealPolyCation;