#!/bin/sh
FACTIONLIST="Traditional Hehe Flag"
#FACTIONLIST="$FACTIONLIST|League of Wuthielo Ku Liberty Party"
#FACTIONLIST="$FACTIONLIST|Law Party of Kongga|Orrere Travel Company"
#FACTIONLIST="$FACTIONLIST|Lave Radio Network"
cd /home/freiheit/EDDN/examples/PHP
php Client_Simple.php | 
  grep --line-buffered 'E:D Market Connector' | 
  egrep --line-buffered 'FSDJump|Location' | 
  grep --line-buffered Factions | 
  egrep --line-buffered "$FACTIONLIST" |
  jq --unbuffered --compact-output "[ .message.StarSystem, [.message.Factions[] | select(.Name | test(\"$FACTIONLIST\")) | [ .Name, .Influence|tostring ] ] ]" | 
  awk '!x[$0]++; fflush();' | 
  TZ=UTC ts | 
  tee /home/freiheit/tick-finder-cgfactions.txt
