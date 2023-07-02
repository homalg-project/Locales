# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Reading the implementation part of the package.
#

ReadPackage( "Locales", "gap/ProsetMethodRecord.gi");
ReadPackage( "Locales", "gap/Proset.gi");
ReadPackage( "Locales", "gap/ProsetDerivedMethods.gi");

ReadPackage( "Locales", "gap/PosetMethodRecord.gi");
ReadPackage( "Locales", "gap/Poset.gi");
ReadPackage( "Locales", "gap/PosetDerivedMethods.gi");

ReadPackage( "Locales", "gap/Lattice.gi");
ReadPackage( "Locales", "gap/LatticeDerivedMethods.gi");

ReadPackage( "Locales", "gap/HeytingAlgebraMethodRecord.gi");
ReadPackage( "Locales", "gap/CoHeytingAlgebraMethodRecord.gi");

ReadPackage( "Locales", "gap/HeytingAlgebra.gi");
ReadPackage( "Locales", "gap/CoHeytingAlgebra.gi");

ReadPackage( "Locales", "gap/HeytingAlgebraDerivedMethods.gi");
ReadPackage( "Locales", "gap/CoHeytingAlgebraDerivedMethods.gi");

ReadPackage( "Locales", "gap/BooleanAlgebraMethodRecord.gi");
ReadPackage( "Locales", "gap/BooleanAlgebra.gi");
ReadPackage( "Locales", "gap/BooleanAlgebraDerivedMethods.gi");

ReadPackage( "Locales", "gap/Tools.gi");

ReadPackage( "Locales", "gap/ProsetOfCategory.gi");

ReadPackage( "Locales", "gap/Differences.gi");
ReadPackage( "Locales", "gap/SingleDifferences.gi");
ReadPackage( "Locales", "gap/MultipleDifferences.gi");

ReadPackage( "Locales", "gap/ConstructibleObjects.gi");
ReadPackage( "Locales", "gap/ConstructibleObjectsAsUnionOfSingleDifferences.gi");
ReadPackage( "Locales", "gap/ConstructibleObjectsAsUnionOfMultipleDifferences.gi");

ReadPackage( "Locales", "gap/IntervalCategory.gi");

ReadPackage( "Locales", "gap/ProsetAsCategory.gi");

if IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    ReadPackage( "Locales", "gap/ToolsUsingDigraphs.gi");
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) and IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    ReadPackage( "Locales", "gap/JuliaWithDigraphs.gi");
fi;
