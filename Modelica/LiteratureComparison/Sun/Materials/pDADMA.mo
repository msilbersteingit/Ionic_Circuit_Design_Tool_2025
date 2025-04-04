within LiteratureComparison.Sun.Materials;

package pDADMA
  extends Ionics.Materials.Aqeous(q_fixed = 1e2*Modelica.Constants.F, annotation_color = category_annotation_color_charge, D_multiplier=1e-1, redeclare package ActivityModel = Ionics.Materials.Activity.Ideal, material_name="pDADMA");
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Polycation;
  
  annotation (
    Icon);

end pDADMA;