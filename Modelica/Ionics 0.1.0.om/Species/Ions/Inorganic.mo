within Ionics.Species.Ions;

package Inorganic
    extends Modelica.Icons.RecordsPackage;
    
    // Inorganic Cations
    constant Species Ag_p1(name = "Ag 1+", z = 1);
    constant Species Al_p3(name = "Al 3+", z = 3);
    constant Species Ba_p2(name = "Ba 2+", z = 2);
    constant Species Be_p2(name = "Be 2+", z = 2);
    constant Species Ca_p2(name = "Na 2+", z = 2);
    constant Species CaHCO3_p1(name = "CaHCO3 1+", z = 1);
    constant Species Cd_p2(name = "Cd 2+", z = 2);
    constant Species Co_p2(name = "Co 2+", z = 2);
    constant Species Cr_p3(name = "Cr 3+", z = 3);
    constant Species Cu_p2(name = "Cu 2+", z = 2);
    constant Species Fe_p2(name = "Fe 2+", z = 2);
    constant Species Fe_p3(name = "Fe 3+", z = 3);
    constant Species H_p1(name = "H 1+", z = 1);
    constant Species Hg_p2(name = "Hg 2+", z = 2);
    constant Species K_p1(name = "K 1+", z = 1);
    constant Species Li_p1(name = "Li 1+", z = 1);
    constant Species MgHCO3_p1(name = "MgHCO3 1+", z = 1);
    constant Species Mn_p2(name = "Mn 2+", z = 2);
    constant Species Na_p1(name = "Na 1+", z = 1);
    constant Species NH4_p1(name = "NH4 1+", z = 1);
    constant Species Pb_p2(name = "Pb 2+", z = 2);
    constant Species Sr_p2(name = "Sr 2+", z = 2);
    constant Species UO2_p2(name = "UO2 2+", z = 2);
    constant Species Zn_p2(name = "Zn 2+", z = 2);
    
    // Inorganic Anions
    constant Species Br_n1(name = "Br 1-", z = -1);
    constant Species Cl_n1(name = "Cl 1-", z = -1);
    constant Species CO3_n2(name = "CO3 2-", z = -2);
    constant Species CN_n1(name = "CN 1-", z = -1);
    constant Species CNO_n1(name = "CNO 1-", z = -1);
    constant Species CrO4_n2(name = "CrO4 2-", z = -2);
    constant Species F_n1(name = "F 1-", z = -1);
    constant Species H2AsO4_n1(name = "H2AsO4 1-", z = -1);
    constant Species H2PO4_n1(name = "H2PO4 1-", z = -1);
    constant Species HCO3_n1(name = "HCO3 1-", z = -1);
    constant Species HPO4_n2(name = "HPO4 2-", z = -2);
    constant Species HS_n1(name = "HS 1-", z = -1);
    constant Species HSO4_n1(name = "HSO3 1-", z = -1);
    constant Species I_n1(name = "I 1-", z = -1);
    constant Species KSO4_n1(name = "KSO4 1-", z = -1);
    constant Species MnO4_n1(name = "Mn04 1-", z = -1);
    constant Species MoO4_n2(name = "MoO4 2-", z = -2);
    constant Species NaCO3_n1(name = "NaCO3 1-", z = -1);
    constant Species NaSO4_n1(name = "NaSO4 1-", z = -1);
    constant Species NO2_n1(name = "NO2 1-", z = -1);
    constant Species NO3_n1(name = "NO3 1-", z = -1);
    constant Species OH_n1(name = "OH 1-", z = -1);
    constant Species PO4_n3(name = "PO4 3-", z = -3);
    constant Species S_n1(name = "S 1-", z = -1);
    constant Species SeO4_n2(name = "SeO4 2-", z = -2);
    constant Species SO4_n2(name = "SO4 2-", z = -2);

    //Example combinations
    constant SpeciesSet NaCl(records = {Na_p1, Cl_n1});
    constant SpeciesSet LiCl(records = {Li_p1, Cl_n1});
    constant SpeciesSet H_OH(records = {H_p1, OH_n1});

    // All of the records for lookup by name purposes
    constant SpeciesSet _all(records = { Ag_p1, Al_p3, Ba_p2, Be_p2, Ca_p2, CaHCO3_p1, Cd_p2, Co_p2, Cr_p3, Cu_p2, Fe_p2, Fe_p3, H_p1, Hg_p2, K_p1 , Li_p1, MgHCO3_p1, Mn_p2, Na_p1, NH4_p1, Pb_p2, Sr_p2, UO2_p2, Zn_p2,
    Br_n1, Cl_n1, CO3_n2, CN_n1, CNO_n1, CrO4_n2, F_n1, H2AsO4_n1, H2PO4_n1, HCO3_n1, HPO4_n2, HS_n1, HSO4_n1, I_n1, KSO4_n1, MnO4_n1, MoO4_n2, NaCO3_n1, NaSO4_n1, NO2_n1, NO3_n1, OH_n1, PO4_n3, S_n1, SeO4_n2, SO4_n2});

end Inorganic;