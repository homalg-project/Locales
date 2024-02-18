#! @Chunk Dedekind1stNumber

#! The category of presheaves with values in the interval category
#! of the boolean algebra 2^1 has 3 distinct objects.
#! This is the free distributive lattice generated by a discrete category with one object.

#! @Example
LoadPackage( "Locales", false );
#! true
LoadPackage( "FunctorCategories", false, ">= 2023.09-02" );
#! true
IntervalCategory;
#! IntervalCategory
Display( IntervalCategory );
#! A CAP category with name IntervalCategory:
#! 
#! 21 primitive operations were used to derive 327 operations for this category
#!  which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsFiniteCategory
#! * IsEquippedWithHomomorphismStructure
#! * IsBooleanAlgebra
SetOfObjects( IntervalCategory );
#! [ <(⊥)>, <(⊤)> ]
SetOfGeneratingMorphisms( IntervalCategory );
#! [ (⊥)-[(⇒)]->(⊤) ]
PSh := PreSheaves( IntervalCategory );
#! PreSheaves( IntervalCategory, IntervalCategory )
Display( PSh );
#! A CAP category with name PreSheaves( IntervalCategory, IntervalCategory ):
#! 
#! 58 primitive operations were used to derive 207 operations for this category
#! which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsFiniteCocompleteCategory
#! * IsFiniteCompleteCategory
#! * IsCodistributiveCategory
#! * IsDistributiveCategory
#! and not yet algorithmically
#! * IsFiniteCategory
#! * IsBicartesianClosedCategory
#! * IsBicartesianCoclosedCategory
Y := YonedaEmbeddingOfSourceCategory( PSh );
#! Yoneda embedding functor
t := Y( TerminalObject( IntervalCategory ) );
#! <A projective object in PreSheaves( IntervalCategory, IntervalCategory )>
IsTerminal( t );
#! true
Display( t );
#! Image of <An object in IntervalCategory>:
#! <(⊤)>
#! 
#! Image of <An object in IntervalCategory>:
#! <(⊤)>
#! 
#! Image of (⊥)-[(⇒)]->(⊤):
#! (⊤)-[(⊤)]->(⊤)
#! 
#! An object in PreSheaves( IntervalCategory, IntervalCategory )
#! given by the above data
f := Y( InitialObject( IntervalCategory ) );
#! <A projective object in PreSheaves( IntervalCategory, IntervalCategory )>
IsInitial( f );
#! false
Display( f );
#! Image of <An object in IntervalCategory>:
#! <(⊤)>
#! 
#! Image of <An object in IntervalCategory>:
#! <(⊥)>
#! 
#! Image of (⊥)-[(⇒)]->(⊤):
#! (⊥)-[(⇒)]->(⊤)
#! 
#! An object in PreSheaves( IntervalCategory, IntervalCategory )
#! given by the above data
i := InitialObject( PSh );
#! <An object in PreSheaves( IntervalCategory, IntervalCategory )>
Display( i );
#! Image of <An object in IntervalCategory>:
#! <(⊥)>
#! 
#! Image of <An object in IntervalCategory>:
#! <(⊥)>
#! 
#! Image of (⊥)-[(⇒)]->(⊤):
#! (⊥)-[(⊥)]->(⊥)
#! 
#! An object in PreSheaves( IntervalCategory, IntervalCategory )
#! given by the above data
#! @EndExample
