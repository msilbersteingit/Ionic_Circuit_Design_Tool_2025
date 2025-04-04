within LiteratureComparison.Sun.Materials;

package pSPA
  extends Ionics.Materials.Aqeous(q_fixed = -1e2*Modelica.Constants.F, annotation_color = category_annotation_color_charge, D_multiplier=1e-1, redeclare package ActivityModel = Ionics.Materials.Activity.Ideal, material_name="pSPA");
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Polyanion;
  
  annotation (
    Icon);

end pSPA;