# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
InstallMethod( IsClosed,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  IsClosedSubobject );

##
InstallMethod( IsOpen,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    return IsClosed( -A );
    
end );

##
InstallMethod( LocallyClosedPart,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    if IsClosed( A ) then
        return Closure( A );
    fi;
    
    return StandardizeObject( A );
    
end );

##
InstallMethod( FactorizeObject,
        "for an object in a meet-semilattice of formal differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    A := Factors( A );
    
    if Length( A ) = 1 then
        return A[1];
    fi;
    
    return UnionOfMultipleDifferences( A );
    
end );

##
InstallMethod( CanonicalObjectOp,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  LocallyClosedPart );

##
InstallMethod( CanonicalObject,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  LocallyClosedPart );

##
InstallMethod( Dimension,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    return Dimension( Closure( A ) );
    
end );

##
InstallMethod( DegreeAttr,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  function( A )
    
    return DegreeAttr( Closure( A ) );
    
end );

##
InstallMethod( Degree,
        "for an object in a meet-semilattice of formal single/multiple differences",
        [ IsObjectInMeetSemilatticeOfDifferences ],
        
  DegreeAttr );
