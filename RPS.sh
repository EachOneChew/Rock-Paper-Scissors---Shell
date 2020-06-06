#!/bin/bash

userw=0
compw=0

read -p "No. of rounds to win: " round_n

echo -e "\nRPS, victor is 1st to $round_n\n"

last_userc=0

#      R     P     S
#    R P S R P S R P S
arr=(1000 1000 1000 1000 1000 1000 1000 1000 1000)

while [[ $userw -lt $round_n && $compw -lt $round_n ]]

do
  if [[ $last_userc -eq 0 ]]
    then
      compc=$(( 1 + $RANDOM % 3 ))
  else
      offset=$(( ($last_userc - 1) * 3 ))
      r=${arr[$offset]}
      p=${arr[$(( $offset + 1 ))]}
      s=${arr[$(( $offset + 2 ))]}
      rps_sum=$(( $r + $p + $s ))
      r=$(( $r * 32767 / $rps_sum ))
      p=$(( $p * 32767 / $rps_sum ))
      rand_det=$RANDOM
      if [[ rand_det -le $r ]]
        then
          compc=1
      elif [[ rand_det -gt $(( $r + $p )) ]]
        then
          compc=3
      else
          compc=2
      fi
  fi

  read -p "User choice: " userc

  case $userc in
    [rR][oO][cC][kK]|[rR])
      if [[ $compc -eq 1 ]]
        then
          echo "Comp choice: rock"
          echo "Tie"
      elif [[ $compc -eq 2 ]]
        then
          echo "Comp choice: paper"
          echo "User loses"
          compw=$(( 1 + $compw ))
      else
          echo "Comp choice: scissors"
          echo "User wins"
          userw=$(( 1 + $userw ))
      fi
      if [[ $last_userc -ne 0 ]]
        then
          arr[$offset]=$(( ${arr[$offset]} * 8 / 10 ))
          arr[$(( $offset + 1  ))]=$(( ${arr[$(( $offset + 1  ))]} * 8 / 10 + 600 ))
          arr[$(( $offset + 2 ))]=$(( ${arr[$(( $offset + 2 ))]} * 8 / 10 ))
      fi
      last_userc=1
    ;;
    [pP][aA][pP][eE][rR]|[pP])
      if [[ $compc -eq 1 ]]
        then
          echo "Comp choice: rock"
          echo "User wins"
          userw=$(( 1 + $userw ))
      elif [[ $compc -eq 2 ]]
        then
          echo "Comp choice: paper"
          echo "Tie"
      else
          echo "Comp choice: scissors"
          echo "User loses"
          compw=$(( 1 + $compw ))
      fi
      if [[ $last_userc -ne 0 ]]
        then
          arr[$offset]=$(( ${arr[$offset]} * 8 / 10 ))
          arr[$(( $offset + 1 ))]=$(( ${arr[$(( $offset + 1 ))]} * 8 / 10 ))
          arr[$(( $offset + 2  ))]=$(( ${arr[$(( $offset + 2  ))]} * 8 / 10 + 600 ))
      fi
      last_userc=2
    ;;
    [sS][cC][iI][sS][sS][oO][rR][sS]|[sS])
      if [[ $compc -eq 1 ]]
        then
          echo "Comp choice: rock"
          echo "User loses"
          compw=$(( 1 + $compw ))
      elif [[ $compc -eq 2 ]]
        then
          echo "Comp choice: paper"
          echo "User wins"
          userw=$(( 1 + $userw ))
      else
          echo "Comp choice: scissors"
          echo "Tie"
      fi
      if [[ $last_userc -ne 0 ]]
        then
          arr[$offset]=$(( ${arr[$offset]} * 8 / 10 + 600 ))
          arr[$(( $offset + 1 ))]=$(( ${arr[$(( $offset + 1 ))]} * 8 / 10 ))
          arr[$(( $offset + 2 ))]=$(( ${arr[$(( $offset + 2 ))]} * 8 / 10 ))
      fi
      last_userc=3
    ;;
    *)
      echo "Bad input"
    ;;
  esac

  echo "User wins: $userw"
  echo -e "Comp wins: $compw\n"

done

if [[ $userw -ge $round_n ]]
  then
    echo "User is victor"
else
    echo "Comp is victor"
fi
