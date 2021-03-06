# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
InstallValue( CAP_INTERNAL_METHOD_NAME_LIST_FOR_PREORDERED_SET_OF_CATEGORY,
  [
   # create_func_bool and create_func_object can only deal with operations which do
   # not get morphisms as arguments, because they access `UnderlyingCell` which is
   # not set for morphisms
   "IsWellDefinedForObjects",
   "IsHomSetInhabited",
   "TensorUnit",
   "TensorProductOnObjects",
   "InternalHomOnObjects",
   "InternalHomOnMorphismsWithGivenInternalHoms",
   # P admits the same (co)limits as C,
   # in fact, a weak (co)limit in C becomes a (co)limit in P.
   # However, we must not automatically detect these (co)limits via `universal_type`,
   # because `universal_type` is sometimes set for technical instead of mathematical reasons.
   # Additionally, we must be careful with the restrictions of create_func_bool and create_func_object
   # mentioned above.
   # DirectProduct
   "DirectProduct",
   "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
   "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
   # Coproduct
   "Coproduct",
   "InjectionOfCofactorOfCoproductWithGivenCoproduct",
   "UniversalMorphismFromCoproductWithGivenCoproduct",
   # DirectSum
   "DirectSum",
   "ProjectionInFactorOfDirectSumWithGivenDirectSum",
   "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
   "UniversalMorphismIntoDirectSumWithGivenDirectSum",
   "UniversalMorphismFromDirectSumWithGivenDirectSum",
   # TerminalObject
   "TerminalObject",
   "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
   # InitialObject
   "InitialObject",
   "UniversalMorphismFromInitialObjectWithGivenInitialObject",
   # ZeroObject
   "ZeroObject",
   "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
   "UniversalMorphismFromZeroObjectWithGivenZeroObject",
   ] );

##
InstallMethod( AsCellOfProset,
        "for a CAP object",
        [ IsCapCategoryObject ],
        
  function( object )
    local P, o;
    
    P := ProsetOfCategory( CapCategory( object ) );
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, P,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( AsCellOfStableProset,
        "for a CAP object",
        [ IsCapCategoryObject ],
        
  function( object )
    local P, o;
    
    P := StableProsetOfCategory( CapCategory( object ) );
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, P,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( AsCellOfProset,
        "for a CAP morphism",
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    local P, m;
    
    P := ProsetOfCategory( CapCategory( morphism ) );
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, P,
            Source( morphism ) / P,
            Range( morphism ) / P,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethod( AsCellOfStableProset,
        "for a CAP morphism",
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    local P, m;
    
    P := StableProsetOfCategory( CapCategory( morphism ) );
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, P,
            Source( morphism ) / P,
            Range( morphism ) / P,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethod( AsCellOfPoset,
        "for a CAP object",
        [ IsCapCategoryObject ],
        
  function( object )
    local P, o;
    
    P := PosetOfCategory( CapCategory( object ) );
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, P,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( AsCellOfStablePoset,
        "for a CAP object",
        [ IsCapCategoryObject ],
        
  function( object )
    local P, o;
    
    P := StablePosetOfCategory( CapCategory( object ) );
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, P,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( AsCellOfPoset,
        "for a CAP morphism",
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    local P, m;
    
    P := PosetOfCategory( CapCategory( morphism ) );
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, P,
            Source( morphism ) / P,
            Range( morphism ) / P,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethod( AsCellOfStablePoset,
        "for a CAP morphism",
        [ IsCapCategoryMorphism ],
        
  function( morphism )
    local P, m;
    
    P := StablePosetOfCategory( CapCategory( morphism ) );
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, P,
            Source( morphism ) / P,
            Range( morphism ) / P,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethod( \/,
        "for a CAP object",
        [ IsCapCategoryObject, IsProsetOrPosetOfCapCategory ],
        
  function( object, P )
    local o;
    
    if not IsIdenticalObj( CapCategory( object ), AmbientCategory( P ) ) then
        Error( "the category of the object and the ambient category of proset do not coincide\n" );
    fi;
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, P,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( \/,
        "for a CAP morphism",
        [ IsCapCategoryMorphism, IsProsetOrPosetOfCapCategory ],
        
  function( morphism, P )
    local m;
    
    if not IsIdenticalObj( CapCategory( morphism ), AmbientCategory( P ) ) then
        Error( "the category of the morphism and the ambient category of proset do not coincide\n" );
    fi;
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, P,
            Source( morphism ) / P,
            Range( morphism ) / P,
            UnderlyingCell, morphism );
    
    return m;
    
end );

##
InstallMethod( AmbientCategory,
        [ IsProsetOrPosetOfCapCategory ],
        
  function( A )
    
    return A!.AmbientCategory;
    
end );

##
InstallMethod( CreateProsetOrPosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    local skeletal, stable, category_filter, category_object_filter, category_morphism_filter,
          name, create_func_bool, create_func_object, create_func_morphism,
          list_of_operations_to_install, skip, func, pos,
          properties, preinstall, P, finalize;
    
    skeletal := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "skeletal", false );
    
    if IsIdenticalObj( skeletal, true ) then
        name := "Poset";
        category_filter := IsPosetOfCapCategory;
        category_object_filter := IsCapCategoryObjectInPosetOfACategory;
        category_morphism_filter := IsCapCategoryMorphismInPosetOfACategory;
    else
        name := "Proset";
        category_filter := IsProsetOfCapCategory;
        category_object_filter := IsCapCategoryObjectInProsetOfACategory;
        category_morphism_filter := IsCapCategoryMorphismInProsetOfACategory;
    fi;
    
    stable := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "stable", false );
    
    if IsIdenticalObj( stable, true ) then
        
        if not (HasIsThinCategory( C ) and IsThinCategory( C )) then
            Error( "only compatible (co)closed monoidal structures of (co)cartesian *thin* categories can be stabilized\n" );
        fi;
        
        name := Concatenation( "Stable", name );
        category_object_filter := category_object_filter and IsCapCategoryCellInStableProsetOrPosetOfACategory;
        category_morphism_filter := category_morphism_filter and IsCapCategoryCellInStableProsetOrPosetOfACategory;
    fi;
    
    name := Concatenation( name, "( ", Name( C ), " )" );
    
    ## e.g., IsHomSetInhabited
    create_func_bool :=
      function( name, P )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( cat, arg... )
            
            return CallFuncList( oper, Concatenation( [ C ], List( arg, UnderlyingCell ) ) );
            
        end;
        
    end;
    
    ## e.g., DirectProduct
    create_func_object :=
      function( name, P )
        local oper;
        
        oper := ValueGlobal( name );
        
        return ## a constructor for universal objects
          function( cat, arg... )
            
            return CallFuncList( oper, Concatenation( [ C ], List( arg, UnderlyingCell ) ) ) / P;
            
          end;
          
      end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
      function( name, P )
        local oper, type;
        
        oper := ValueGlobal( name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.(name).io_type;
        
        return
          function( cat, arg... )
            local src_trg, S, T;
            
            src_trg := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            S := src_trg[1];
            T := src_trg[2];
            
            return UniqueMorphism( S, T );
            
          end;
          
      end;
    
    list_of_operations_to_install := Intersection(
        CAP_INTERNAL_METHOD_NAME_LIST_FOR_PREORDERED_SET_OF_CATEGORY,
        ListInstalledOperationsOfCategory( C )
    );
    
    skip := [ 
              ];
    
    if IsIdenticalObj( stable, true ) then
        
        Add( list_of_operations_to_install, "IsTerminal" );
        
        Append( skip,
                [ "IsHomSetInhabited",
                  "InternalHomOnObjects",
                  "AreIsomorphicForObjectsIfIsHomSetInhabited",
                  ] );
    fi;
    
    for func in skip do
        
        pos := Position( list_of_operations_to_install, func );
        if not pos = fail then
            Remove( list_of_operations_to_install, pos );
        fi;
        
    od;
    
    properties := [ #"IsEnrichedOverCommutativeRegularSemigroup",
                    #"IsAbCategory",
                    "IsAdditiveCategory",
                    "IsPreAbelianCategory",
                    "IsAbelianCategory",
                    "IsMonoidalCategory",
                    "IsBraidedMonoidalCategory",
                    "IsSymmetricMonoidalCategory",
                    "IsClosedMonoidalCategory",
                    "IsSymmetricClosedMonoidalCategory",
                    "IsCartesianCategory",
                    "IsStrictCartesianCategory",
                    "IsCartesianClosedCategory",
                    "IsCocartesianCategory",
                    "IsStrictCocartesianCategory",
                    "IsCocartesianCoclosedCategory",
                    ];
    
    properties := Intersection( ListKnownCategoricalProperties( C ), properties );
    
    properties := List( properties, p -> [ p, ValueGlobal( p )( C ) ] );
    
    Add( properties, [ "IsThinCategory", true ] );
    
    if IsIdenticalObj( stable, true ) then
        Add( properties, [ "IsStableProset", true ] );
    fi;
    
    if IsIdenticalObj( skeletal, true ) then
        
        Add( properties, [ "IsSkeletalCategory", true ] );
        
        preinstall := [ ADD_COMMON_METHODS_FOR_POSETS ];
        
        if HasIsCartesianCategory( C ) and IsCartesianCategory( C ) then
            Add( properties, [ "IsStrictCartesianCategory", true ] );
            preinstall := [ ADD_COMMON_METHODS_FOR_MEET_SEMILATTICES ];
        fi;
        
        if HasIsCocartesianCategory( C ) and IsCocartesianCategory( C ) then
            Add( properties, [ "IsStrictCocartesianCategory", true ] );
            Add( preinstall, ADD_COMMON_METHODS_FOR_JOIN_SEMILATTICES );
        fi;
        
    else
        
        preinstall := [ ADD_COMMON_METHODS_FOR_PREORDERED_SETS ];
        
        if HasIsCartesianCategory( C ) and IsCartesianCategory( C ) then
            preinstall := [ ADD_COMMON_METHODS_FOR_CARTESIAN_PREORDERED_SETS ];
        fi;
        
        if HasIsCocartesianCategory( C ) and IsCocartesianCategory( C ) then
            Add( preinstall, ADD_COMMON_METHODS_FOR_COCARTESIAN_PREORDERED_SETS );
        fi;
        
    fi;
    
    P := CategoryConstructor( :
                 name := name,
                 category_filter := category_filter,
                 category_object_filter := category_object_filter,
                 category_morphism_filter := category_morphism_filter,
                 properties := properties,
                 preinstall := preinstall,
                 is_monoidal := HasIsMonoidalCategory( C ) and IsMonoidalCategory( C ),
                 list_of_operations_to_install := list_of_operations_to_install,
                 create_func_bool := create_func_bool,
                 create_func_object := create_func_object,
                 create_func_morphism := create_func_morphism,
                 category_as_first_argument := true
                 );
    
    P!.AmbientCategory := C;
    
    if CanCompute( C, "IsWeakTerminal" ) then
        
        AddIsTerminal( P,
          function( cat, S )
            
            return IsWeakTerminal( UnderlyingCell( S ) );
            
        end );
        
    fi;
    
    if CanCompute( C, "IsWeakInitial" ) then
        
        AddIsInitial( P,
          function( cat, S )
            
            return IsWeakInitial( UnderlyingCell( S ) );
            
        end );
        
    fi;
    
    if IsIdenticalObj( stable, true ) then
        if CanCompute( C, "InternalHomOnObjects" ) then
            
            ADD_COMMON_METHODS_FOR_HEYTING_ALGEBRAS( P );
            
            ##
            AddInternalHomOnObjects( P,
              function( cat, S, T )
                
                return StableInternalHom( UnderlyingCell( S ), UnderlyingCell( T ) ) / CapCategory( S );
                
            end );
            
            ## InternalHomOnMorphismsWithGivenInternalHoms is passed from the ambient Heyting algebra,
            ## its source are and target are not identical but equal to above (altered) internal Hom
            
            ##
            AddExponentialOnObjects( P,
              { cat, S, T } -> InternalHomOnObjects( cat, S, T ) );
            
            ##
            AddExponentialOnMorphismsWithGivenExponentials( P,
              { cat, S, alpha, beta, T } -> InternalHomOnMorphismsWithGivenInternalHoms( cat, S, alpha, beta, T ) );
            
        else
            
        fi;
        
    fi;
    
    finalize := ValueOption( "FinalizeCategory" );
    
    if finalize = false then
        
        return P;
        
    fi;
    
    Finalize( P );
    
    return P;
    
end );

##
InstallMethod( ProsetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  CreateProsetOrPosetOfCategory );

##
InstallMethod( PosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return CreateProsetOrPosetOfCategory( C : skeletal := true );
    
end );

##
InstallMethod( StableProsetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return ProsetOfCategory( C : stable := true );
    
end );

##
InstallMethod( StablePosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return PosetOfCategory( C : stable := true );
    
end );

##################################
##
## View & Display
##
##################################

##
InstallMethod( ViewObj,
        [ IsCapCategoryObjectInProsetOfACategory ],
        
  function( a )
    
    Print( "An object in the proset given by: " );
    
    ViewObj( UnderlyingCell( a ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsCapCategoryObjectInProsetOfACategory and IsCapCategoryCellInStableProsetOrPosetOfACategory ],
        
  function( a )
    
    Print( "An object in the stable proset given by: " );
    
    ViewObj( UnderlyingCell( a ) );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryObjectInProsetOfACategory ],
        
  function( a )
    
    Display( UnderlyingCell( a ) );
    
    Display( "\nAn object in the proset given by the above data" );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryObjectInProsetOfACategory and IsCapCategoryCellInStableProsetOrPosetOfACategory ],
        
  function( a )
    
    Display( UnderlyingCell( a ) );
    
    Display( "\nAn object in the stable proset given by the above data" );
    
end );

##
InstallMethod( ViewObj,
        [ IsCapCategoryObjectInPosetOfACategory ],
        
  function( a )
    
    Print( "An object in the poset given by: " );
    
    ViewObj( UnderlyingCell( a ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsCapCategoryObjectInPosetOfACategory and IsCapCategoryCellInStableProsetOrPosetOfACategory ],
        
  function( a )
    
    Print( "An object in the stable poset given by: " );
    
    ViewObj( UnderlyingCell( a ) );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryObjectInPosetOfACategory ],
        
  function( a )
    
    Display( UnderlyingCell( a ) );
    
    Display( "\nAn object in the poset given by the above data" );
    
end );

##
InstallMethod( Display,
        [ IsCapCategoryObjectInPosetOfACategory and IsCapCategoryCellInStableProsetOrPosetOfACategory ],
        
  function( a )
    
    Display( UnderlyingCell( a ) );
    
    Display( "\nAn object in the stable poset given by the above data" );
    
end );
