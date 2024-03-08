#! @Chunk ClosedMonoidalLatticeOfIdeals

#! @Example
LoadPackage( "SubcategoriesForCAP", ">= 2024.02-11", false );
#! true
Q := HomalgFieldOfRationalsInSingular( );
#! Q
R := Q["x,y"];
#! Q[x,y]
F := CategoryOfRows( R );
#! Rows( Q[x,y] )
S := SliceCategoryOverTensorUnit( F );
#! SliceCategoryOverTensorUnit( Rows( Q[x,y] ) )
P := PosetOfCategory( S );
#! PosetOfCategory( SliceCategoryOverTensorUnit( Rows( Q[x,y] ) ) )
Display( P );
#! A CAP category with name
#! PosetOfCategory( SliceCategoryOverTensorUnit( Rows( Q[x,y] ) ) ):
#! 
#! 15 primitive operations were used to derive 269 operations for this category
#! which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsSymmetricClosedMonoidalLattice
I := HomalgMatrix( "[ x ]", 1, 1, R ) / F / S / P;
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
J := HomalgMatrix( "[ x, y ]", 2, 1, R ) / F / S / P;
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IJ := TensorProduct( I, J );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IiJ := DirectProduct( I, J );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IiJ = I;
#! true
IsHomSetInhabited( IJ, IiJ );
#! true
IsHomSetInhabited( IiJ, IJ );
#! false
IpJ := Coproduct( I, J );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IpJ = J;
#! true
IJqJ := InternalHom( J, IJ ); ## this is the ideal quotient IJ : J
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IJqJ = I;
#! true
iota := InternalHom( UniversalMorphismIntoTerminalObject( J ), IJ );
#! <An epi-, monomorphism in PosetOfCategory( SliceCategoryOverTensorUnit( \
#!  Rows( Q[x,y] ) ) )>
IsWellDefined( iota );
#! true
IsIsomorphism( iota );
#! false
IJJ := TensorProduct( IJ, J );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IJJqJ := InternalHom( J, IJJ );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IJJqJ = I;
#! false
IJJsJ := StableInternalHom( J, IJJ );
#! An object in the poset given by: An object in the slice category given by:
#! <A morphism in Rows( Q[x,y] )>
IJJsJ = I;
#! true
#! @EndExample
