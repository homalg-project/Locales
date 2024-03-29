# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecord.gi

#! @Chapter Co-Heyting algebras

#! @Section Add-methods

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `ConegationOnMorphisms`.
#! $F: ( alpha ) \mapsto \mathtt{ConegationOnMorphisms}(alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddConegationOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConegationOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddConegationOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddConegationOnMorphisms",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `ConegationOnMorphismsWithGivenConegations`.
#! $F: ( s, alpha, r ) \mapsto \mathtt{ConegationOnMorphismsWithGivenConegations}(s, alpha, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddConegationOnMorphismsWithGivenConegations",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConegationOnMorphismsWithGivenConegations",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddConegationOnMorphismsWithGivenConegations",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddConegationOnMorphismsWithGivenConegations",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `ConegationOnObjects`.
#! $F: ( arg2 ) \mapsto \mathtt{ConegationOnObjects}(arg2)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddConegationOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConegationOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddConegationOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddConegationOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromDoubleConegation`.
#! $F: ( a ) \mapsto \mathtt{MorphismFromDoubleConegation}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromDoubleConegation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromDoubleConegation",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromDoubleConegation",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromDoubleConegation",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromDoubleConegationWithGivenDoubleConegation`.
#! $F: ( a, s ) \mapsto \mathtt{MorphismFromDoubleConegationWithGivenDoubleConegation}(a, s)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromDoubleConegationWithGivenDoubleConegation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromDoubleConegationWithGivenDoubleConegation",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromDoubleConegationWithGivenDoubleConegation",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromDoubleConegationWithGivenDoubleConegation",
                  [ IsCapCategory, IsList ] );
