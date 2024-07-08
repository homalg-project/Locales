#! @Chunk StablePosetOfCategoryOfPosetOfCategoryOfSliceCategoryOverTensorUnitOfCategoryOfRowsOfCommutativeRingPrecompiled

#! @Example

LoadPackage( "Locales", false );
#! true
LoadPackage( "SubcategoriesForCAP", false );
#! true
LoadPackage( "FreydCategoriesForCAP", ">= 2024.07-02", false );
#! true

zz := HomalgRingOfIntegers( );;

# HomalgIdentityMatrix( size, ring ) * matrix -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "HomalgIdentityMatrix( size, ring ) * matrix",
        dst_template := "matrix",
    )
);

# matrix * HomalgIdentityMatrix( size, ring ) -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "matrix * HomalgIdentityMatrix( size, ring )",
        dst_template := "matrix",
    )
);

# KroneckerMat( matrix, HomalgIdentityMatrix( 1, ring ) ) -> matrix
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "matrix" ],
        src_template := "KroneckerMat( matrix, HomalgIdentityMatrix( 1, ring ) )",
        dst_template := "matrix",
    )
);

# TransposedMatrix( HomalgIdentityMatrix( size, ring ) ) -> HomalgIdentityMatrix( size, ring )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring" ],
        src_template := "TransposedMatrix( HomalgIdentityMatrix( size, ring ) )",
        dst_template := "HomalgIdentityMatrix( size, ring )",
    )
);

# KroneckerMat( HomalgIdentityMatrix( size, ring ), matrix )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "KroneckerMat( HomalgIdentityMatrix( size, ring ), matrix )",
        dst_template := "DiagMat( ring, ListWithIdenticalEntries( size, matrix ) )",
    )
);

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
category_constructor := EvalString( ReplacedString( """function( R )
  local F, S, P, L@
    
    F := CategoryOfRows( R : FinalizeCategory := true )@
    S := SliceCategoryOverTensorUnit( F : FinalizeCategory := true )@
    P := PosetOfCategory( S : FinalizeCategory := true )@
    L := StablePosetOfCategory( P )@
    
    return L@
    
end""", "@", ";" ) );;

given_arguments := [ zz ];;
compiled_category_name := "StablePosetOfCategoryOfPosetOfCategoryOfSliceCategoryOverTensorUnitOfCategoryOfRowsOfCommutativeRingPrecompiled";;
package_name := "Locales";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := [ "ExponentialOnObjects" ],
    number_of_objectified_objects_in_data_structure_of_object := 5,
    number_of_objectified_morphisms_in_data_structure_of_object := 1
);;

#! @EndExample
