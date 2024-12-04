IN: aoc.2024.day03

USING: arrays ascii combinators io.encodings.utf8 io.files
kernel math math.parser peg peg.parsers peg.search prettyprint
sequences sequences.generalizations ;

: 3digit ( -- parser )
  ! see integer-parser
  [ digit? ] satisfy 1 3 from-m-to-n [ string>number ] action
  ;

: mul-expr ( -- parser )
  "mul(" token hide
  3digit
  "," token hide
  3digit
  ")" token hide
  5 narray seq ;

: part1 ( input -- output )
  mul-expr peg-search
  [ product ] map sum
  ;

: part2-parse ( -- parser )
  "do()" token
  "don't()" token
  mul-expr 3choice ;

: 2splat ( seq -- x y )
  [ first ] [ second ] bi ;

: part2 ( input -- output )
  part2-parse peg-search
  ! Accumulator is { running-sum, enabled }
  [ {
    { "do()" [ first t 2array ] }
    { "don't()" [ first f 2array ] }
    [ product swap 2splat [ + t ] [ nip f ] if 2array ]
  } case ]
  { 0 t } swap reduce first ;

! "inputs/day03.txt" utf8 file-contents
! [ part1 ] [ part2 ] bi
