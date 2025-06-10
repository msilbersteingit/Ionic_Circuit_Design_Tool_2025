within Ionics.Materials.Partial;

package Types
extends Modelica.Icons.TypesPackage;

// Setup specific types with bounds and nominal values:
  
type Mobility = Real (final quantity="Mobility", final unit="m/(N.s)");
type MolarConcentration = SI.MolarConcentration(min = 1e-15, nominal = 1.0e-8, max = 1e6);

end Types;