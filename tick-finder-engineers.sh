#!/bin/sh
cd /home/freiheit/EDDN/examples/PHP
php Client_Simple.php | 
  grep --line-buffered 'E:D Market Connector' | 
  egrep --line-buffered 'FSDJump|Location' | 
  grep --line-buffered '"Government": "Engineer"' | 
  jq --unbuffered --compact-output '[ .message.StarSystem, [.message.Factions[] | select(.Government | test("Engineer")) | [ .Name, .Influence|tostring ] ] ]' | 
  awk '!x[$0]++; fflush();' | 
  TZ=UTC ts | 
  tee /home/freiheit/tick-finder-engineers.txt
