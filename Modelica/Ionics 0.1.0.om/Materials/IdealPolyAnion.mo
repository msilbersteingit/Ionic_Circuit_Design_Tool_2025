within Ionics.Materials;
package IdealPolyAnion
  extends Ionics.Materials.IdealMixingAqeousMaterial(q_fixed = -1.0*Modelica.Constants.F, annotation_color = category_annotation_color_charge, material_name = "Ideal Polyanion");
  extends Partial.MaterialCategory.Charge.Polyanion;
  annotation(
    Icon);
    
end IdealPolyAnion;