IN: aoc.2024.day03

USING: arrays assocs io.encodings.utf8 io.files kernel locals
math math.order math.parser math.vectors prettyprint ranges
sequences sequences.deep sorting splitting strings ;

: lines-across ( lines -- lines' ) ;

: lines-down ( lines -- lines' )
  [ first length [0..b) ] keep [ nth ] cartesian-map [ >string ] map
  ;

: diagonal-stripe-indexes ( start maxs -- idxs )
  [ [a..b) ] 2map first2 zip ;
: topcorner-indexes ( w h -- idxs )
  [ [0..b) ] [ 1 swap [a..b) ] bi*
  [ [ 0 2array ] map ] [ [ 0 swap 2array ] map ] bi* append
  ;
: diagonal-indexes ( w h -- idxs )
  [ topcorner-indexes ] [ 2array ] 2bi
  [ diagonal-stripe-indexes ] curry map
  ;
: reverse-diagonal ( diag w -- diag' )
  ! Swap each X for w-x
  [ [ swap first2 [ - 1 - ] dip 2array ] curry map ] curry map
  ;
: diagonals-indexes ( w h -- idxs )
  [ diagonal-indexes ] 2keep
  drop [ reverse-diagonal ] 2keep drop swap append
  ;

: index* ( ns nested-seq -- x )
  [ swap nth ] reduce ;

: lines-diag ( lines -- lines' )
  ! Get length down,across (the order to index* in)
  [ [ ] [ first ] bi [ length ] bi@ ] keep -rot
  diagonals-indexes
  [ [ swap index* ] with map >string ] with map
  ;

: wordsearch-strings ( lines -- lines' )
  [ lines-across ] [ lines-down ] [ lines-diag ] tri 3append
  dup [ reverse ] map append ;

: part1 ( lines -- n )
  wordsearch-strings dup [ reverse ] map append
  [ "XMAS" subseq-of? ] count ;

"inputs/day04.txt" utf8 file-lines
! part1 .
wordsearch-strings .

! 1209: too low
