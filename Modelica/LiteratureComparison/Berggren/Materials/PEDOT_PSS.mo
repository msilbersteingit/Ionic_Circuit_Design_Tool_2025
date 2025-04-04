within LiteratureComparison.Berggren.Materials;

package PEDOT_PSS
extends Ionics.Materials.Aqeous(redeclare package ActivityModel = Ionics.Materials.Activity.Ideal,
                                annotation_color = category_annotation_color_charge,
                                D_multiplier = 4.26e-1,
                                q_fixed = -Modelica.Constants.F*1000,
                                material_name = "Berggren pEDOT:pSS");
extends Ionics.Materials.Partial.MaterialCategory.Charge.Polyanion;
end PEDOT_PSS;