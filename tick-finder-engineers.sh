#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
cd EDDN/examples/Python\ 3.4
python3 Client_Simple.py |
  grep --line-buffered 'E:D Market Connector' | 
  egrep --line-buffered 'FSDJump|Location' | 
  grep --line-buffered '"Government": "Engineer"' | 
  jq --unbuffered --compact-output '[ .message.StarSystem, [.message.Factions[] | select(.Government | test("Engineer")) | [ .Name, .Influence|tostring ] ] ]' | 
  awk '!x[$0]++; fflush();' | 
  TZ=UTC ts | 
  tee ${DIR}/tick-finder-engineers.txt
