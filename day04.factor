IN: aoc.2024.day03

USING: arrays assocs continuations io.encodings.utf8 io.files
kernel locals math math.order math.parser math.vectors
prettyprint ranges sequences sequences.deep sorting splitting
strings tools.annotations ;

: ?index* ( ns nested-seq -- x )
  [ [ swap nth ] reduce ] [ 3drop f ] recover ;

! Returns the size as { y x }, the order to index in
: grid-size ( lines -- sz )
  [ ] [ first ] bi [ length ] bi@ 2array ;

: all-in-grid ( sz -- grid-idxs )
  [ [0..b) ] map first2 cartesian-product flatten1 ;

:: walk-recurse ( grid delta cursor target-left -- b? )
  target-left empty?
  [ t ]
  [
    cursor grid ?index*  target-left first =
    [ grid delta  delta cursor v+  target-left rest  walk-recurse ]
    [ f ] if
  ] if
  ; inline recursive
: deltas8 ( -- d )
  { -1 0 1 } dup cartesian-product flatten1
  [ { 0 0 } = ] reject ;
: part1 ( input -- n )
  [ grid-size all-in-grid ] keep 
  [
    swap ! grid start
    deltas8 [ swap "XMAS" walk-recurse ] 2with count
  ] curry map sum
  ;

: is-sm-or-ms ( str -- b? )
  [ "SM" = ] [ "MS" = ] bi or ;
: extract-x ( grid coord -- 5chars )
  { 
    { -1 -1 } { 1 1 }
    { -1 1 } { 1 -1 }
    { 0 0 }
  }
  [ v+ swap ?index* ] 2with map 
  [ >string ] [ 2drop f ] recover
  ;
: 3and ( x y z -- b? ) and and ;
: check-x-mas ( 5chars -- b? )
  [
    [ 0 2 rot  subseq  is-sm-or-ms ]
    [ 2 4 rot  subseq  is-sm-or-ms ]
    [ 4 swap   nth     65 = ] tri 3and
  ] [ f ] if* ;

: part2 ( input -- n )
  [ grid-size all-in-grid ] keep 
  [
    swap extract-x check-x-mas
  ] curry count
  ;

"inputs/day04.txt" utf8 file-lines
[ part1 ] [ part2 ] bi

! 1209: too low
