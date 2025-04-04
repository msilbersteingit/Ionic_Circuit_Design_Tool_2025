within LiteratureComparison.Berggren.Materials;

package pVBPPh3
extends Ionics.Materials.Aqeous(redeclare package ActivityModel = Ionics.Materials.Activity.Ideal,
                                annotation_color = category_annotation_color_charge,
                                D_multiplier = 3.19e-3,
                                q_fixed = Modelica.Constants.F*3000,
                                material_name = "Berggren pVBPPh3");
extends Ionics.Materials.Partial.MaterialCategory.Charge.Polycation;
end pVBPPh3;  