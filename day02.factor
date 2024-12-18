IN: aoc.2024.day02

USING: arrays assocs io.encodings.utf8 io.files kernel math
math.order math.parser prettyprint ranges sequences sorting
splitting ;

! this took SO LONG
: windows ( input sz -- output )
  [ [ length ] dip - [0..b] ] 2keep ! iterate over the whole list, minus the last sz elements
  '[ _ _ ! idx, fry in input, sz
    swapd dupd + ! input, start, end
    rot <slice>
  ] map
  ;

"inputs/day02.txt" utf8 file-lines
[ split-words [ string>number ] map ] map

: part1-line ( input -- output )
  ! get the "derivative"
  2 windows [ first2 swap - ] map
    [ [ [ 0 > ] all? ] [ [ 0 < ] all? ] bi or ] ! are they all increasing or decreasing
    [ [ abs 1 3 between? ] all? ] ! are their abses all 1<=x<=3
  bi and
  ;

: part1 ( input -- output )
  [ part1-line ] count
  ;

: skipping-one ( seq -- seqs )
  ! create a list of the original list, plus each list minus one elt
  [ length ] keep swap 1 - [0..b]
  swap '[ _
    swap cut-slice  1 tail  append
  ] map
  ;

: part2 ( input -- output )
  [
    [ skipping-one ] keep prefix
    [ part1-line ] any?
  ] count
  ;
 
[ part1 ] [ part2 ] bi
