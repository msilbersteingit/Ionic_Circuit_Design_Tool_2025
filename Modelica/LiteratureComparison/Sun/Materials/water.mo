within LiteratureComparison.Sun.Materials;

package water
  extends Ionics.Materials.Aqeous(q_fixed = 0, annotation_color = category_annotation_color_charge, redeclare package ActivityModel = Ionics.Materials.Activity.Ideal, material_name="water");
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Neutral;
  
  annotation (
    Icon);

end water;