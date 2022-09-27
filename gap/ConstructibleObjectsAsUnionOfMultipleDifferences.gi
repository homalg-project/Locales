# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
InstallMethodForCompilerForCAP( IsHomSetInhabitedWithTypeCast,
        "for a meet-semilattice of formal multiple differences, an object in this meet-semilattice of formal multiple differences, and a constructible object as a union of formal multiple differences",
        [ IsMeetSemilatticeOfMultipleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences, IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( D, A, B )
    local C, Apair, a, ap, Bpairs, b, bp, l;
    
    C := UnderlyingCategory( D );
    
    Apair := PairInUnderlyingLattice( AsSingleDifference( A ) );
    
    ap := Apair[2];
    a := Apair[1];
    
    Bpairs := List( ListOfObjectsInMeetSemilatticeOfMultipleDifferences( B, AsSingleDifference ), PairInUnderlyingLattice );
    
    bp := List( Bpairs, a -> a[2] );
    b := List( Bpairs, a -> a[1] );
    
    l := Length( b );
    
    ## TODO: remove List( iterator ) once GAP supports ForAll with an iterator as 1st argument
    return ForAll( [ 0 .. l ],
                   #i -> ForAll( IteratorOfCombinations( [ 1 .. l ], i ),
                   i -> ForAll( Combinations( [ 1 .. l ], i ),
                           I -> IsHomSetInhabited( C,
                                   DirectProduct( C, Concatenation( [ a ], bp{I} ) ),
                                   Coproduct( C, Concatenation( [ ap ], b{Difference( [ 1 .. l ], I )} ) ) ) ) );
    
end );

##
InstallMethod( BooleanAlgebraOfConstructibleObjectsAsUnionOfMultipleDifferences,
        "for a CAP category",
        [ IsCapCategory and IsThinCategory ],
        
  function( P )
    local name, C, BinaryDirectProduct;
    
    name := "The Boolean algebra of constructible objects as unions of formal multiple differences of ";
    
    name := Concatenation( name, Name( P ) );
    
    C := CreateCapCategory( name );
    
    C!.category_as_first_argument := true;
    
    C!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
        ],
        category_filter := IsBooleanAlgebraOfConstructibleObjectsAsUnionOfMultipleDifferences,
        object_filter := IsConstructibleObjectAsUnionOfMultipleDifferences,
        morphism_filter := IsMorphismBetweenConstructibleObjectsAsUnionOfMultipleDifferences,
    );
    
    SetFilterObj( C, IsBooleanAlgebraOfConstructibleObjectsAsUnionOfMultipleDifferences );
    
    SetIsBooleanAlgebra( C, true );
    
    SetUnderlyingCategory( C, P );
    SetUnderlyingMeetSemilatticeOfMultipleDifferences( C, MeetSemilatticeOfMultipleDifferences( P ) );
    
    AddObjectRepresentation( C, IsConstructibleObjectAsUnionOfMultipleDifferences );
    
    AddMorphismRepresentation( C, IsMorphismBetweenConstructibleObjectsAsUnionOfMultipleDifferences );
    
    ADD_COMMON_METHODS_FOR_BOOLEAN_ALGEBRAS( C );
    
    ##
    AddIsWellDefinedForObjects( C,
      function( cat, A )
        local D;
        
        D := UnderlyingMeetSemilatticeOfMultipleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfMultipleDifferences( A ), M -> IsWellDefinedForObjects( D, M ) );
        
    end );
    
    ##
    AddIsHomSetInhabited( C,
      function( cat, A, B )
        local D;
        
        D := UnderlyingMeetSemilatticeOfMultipleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfMultipleDifferences( A ), M -> IsHomSetInhabitedWithTypeCast( D, M, B ) );
        
    end );
    
    ##
    AddTerminalObject( C,
      function( cat )
        local T;
        
        T := TerminalObject( UnderlyingMeetSemilatticeOfMultipleDifferences( cat ) );
        
        return UnionOfListOfMultipleDifferences( cat, [ T ] );
        
    end );
    
    ##
    AddInitialObject( C,
      function( cat )
        local I;
        
        I := InitialObject( UnderlyingMeetSemilatticeOfMultipleDifferences( cat ) );
        
        return UnionOfListOfMultipleDifferences( cat, [ I ] );
        
    end );
    
    ##
    AddIsInitial( C,
      function( cat, A )
        local D;
        
        D := UnderlyingMeetSemilatticeOfMultipleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfMultipleDifferences( A ), M -> IsInitial( D, M ) );
        
    end );
    
    BinaryDirectProduct := function( cat, A, B )
        local D, L, l, I, U;
        
        #% CAP_JIT_RESOLVE_FUNCTION
        
        D := UnderlyingMeetSemilatticeOfMultipleDifferences( cat );
        
        L := [ List( A ), List( B ) ];
        
        l := [ 1, 2 ];
        
        ## TODO: replace Cartesian -> IteratorOfCartesianProduct once GAP supports List with an iterator as 1st argument
        I := Cartesian( List( L, a -> [ 1 .. Length( a ) ] ) );
        
        ## the distributive law
        U := List( I, i -> DirectProduct( D, List( l, j -> L[j][i[j]] ) ) );
        
        return UnionOfListOfMultipleDifferences( cat, U );
        
    end;
    
    ##
    AddDirectProduct( C,
      function( cat, L )
        
        return Iterated( L, { A, B } -> BinaryDirectProduct( cat, A, B ) );
        
    end );
    
    ##
    AddCoproduct( C,
      function( cat, L )
        
        L := List( L, ListOfObjectsInMeetSemilatticeOfMultipleDifferences );
        
        ## an advantage of this specific data structure for constructible objects
        return UnionOfListOfMultipleDifferences( cat, Concatenation( L ) );
        
    end );
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return C;
        
    fi;
    
    Finalize( C );
    
    return C;
    
end );

##
InstallOtherMethodForCompilerForCAP( UnionOfListOfMultipleDifferences,
        "for a Boolean algebra of constructible objects and a list",
        [ IsBooleanAlgebraOfConstructibleObjectsAsUnionOfMultipleDifferences, IsList ],
        
  function( C, L )
    
    return CreateCapCategoryObjectWithAttributes( C,
                   ListOfPreObjectsInMeetSemilatticeOfMultipleDifferences, L );
    
end );

##
InstallGlobalFunction( UnionOfMultipleDifferences,
  function( L )
    local ars, ars1, C, A;
    
    ars := List( L,
                 function( A )
                   local D;
                   if IsConstructibleObjectAsUnionOfMultipleDifferences( A ) then
                       return List( A );
                   elif IsConstructibleObjectAsUnionOfSingleDifferences( A ) then
                       return List( A, AsMultipleDifference );
                   elif IsObjectInMeetSemilatticeOfMultipleDifferences( A ) then
                       return A;
                   elif IsObjectInMeetSemilatticeOfSingleDifferences( A ) then
                       return AsMultipleDifference( A );
                   elif IsObjectInThinCategory( A ) then
                       D := A - 0;
                       if not IsObjectInMeetSemilatticeOfSingleDifferences( D ) then
                           Error( "the difference `D := A - 0' is not an object in a meet-semilattice of formal single differences\n" );
                       fi;
                       return AsMultipleDifference( D );
                   else
                       Error( "this entry is neither a constructible set as a union of formal multiple differences, nor a formal multiple difference, nor a formal single difference, not even an object in a thin category: ", A, "\n" );
                   fi;
               end );
    
    ars := Flat( ars );
    
    ars1 := ars[1];
    
    C := BooleanAlgebraOfConstructibleObjectsAsUnionOfMultipleDifferences(
                 CapCategory( PairInUnderlyingLattice( List( ars1 )[1] )[1] ) );
    
    ars := Filtered( ars, D -> not IsInitial( D ) );
    
    if ars = [ ] then
        ars := [ ars1 ];
    fi;
    
    A := UnionOfListOfMultipleDifferences( C, ars );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( \+,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( D, A )
    
    return UnionOfMultipleDifferences( [ D, A ] );
    
end );

##
InstallMethod( \+,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A, D )
    
    return UnionOfMultipleDifferences( [ A, D ] );
    
end );

##
InstallMethod( \+,
        "for a constructible object as a union of formal multiple differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( C, A )
    
    return UnionOfMultipleDifferences( [ C, A ] );
    
end );

##
InstallMethod( \+,
        "for an object in a thin category and a constructible object as a union of formal multiple differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A, C )
    
    return UnionOfMultipleDifferences( [ A, C ] );
    
end );

##
InstallMethod( \+,
        "for an object in a meet-semilattice of formal multiple differences and the zero integer",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsInt and IsZero ],
        
  function( A, B )
    
    return A + InitialObject( CapCategory( A ) );
    
end );

##
InstallMethod( \+,
        "for the zero integer and an object in a meet-semilattice of formal multiple differences",
        [ IsInt and IsZero, IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A, B )
    
    return B + InitialObject( CapCategory( B ) );
    
end );

##
InstallMethod( ListOfNormalizedObjectsInMeetSemilatticeOfMultipleDifferences,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    
    return List( A, NormalizeObject );
    
end );

##
InstallMethod( ListOfStandardObjectsInMeetSemilatticeOfMultipleDifferences,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    
    return List( A, StandardizeObject );
    
end );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfMultipleDifferences,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  ListOfPreObjectsInMeetSemilatticeOfMultipleDifferences );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfMultipleDifferences,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences and HasListOfNormalizedObjectsInMeetSemilatticeOfMultipleDifferences ],
        
  ListOfNormalizedObjectsInMeetSemilatticeOfMultipleDifferences );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfMultipleDifferences,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences and HasListOfStandardObjectsInMeetSemilatticeOfMultipleDifferences ],
        
  ListOfStandardObjectsInMeetSemilatticeOfMultipleDifferences );

##
InstallMethod( ListOp,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  ListOfObjectsInMeetSemilatticeOfMultipleDifferences );

##
InstallMethod( NormalizedObject,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    local L;
    
    L := Filtered( ListOfNormalizedObjectsInMeetSemilatticeOfMultipleDifferences( A ), m -> not IsInitial( m ) );
    
    if L = [ ] then
        return InitialObject( CapCategory( A ) );
    fi;
    
    return UnionOfMultipleDifferences( L );
    
end );

##
InstallMethod( StandardizedObject,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    local L;
    
    L := Filtered( ListOfStandardObjectsInMeetSemilatticeOfMultipleDifferences( A ), m -> not IsInitial( m ) );
    
    if L = [ ] then
        return InitialObject( CapCategory( A ) );
    fi;
    
    return UnionOfMultipleDifferences( L );
    
end );

##
InstallMethod( \-,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A, B )
    local L;
    
    B := ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( B );
    
    L := Concatenation( [ A - B[1].I ], List( List( B, D -> D.J ), Bi -> A * Bi ) );
    
    return UnionOfMultipleDifferences( L );
    
end );

##
InstallMethod( \-,
        "for an object in a thin category and a constructible object as a union of formal multiple differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A, B )
    
    return DirectProduct( List( B, b -> A - b ) );
    
end );

##
InstallMethod( \-,
        "for a constructible object as a union of formal multiple differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    return UnionOfMultipleDifferences( List( A, a -> a - B ) );
    
end );

##
InstallMethod( AdditiveInverseMutable,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    return -UnionOfMultipleDifferences( [ A ] );
    
end );

##
InstallMethod( Closure,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    local H;
    
    H := UnderlyingCategory( CapCategory( A ) );
    
    if HasIsCocartesianCoclosedCategory( H ) and IsCocartesianCoclosedCategory( H ) then
        return Coproduct( List( A, Closure ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ClosureAsConstructibleObject,
        "for a constructible object as a union of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A )
    
    return UnionOfMultipleDifferences( [ Closure( A ) - 0 ] );
    
end );

##
InstallMethod( \*,
        "for a constructible object as a union of formal multiple differences and an object in a meet-semilattice of formal multiple differences",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    return A * UnionOfMultipleDifferences( [ B ] );
    
end );

##
InstallMethod( \*,
        "for an object in a meet-semilattice of formal multiple differences and a constructible object as a union of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsConstructibleObjectAsUnionOfMultipleDifferences ],

  function( A, B )
    
    return UnionOfMultipleDifferences( [ A ] ) * B;
    
end );

##
InstallMethod( \=,
        "for an object in a thin category and a constructible object as a union of formal multiple differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfMultipleDifferences ],
        
  function( A, B )
    
    if IsConstructibleObjectAsUnionOfMultipleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return UnionOfMultipleDifferences( [ A ] ) = B;
    
end );

##
InstallMethod( \=,
        "for a constructible object as a union of formal multiple differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    if IsConstructibleObjectAsUnionOfMultipleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A = UnionOfMultipleDifferences( [ B ] );
    
end );
