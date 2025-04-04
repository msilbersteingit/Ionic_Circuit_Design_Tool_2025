within NovelCircuitry;
package Nafion_117_Neutral_Equivalent
  extends Ionics.Materials.Aqeous(q_fixed = 0.0e3*Modelica.Constants.F,
                                  annotation_color = category_annotation_color_charge,
                                  material_name = "Nafion 117 Neutral Equivalent",
                                  D_multiplier=0.5
                                  //MobilityModel(records_searched = {DiffusivityRecords._all})
                                  );
                                                            
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Neutral;

  // Data from https://doi.org/10.1016/S0022-0728(96)05060-7
  package DiffusivityRecords
    extends Modelica.Icons.RecordsPackage;
    // Inorganic Cations
    constant Ionics.Properties.DiffusivitySimple.Properties Na_p1(name = "Na 1+", D = 1.330e-10);
    constant Ionics.Properties.DiffusivitySimple.Properties Cl_n1(name = "Cl 1-", D = 5e-11);
    constant Ionics.Properties.DiffusivitySimple.PropertiesSet _all(records = {Na_p1, Cl_n1});
  end DiffusivityRecords;
  
  annotation (
    Icon);

end Nafion_117_Neutral_Equivalent;