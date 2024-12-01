IN: aoc.2024.day01

USING: assocs io.encodings.utf8 io.files kernel math math.parser
prettyprint sequences sorting splitting ;

"inputs/day01.txt" utf8 file-lines 
! turn each row into a 2-long array
[ "   " split-subseq [ string>number ] map ] map

: part1 ( input -- n )
  ! handily factor says that arrays of 2-long seqs count as assocs
  unzip
  ! unzip splats both onto the stack: sort both
  [ sort ] bi@
  [ - abs ] 2map sum
  ;

: part2 ( input -- n )
  unzip
  [
    ! stack looks like "left number" "entire right list"
    dupd swap [ = ] curry count *
  ] curry map
  sum
  ;

[ part1 ] [ part2 ] bi .s
