# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
InstallMethodForCompilerForCAP( UnionOfListOfDifferences,
        "for a Boolean algebra of constructible objects and a list",
        [ IsBooleanAlgebraOfConstructibleObjectsAsUnionOfSingleDifferences, IsList ],
        
  function( C, L )
    
    return CreateCapCategoryObjectWithAttributes( C,
                   ListOfPreObjectsInMeetSemilatticeOfDifferences, L );
    
end );

##
InstallMethodForCompilerForCAP( IsHomSetInhabitedWithTypeCast,
        "for a meet-semilattice of formal single differences, an object in that meet-semilattice of formal single differences, and a constructible object as a union of formal single differences",
        [ IsMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences, IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( D, A, B )
    local C, Apair, a, ap, Bpairs, b, bp, l;
    
    C := UnderlyingCategory( D );
    
    Apair := MinuendAndSubtrahendInUnderlyingLattice( A );
    
    ap := Apair[2];
    a := Apair[1];
    
    Bpairs := List( B, MinuendAndSubtrahendInUnderlyingLattice );
    
    bp := List( Bpairs, a -> a[2] );
    b := List( Bpairs, a -> a[1] );
    
    l := Length( b );
    
    ## TODO: use IteratorOfCombinations once GAP supports ForAll with an iterator as 1st argument
    return ForAll( [ 0 .. l ],
                   #i -> ForAll( IteratorOfCombinations( [ 1 .. l ], i ),
                   i -> ForAll( Combinations( [ 1 .. l ], i ),
                           I -> IsHomSetInhabited( C,
                                   DirectProduct( C, Concatenation( [ a ], bp{I} ) ),
                                   Coproduct( C, Concatenation( [ ap ], b{Difference( [ 1 .. l ], I )} ) ) ) ) );
    
end );

##
InstallMethod( BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences,
        "for a CAP category",
        [ IsCapCategory and IsThinCategory ],
        
  function( P )
    local name, C, D, BinaryDirectProduct;
    
    name := Concatenation( "BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences( ", Name( P ), " )" );
    
    C := CreateCapCategory( name,
                 IsBooleanAlgebraOfConstructibleObjectsAsUnionOfSingleDifferences,
                 IsConstructibleObjectAsUnionOfSingleDifferences,
                 IsMorphismBetweenConstructibleObjectsAsUnionOfDifferences,
                 IsCapCategoryTwoCell );
    
    C!.supports_empty_limits := true;
    
    SetIsBooleanAlgebra( C, true );
    
    SetUnderlyingCategory( C, P );
    
    D := MeetSemilatticeOfSingleDifferences( P : FinalizeCategory := true );
    
    SetUnderlyingMeetSemilatticeOfSingleDifferences( C, D );
    
    C!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingCategory",
            "UnderlyingMeetSemilatticeOfSingleDifferences",
        ],
    );
    
    ADD_COMMON_METHODS_FOR_PREORDERED_SETS( C );
    
    ##
    AddIsWellDefinedForObjects( C,
      function( cat, A )
        local D;
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( A ), M -> IsWellDefinedForObjects( D, M ) );
        
    end );
    
    ##
    AddIsHomSetInhabited( C,
      function( cat, A, B )
        local D;
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( A ), M -> IsHomSetInhabitedWithTypeCast( D, M, B ) );
        
    end );
    
    ##
    AddTerminalObject( C,
      function( cat )
        local T;
        
        T := TerminalObject( UnderlyingMeetSemilatticeOfSingleDifferences( cat ) );
        
        return UnionOfListOfDifferences( cat, [ T ] );
        
    end );
    
    ##
    AddInitialObject( C,
      function( cat )
        
        return UnionOfListOfDifferences( cat, [ ] );
        
    end );
    
    ##
    AddIsInitial( C,
      function( cat, A )
        local D;
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        return ForAll( ListOfObjectsInMeetSemilatticeOfDifferences( A ), d -> IsInitial( D, d ) );
        
    end );
    
    BinaryDirectProduct := function( cat, A, B )
        local D, L, l, I, U;

        #% CAP_JIT_RESOLVE_FUNCTION
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        L := [ ListOfObjectsInMeetSemilatticeOfDifferences( A ),
               ListOfObjectsInMeetSemilatticeOfDifferences( B ) ];
        
        l := [ 1, 2 ];
        
        ## TODO: replace Cartesian -> IteratorOfCartesianProduct once GAP supports List with an iterator as 1st argument
        I := Cartesian( List( L, a -> [ 1 .. Length( a ) ] ) );
        
        ## the distributive law
        U := List( I, i -> DirectProduct( D, List( l, j -> L[j][i[j]] ) ) );
        
        return UnionOfListOfDifferences( cat, U );
        
    end;
    
    ##
    AddDirectProduct( C,
      function( cat, L )
        
        return Iterated( L, { A, B } -> BinaryDirectProduct( cat, A, B ), TerminalObject( C ) );
        
    end );
    
    ##
    AddCoproduct( C,
      function( cat, L )
        local D, differences;
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        differences := Concatenation( List( L, ListOfObjectsInMeetSemilatticeOfDifferences ) );
        
        ## an advantage of this specific data structure for constructible objects
        return UnionOfListOfDifferences( cat, Filtered( differences, d -> not IsInitial( D, d ) ) );
        
    end );
    
    ##
    AddCoexponentialOnObjects( C,
      function( cat, A, B )
        local D, DB;
        
        D := UnderlyingMeetSemilatticeOfSingleDifferences( cat );
        
        DB := ListOfPreObjectsInMeetSemilatticeOfDifferences( B );
        
        return Coproduct( C,
                       List( ListOfPreObjectsInMeetSemilatticeOfDifferences( A ), A_i ->
                             DirectProduct( C,
                                     List( DB, B_j ->
                                           DifferenceOfSingleDifferences( D, A_i, B_j ) ) ) ) );
        
    end );
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return C;
        
    fi;
    
    HandlePrecompiledTowers( C, P, "BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences" );
    
    Finalize( C );
    
    return C;
    
end );

##
InstallGlobalFunction( UnionOfDifferences,
  function( L )
    local ars, ars1, C, A;
    
    ars := List( L,
                 function( A )
                   local D;
                   if IsConstructibleObjectAsUnionOfSingleDifferences( A ) then
                       return List( A );
                   elif IsObjectInMeetSemilatticeOfSingleDifferences( A ) then
                       return A;
                   elif IsObjectInThinCategory( A ) then
                       D := A - 0;
                       if not IsObjectInMeetSemilatticeOfSingleDifferences( D ) then
                           Error( "the difference `D := A - 0' is not an object in a meet-semilattice of formal single differences\n" );
                       fi;
                       return D;
                   else
                       Error( "this entry is neither a constructible set as a union of formal single differences, nor a formal single difference, nor a formal single difference, not even an object in a thin category: ", A, "\n" );
                   fi;
               end );
    
    ars := Flat( ars );
    
    ars1 := ars[1];
    
    C := BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences(
                 CapCategory( MinuendAndSubtrahendInUnderlyingLattice( ars1 )[1] ) );
    
    ars := Filtered( ars, D -> not IsInitial( D ) );
    
    if ars = [ ] then
        ars := [ ars1 ];
    fi;
    
    A := UnionOfListOfDifferences( C, ars );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( \+,
        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
        
 function( D, A )
    
    return UnionOfDifferences( [ D, A ] );
    
end );

##
InstallMethod( \+,
        "for an object in a thin category and an object in a meet-semilattice of formal single differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
 function( A, D )
    
    return UnionOfDifferences( [ A, D ] );
    
end );

##
InstallMethod( \+,
        "for a constructible object as a union of formal single differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsObjectInThinCategory ],
        
 function( C, A )
    
    return UnionOfDifferences( [ C, A ] );
    
end );

##
InstallMethod( \+,
        "for an object in a thin category and a constructible object as a union of formal single differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfSingleDifferences ],
        
 function( A, C )
    
    return UnionOfDifferences( [ A, C ] );
    
end );

##
InstallMethod( \+,
        "for an object in a meet-semilattice of formal single differences and the zero integer",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsInt and IsZero ],
        
  function( A, B )
    
    return A + InitialObject( CapCategory( A ) );
    
end );

##
InstallMethod( \+,
        "for the zero integer and an object in a meet-semilattice of formal single differences",
        [ IsInt and IsZero, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A, B )
    
    return B + InitialObject( CapCategory( B ) );
    
end );

##
InstallMethod( \+,
        "for an object in a thin category and the zero integer",
        [ IsObjectInThinCategory, IsInt and IsZero ],
        
  function( A, B )
    
    return ( A - 0 ) + 0;
    
end );

##
InstallMethod( \+,
        "for the zero integer and an object in a thin category",
        [ IsInt and IsZero, IsObjectInThinCategory ],
        
  function( A, B )
    
    return ( B - 0 ) + 0;
    
end );

##
InstallGlobalFunction( UnionOfDifferencesOfNormalizedObjects,
  function( L )
    local C, A;
    
    C := BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences(
                 CapCategory( MinuendAndSubtrahendInUnderlyingLattice( ListOfObjectsInMeetSemilatticeOfDifferences( L[1] )[1] )[1] ) );
    
    A := CreateCapCategoryObjectWithAttributes( C,
                 ListOfNormalizedObjectsInMeetSemilatticeOfDifferences, L );
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ListOfNormalizedObjectsInMeetSemilatticeOfDifferences,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A )
    
    return List( A, NormalizeObject );
    
end );

##
InstallMethod( ListOfStandardObjectsInMeetSemilatticeOfDifferences,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A )
    
    return List( A, StandardizeObject );
    
end );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfDifferences,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  ListOfPreObjectsInMeetSemilatticeOfDifferences );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfDifferences,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences and HasListOfNormalizedObjectsInMeetSemilatticeOfDifferences ],
        
  ListOfNormalizedObjectsInMeetSemilatticeOfDifferences );

##
InstallMethod( ListOfObjectsInMeetSemilatticeOfDifferences,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences and HasListOfStandardObjectsInMeetSemilatticeOfDifferences ],
        
  ListOfStandardObjectsInMeetSemilatticeOfDifferences );

##
InstallMethod( ListOp,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  ListOfObjectsInMeetSemilatticeOfDifferences );

##
InstallMethod( ListOp,
        "for a constructible object as a union of formal single differences and a function",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsFunction ],
        
  function( A, f )
    
    return List( List( A ), f );
    
end );

##
InstallMethod( Iterator,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  A -> Iterator( List( A ) ) );

##
InstallMethod( ForAllOp,
        "for a constructible object as a union of formal single differences and a function",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsFunction ],
        
  function( A, f )
    
    return ForAll( List( A ), f );
    
end );

##
InstallMethod( ForAnyOp,
        "for a constructible object as a union of formal single differences and a function",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsFunction ],
        
  function( A, f )
    
    return ForAny( List( A ), f );
    
end );

##
InstallMethod( Length,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  C -> Length( List( C ) ) );

##
InstallMethod( NormalizedObject,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A )
    local L;
    
    L := Filtered( ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( A ), m -> not IsInitial( m ) );
    
    if L = [ ] then
        return InitialObject( CapCategory( A ) );
    fi;
    
    return UnionOfDifferences( L );
    
end );

##
InstallMethod( StandardizedObject,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A )
    local L;
    
    L := Filtered( ListOfStandardObjectsInMeetSemilatticeOfDifferences( A ), m -> not IsInitial( m ) );
    
    if L = [ ] then
        return InitialObject( CapCategory( A ) );
    fi;
    
    return UnionOfDifferences( L );
    
end );

##
InstallOtherMethodForCompilerForCAP( DifferenceOfSingleDifferences,
        [ IsMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( D, A, B )
    local H, C, A_ms, B_ms, A_m, A_s, B_m, B_s;
    
    H := UnderlyingCategory( D );
    
    C := BooleanAlgebraOfConstructibleObjectsAsUnionOfDifferences( H );
    
    A_ms := MinuendAndSubtrahendInUnderlyingLattice( A );
    B_ms := MinuendAndSubtrahendInUnderlyingLattice( B );

    A_m := A_ms[1];
    A_s := A_ms[2];
    
    B_m := B_ms[1];
    B_s := B_ms[2];
    
    return UnionOfListOfDifferences( C,
                   [ SingleDifference( D, Pair( A_m, Coproduct( H, [ A_s, B_m ] ) ) ),
                     SingleDifference( D, Pair( DirectProduct( H, [ A_m, B_s ] ), A_s ) ) ] );
    
end );

##
InstallMethod( \-,
        "for an object in a thin category and an object in a meet-semilattice of formal single differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A, B )
    
    B := MinuendAndSubtrahendInUnderlyingLattice( B );
    
    return ( A - B[1] ) + A * B[2];
    
end );

##
InstallMethod( \-,
        "for an object in a thin category and a constructible object as a union of formal single differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A, B )
    
    B := ListOfObjectsInMeetSemilatticeOfDifferences( B );
    
    return DirectProduct( List( B, b -> A - b ) );
    
end );

##
InstallMethod( \-,
        "for a constructible object as a union of formal single differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    A := ListOfObjectsInMeetSemilatticeOfDifferences( A );
    
    return UnionOfDifferences( List( A, a -> a - B ) );
    
end );

##
InstallMethod( AdditiveInverseMutable,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    return -UnionOfDifferences( [ A ] );
    
end );

##
InstallMethod( ClosureAsConstructibleObject,
        "for a constructible object as a union of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A )
    
    return ( Closure( A ) - 0 ) + 0;
    
end );

##
InstallMethod( \*,
        "for a constructible object as a union of formal single differences and an object in a meet-semilattice of formal single differences",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( A, B )
    
    return A * ( B + 0 );
    
end );

##
InstallMethod( \*,
        "for an object in a meet-semilattice of formal single differences and a constructible object as a union of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsConstructibleObjectAsUnionOfSingleDifferences ],

  function( A, B )
    
    return ( A + 0 ) * B;
    
end );

##
InstallMethod( \=,
        "for an object in a thin category and a constructible object as a union of formal single differences",
        [ IsObjectInThinCategory, IsConstructibleObjectAsUnionOfSingleDifferences ],
        
  function( A, B )
    
    if IsConstructibleObjectAsUnionOfSingleDifferences( A ) then
        TryNextMethod( );
    fi;
    
    return ( A + 0 ) = B;
    
end );

##
InstallMethod( \=,
        "for a constructible object as a union of formal single differences and an object in a thin category",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    if IsConstructibleObjectAsUnionOfSingleDifferences( B ) then
        TryNextMethod( );
    fi;
    
    return A = ( B + 0 );
    
end );

##
InstallMethod( \.,
        "for a constructible object as a union of formal single differences and a positive integer",
        [ IsConstructibleObjectAsUnionOfSingleDifferences, IsPosInt ],
        
  function( A, string_as_int )
    local name, n;
    
    A := ListOfObjectsInMeetSemilatticeOfDifferences( A );
    
    name := NameRNam( string_as_int );
    
    n := EvalString( name{[ 2 .. Length( name ) ]} );
    
    if name[1] = 'I' then
        return A[n].I;
    elif name[1] = 'J' then
        return A[n].J;
    fi;
    
    Error( "no component with this name available\n" );
    
end );
