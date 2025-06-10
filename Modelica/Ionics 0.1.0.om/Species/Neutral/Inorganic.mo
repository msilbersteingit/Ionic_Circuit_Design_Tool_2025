within Ionics.Species.Neutral;

package Inorganic
    extends Modelica.Icons.RecordsPackage;
    
    // Inorganic Cations
    constant Species H2O(name = "H2O", z = 0);

    // All of the records for lookup by name purposes
    constant SpeciesSet _all(records = {H2O});

end Inorganic;