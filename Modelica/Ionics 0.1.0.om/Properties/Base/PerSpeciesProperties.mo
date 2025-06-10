within Ionics.Properties.Base;
package PerSpeciesProperties

  constant String property_group_name = "Base ion properties";

  replaceable record Properties
    constant String name;
    annotation(defaultComponentPrefixes="constant");
  end Properties;

  replaceable record PropertiesSet "Set of IonProperties"
    constant Properties[:] records;
    constant Integer nR = size(records, 1);
    
    annotation(defaultComponentPrefixes = "constant");
  end PropertiesSet;
  
  replaceable function search_records
    // Always search using the set of species
    //record TypeSetMatched = Species.SpeciesSet;
    // Always search the currently defined PropertiesSet
    //record TypeSetSearched = PropertiesSet;
    
    constant input Species.SpeciesSet set_matched;
    constant input PropertiesSet[:] sets_searched;
    constant output PropertiesSet set_found;
  protected
    constant Integer n_out = size(set_matched.records, 1);
    constant Properties array_found[n_out];
    Boolean found[n_out] = fill(false, n_out);
  algorithm
    for i in 1:n_out loop
        for j in 1:size(sets_searched,1) loop // jth sets of records to search
          for k in 1:size(sets_searched[j].records, 1) loop
            if sets_searched[j].records[k].name == set_matched.records[i].name then
              array_found[i] := sets_searched[j].records[k];
              found[i] := true;
            end if;
          end for;
        end for;
        assert(found[i] == true, "Did not find '" + property_group_name + "' for '" + set_matched.records[i].name + "'");
    end for;
    set_found := PropertiesSet(records = array_found);
  end search_records;
  
end PerSpeciesProperties;