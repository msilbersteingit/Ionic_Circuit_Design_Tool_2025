within NovelCircuitry;
package polyanion
  extends Ionics.Materials.Aqeous(q_fixed = -2e3*Modelica.Constants.F, D_multiplier = 0.1, annotation_color = category_annotation_color_charge, material_name="robot polyanion");
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Polyanion;
  
  annotation (
    Icon);

end polyanion;