within Ionics.Materials.Mobility;

package TableScaled
  extends Base(is_state_independent = true);
  constant Real D_multiplier = 1;
  
  // This must be provided when the package is used, so it knows what records to do the lookup on
  constant Properties.DiffusivitySimple.PropertiesSet[:] records_searched;
 
  redeclare function extends mobility_constant
    protected
      Properties.DiffusivitySimple.PropertiesSet records_matched;
    algorithm

      //Lookup the records, which contain the diffusivity and the temperature at which it was measured
      records_matched := Properties.DiffusivitySimple.search_records(species_set, records_searched);
      
      //Use the einstein relationship to calculate the mobility from the diffusivity. 
      //Note that this is the generalized mobility and not the electrical mobility
      mobility := records_matched.records.D * D_multiplier ./ (records_matched.records.T_reference .* Modelica.Constants.k);
    
    annotation(
      Inline = true);
  end mobility_constant;
end TableScaled;