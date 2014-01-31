*! 6jul2013, Michael Stepner, michaelstepner@gmail.com

capture program drop _maptile_zip5
program define _maptile_zip5
	syntax , [  shapefolder(string) ///
				mergedatabase ///
				map var(varname) legend_labels(string) min(string) clbreaks(string) max(string) mapcolors(string) ndfcolor(string) ///
					outputfolder(string) fileprefix(string) filesuffix(string) resolution(string) map_restriction(string) ///
			 ]
	
	if ("`mergedatabase'"!="") {
		merge 1:m zip5 using `"`shapefolder'/zip5_database_clean"', nogen update replace
		exit
	}
	
	if ("`map'"!="") {
	
		spmap `var' using `"`shapefolder'/zip5_coords_clean"' `map_restriction', id(id) ///
			oc(black) os(vthin ...) legend(`legend_labels' pos(5) size(*1.8)) ///
			clmethod(custom) ///
			clbreaks(`min' `clbreaks' `max') ///
			fcolor(`mapcolors') ndfcolor(`ndfcolor')
		if (`"`outputfolder'"'!="") graph export `"`outputfolder'/`fileprefix'`var'`filesuffix'.png"', width(`=round(3200*`resolution')') replace

	}
	
end
