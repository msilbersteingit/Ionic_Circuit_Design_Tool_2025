within NovelCircuitry;
package FAS_30
  extends Ionics.Materials.Aqeous(q_fixed = 1.3e3*Modelica.Constants.F,
                                  annotation_color = category_annotation_color_charge,
                                  material_name = "FAS 30",
                                  D_multiplier=1.0,
                                  MobilityModel(records_searched = {DiffusivityRecords._all}));
                                                            
  extends Ionics.Materials.Partial.MaterialCategory.Charge.Polycation;

  package DiffusivityRecords
    extends Modelica.Icons.RecordsPackage;
    // Inorganic Cations
    constant Ionics.Properties.DiffusivitySimple.Properties Na_p1(name = "Na 1+", D = 5e-11);
    constant Ionics.Properties.DiffusivitySimple.Properties Cl_n1(name = "Cl 1-", D = 1.330e-10);
    constant Ionics.Properties.DiffusivitySimple.PropertiesSet _all(records = {Na_p1, Cl_n1});
  end DiffusivityRecords;
  
  annotation (
    Icon);

end FAS_30;