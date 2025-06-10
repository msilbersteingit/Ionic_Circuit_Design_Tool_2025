within Ionics.Properties;
package DiffusivitySimple
  extends Base.PerSpeciesProperties(property_group_name = "Constant Diffusivity");
  
  redeclare record extends Properties
    //constant SI.Length r_hydro "Hydration shell radius";
    constant SI.DiffusionCoefficient D "Constant diffusivity of the ion at 20C";
    constant SI.Temperature T_reference = 293.15 "Temperature at which the diffusivity was measured"; //Default to 20C
  end Properties;
 
  package Inorganic_Aqeous
    extends Modelica.Icons.RecordsPackage;
    
    // Default diffusivity values for ions in an aqeuous environment.
    // Sourced from: https://www.aqion.de/site/diffusion-coefficients
    
    // Inorganic Cations
    constant Properties Ag_p1(name = "Ag 1+", D = 1.648e-9);
    constant Properties Al_p3(name = "Al 3+", D = 0.559e-9);
    constant Properties Ba_p2(name = "Ba 2+", D = 0.848e-9);
    constant Properties Be_p2(name = "Be 2+", D = 0.599e-9);
    constant Properties Ca_p2(name = "Na 2+", D = 0.793e-9);
    constant Properties CaHCO3_p1(name = "CaHCO3 1+", D = 0.506e-9);
    constant Properties Cd_p2(name = "Cd 2+", D = 0.717e-9);
    constant Properties Co_p2(name = "Co 2+", D = 0.732e-9);
    constant Properties Cr_p3(name = "Cr 3+", D = 0.595e-9);
    constant Properties Cu_p2(name = "Cu 2+", D = 0.733e-9);
    constant Properties Fe_p2(name = "Fe 2+", D = 0.719e-9);
    constant Properties Fe_p3(name = "Fe 3+", D = 0.604e-9);
    constant Properties H_p1(name = "H 1+", D = 9.310e-9);
    constant Properties Hg_p2(name = "Hg 2+", D = 0.913e-9);
    constant Properties K_p1(name = "K 1+", D = 1.960e-9);
    constant Properties Li_p1(name = "Li 1+", D = 1.030e-9);
    constant Properties Mg_p2(name = "Mg 2+", D = 0.705e-9);
    constant Properties MgHCO3_p1(name = "MgHCO3 1+", D = 0.478e-9);
    constant Properties Mn_p2(name = "Mn 2+", D = 0.688e-9);
    constant Properties Na_p1(name = "Na 1+", D = 1.330e-9);
    //constant Properties Na_p1(name = "Na 1+", D = 2.030e-9); // Equal to Cl- for testing symmetric ions
    constant Properties NH4_p1(name = "NH4 1+", D = 1.980e-9);
    constant Properties Pb_p2(name = "Pb 2+", D = 0.945e-9);
    constant Properties Sr_p2(name = "Sr 2+", D = 0.794e-9);
    constant Properties UO2_p2(name = "UO2 2+", D = 0.426e-9);
    constant Properties Zn_p2(name = "Zn 2+", D = 0.715e-9);
    
    // Inorganic Anions
    constant Properties Br_n1(name = "Br 1-", D = 2.010e-9);
    constant Properties Cl_n1(name = "Cl 1-", D = 2.030e-9);  
    constant Properties CO3_n2(name = "CO3 2-", D = 0.955e-9);
    constant Properties CN_n1(name = "CN 1-", D = 2.077e-9);
    constant Properties CNO_n1(name = "CNO 1-", D = 1.720e-9);
    constant Properties CrO4_n2(name = "CrO4 2-", D = 1.132e-9);
    constant Properties F_n1(name = "F 1-", D = 1.460e-9);
    constant Properties H2AsO4_n1(name = "H2AsO4 1-", D = 0.905e-9);
    constant Properties H2PO4_n1(name = "H2PO4 1-", D = 0.846e-9);
    constant Properties HCO3_n1(name = "HCO3 1-", D = 1.180e-9);
    constant Properties HPO4_n2(name = "HPO4 2-", D = 0.690e-9);
    constant Properties HS_n1(name = "HS 1-", D = 1.730e-9);
    constant Properties HSO4_n1(name = "HSO3 1-", D = 1.330e-9);
    constant Properties I_n1(name = "I 1-", D = 2.045e-9);
    constant Properties KSO4_n1(name = "KSO4 1-", D = 0.746e-9);
    constant Properties MnO4_n1(name = "Mn04 1-", D = 1.632e-9);
    constant Properties MoO4_n2(name = "MoO4 2-", D = 1.984e-9);
    constant Properties NaCO3_n1(name = "NaCO3 1-", D = 0.585e-9);
    constant Properties NaSO4_n1(name = "NaSO4 1-", D = 0.618e-9);
    constant Properties NO2_n1(name = "NO2 1-", D = 1.910e-9);
    constant Properties NO3_n1(name = "NO3 1-", D = 1.900e-9);
    constant Properties OH_n1(name = "OH 1-", D = 5.270e-9);
    constant Properties PO4_n3(name = "PO4 3-", D = 0.612e-9);
    constant Properties S_n1(name = "S 1-", D = 0.731e-9);
    constant Properties SeO4_n2(name = "SeO4 2-", D = 1.008e-9);
    constant Properties SO4_n2(name = "SO4 2-", D = 1.070e-9);
    
    // Self diffusion constant of water
    constant Properties H20(name = "H2O", D= 2.299e-9);
    
    // All of the records for lookup by name purposes
    constant PropertiesSet _all(records = { Ag_p1, Al_p3, Ba_p2, Be_p2, Ca_p2, CaHCO3_p1, Cd_p2, Co_p2, Cr_p3, Cu_p2, Fe_p2, Fe_p3, H_p1, Hg_p2, K_p1 , Li_p1, Mg_p2, MgHCO3_p1, Mn_p2, Na_p1, NH4_p1, Pb_p2, Sr_p2, UO2_p2, Zn_p2,
    Br_n1, Cl_n1, CO3_n2, CN_n1, CNO_n1, CrO4_n2, F_n1, H2AsO4_n1, H2PO4_n1, HCO3_n1, HPO4_n2, HS_n1, HSO4_n1, I_n1, KSO4_n1, MnO4_n1, MoO4_n2, NaCO3_n1, NaSO4_n1, NO2_n1, NO3_n1, OH_n1, PO4_n3, S_n1, SeO4_n2, SO4_n2, H20});
  end Inorganic_Aqeous;
  
end DiffusivitySimple;