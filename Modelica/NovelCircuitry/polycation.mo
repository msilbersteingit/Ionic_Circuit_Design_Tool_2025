within NovelCircuitry;
package polycation
  extends Ionics.Materials.Aqeous(q_fixed = 2e3*Modelica.Constants.F, D_multiplier = 0.1, annotation_color = category_annotation_color_charge, material_name="robot polycation");
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Polycation;
  
  annotation (
    Icon);

end polycation;