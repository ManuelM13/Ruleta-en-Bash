#!/bin/bash

#Colores
colorverde="\e[0;32m\033[1m"
fincolor="\033[0m\e[0m"
colorrojo="\e[0;31m\033[1m"
colorazul="\e[0;34m\033[1m"
coloramarillo="\e[0;33m\033[1m"
colormorado="\e[0;35m\033[1m"
colorturquesa="\e[0;36m\033[1m"
colorgris="\e[0;37m\033[1m"

#CTRL+C
function ctrl_c(){
  echo -e "\n${colorrojo}[!] Saliendo....\n${fincolor}"
  exit 1
}

trap ctrl_c INT

function helppanel(){
  echo -e "\n${colorazul}El uso correcto de${fincolor} ${colormorado}$0${fincolor} ${colorazul}es:${fincolor}\n"
  echo -e "\t${colorazul}-m)${fincolor}${colorverde}Introducir cantidad de dinero${fincolor}"
  echo -e "\t${colorazul}-t)${fincolor}${colorverde}Introduce la tecnica a usar:${fincolor}${colorgris}(martingala/inverselabrouchere)${fincolor}"
}

function martingala(){

  echo -e "\n${colorazul}Se va a usar la tecnica${fincolor} ${colormorado}$tecnica${fincolor} ${colorazul}con${fincolor} ${colorverde}$money €${fincolor}"
  echo -e -n "${coloramarillo}[+]${fincolor} ${colorazul}¿cuanto dinero quieres apostar inicialmente?${fincolor} -> " && read initial_bet
  echo -e -n "${coloramarillo}[+]${fincolor} ${colorazul}¿a que deseas apostar inicialmente?${fincolor} ${colormorado}(par/impar)${fincolor} -> " && read par_impar
  echo -e "${coloramarillo}[+]${fincolor} ${colorazul}Se va a empezar apostando${fincolor} ${colorverde}$initial_bet € ${fincolor} ${colorazul}al${fincolor} ${colormorado}$par_impar${fincolor}"

  backup_bet=$initial_bet
  contador_jug=1
  jugadas_malas="[ "
  mayor_pasta=$money

  while true; do 
  money=$(($money-$initial_bet))
  echo -e "\n${colorazul}Se van a apostar:${fincolor} ${colorverde}$initial_bet €${fincolor} ${colorazul}te quedan:${fincolor} ${colorverde}$money €${fincolor}"
  random_number="$(($RANDOM % 37))"
  echo -e "\n${coloramarillo}[+]${fincolor} ${colorazul}Ha salido el numero${fincolor} ${colormorado}$random_number${fincolor}"
 sleep 4
  if [ ! "$money" -lt 0 ];then
    if [ "$par_impar" == "par" ];then 
      if [ "$(($random_number % 2))" -eq 0 ];then
        if [ "$random_number" -eq 0 ];then
            echo -e "${colorazul}El numero que ha salido es${fincolor} ${colorrojo}0${fincolor}${colorazul}, por lo tanto${fincolor} ${colorrojo}perdemos${fincolor}"
            initial_bet=$(($initial_bet*2))
            jugadas_malas+="$random_number "
            echo -e "\n${colorazul}Tienes${fincolor} ${colorverde}$money${fincolor} ${colorazul}y se va a apostar el doble de lo apostado${fincolor}"
          else
            echo -e "\n${colorazul}El numero que a salido es${fincolor} ${coloramarillo}par${fincolor} ${colorverde}GANAS!${fincolor}"
            premio=$(($initial_bet*2))
            money=$(($money+$premio))
            echo -e "\n${colorazul}Has ganado:${fincolor} ${colorverde}$premio €${fincolor} ${colorazul}y tienes:${fincolor} ${coloroverde}$money €${fincolor}"
            initial_bet=$backup_bet
            jugadas_malas=""    
            if [ "$money" > "$mayor_pasta" ];then
            mayor_pasta="$money"
            fi
        fi
      else
    echo -e "\n${colorazul}El numero que a salido es${fincolor} ${coloramarillo}impar${fincolor} ${colorrojo}PIERDES!${fincolor}"
    initial_bet=$(($initial_bet*2))
    jugadas_malas+="$random_number "   
    echo -e "\n${colorazul}Tienes${fincolor} ${colorverde}$money${fincolor} ${colorazul}y se va a apostar el doble de lo apostado${fincolor}"
      fi
    fi  
     if [ "$par_impar" == "impar" ];then 
        if [ "$(($random_number % 2))" -eq 1 ];then
          echo -e "\n${colorazul}El numero que a salido es${fincolor} ${coloramarillo}par${fincolor} ${colorverde}GANAS!${fincolor}"
          premio=$(($initial_bet*2))
          money=$(($money+$premio))
          echo -e "\n${colorazul}Has ganado:${fincolor} ${colorverde}$premio €${fincolor} ${colorazul}y tienes:${fincolor} ${coloroverde}$money €${fincolor}"
          initial_bet=$backup_bet
          jugadas_malas=""    
          if [ "$money" > "$mayor_pasta" ];then
          mayor_pasta="$money"
          fi
        else
        echo -e "\n${colorazul}El numero que a salido es${fincolor} ${coloramarillo}par${fincolor} ${colorrojo}PIERDES!${fincolor}"
        initial_bet=$(($initial_bet*2))
        jugadas_malas+="$random_number "   
        echo -e "\n${colorazul}Tienes${fincolor} ${colorverde}$money${fincolor} ${colorazul}y se va a apostar el doble de lo apostado${fincolor}"
        fi
    salido el numero -> 25
     fi
  else
    echo -e "\n${colorrojo}Te has quedado sin pasta${fincolor}"
    echo -e "\n${colorazul}Ha habido un total de:${fincolor} ${colorverde}$contador_jug${fincolor} ${colorazul}Jugadas${fincolor}"
    echo -e "\n${colorazul}Estas son las jugadas consecutivas que han salido mal:${fincolor}\n${colorrojo}$jugadas_malas${fincolor}"
    echo -e "\n${colorazul}Este es el mayor dinero que se a logrado alcanzar antes de caer:${fincolor}\n${colorverde}$mayor_pasta €${fincolor}"
    exit 0 
  fi
  let contador_jug+=1
done
}

function inverselabrouchere(){

  echo -e "\n${colorgris}Se va a usar la tecnica${fincolor} ${colormorado}$tecnica${fincolor} ${colorgris}con${fincolor} ${colorverde}$money €${fincolor}"
  echo -e -n "${coloramarillo}[+]${fincolor} ${colorgris}¿a que deseas apostar inicialmente?${fincolor} ${colormorado}(par/impar)${fincolor} -> " && read par_impar
  
  declare -a mi_sec=(1 2 3 4)

  echo -e "\n${colorgris}Se va a comenzar la secuencia${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
  
  bet=$((${mi_sec[0]} + ${mi_sec[-1]}))

  jugadas_totales=0
  renovar_apuesta=$(($money+50))
  
  while true; do
    let jugadas_totales+=1
    random_number=$(($RANDOM % 37))
    
    if [ $money -ne 0 ];then
    if [ $money -gt $renovar_apuesta ];then
      echo -e "${colorgris}Nuestro dinero a superado el tope de${fincolor} ${colorverde}$renovar_apuesta €${fincolor} ${colorgris}y se va renovar la secuencia, y se va a incrementar el tope en${fincolor} ${colorverde}50 €${fincolor} "
      let renovar_apuesta+=50
      mi_sec=(1 2 3 4)
      echo -e "${colorgris}Restableciendo secuencia a${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
      bet=$((${mi_sec[0]} + ${mi_sec[-1]}))

    fi
    money=$(($money - $bet))
    echo -e "\n${colorgris}Invertimos${fincolor} ${colorverde}$bet €${fincolor}"
    echo -e "${colorgris}Tenemos:${fincolor} ${colorverde}$money €${fincolor}"
  
    echo -e "${colorgris}Ha salido el numero ->${fincolor} ${colormorado}$random_number${fincolor}"

    if [ "$par_impar" == "par" ]; then
      if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
        echo -e "${colorgris}El numero es par,${fincolor} ${colorverde}GANAS!${fincolor}"
        premio=$(($bet*2))
        money=$(($money + $premio))
        echo -e "${colorgris}Tenemos:${fincolor} ${colorverde}$money €${fincolor}"
        
        mi_sec+=($bet)
        mi_sec=(${mi_sec[@]})
     
        echo -e "${colorgris}La secuendia se queda en:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
        
        if [ "${#mi_sec[@]}" -ne 1 ]; then
          bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
        elif [ "${#mi_sec[@]}" -eq 1 ]; then
          bet=${mi_sec[0]}
        fi  
      elif [ "$random_number" -eq 0 ]; then
         echo -e "${colorgris}El numero que ha salido es${fincolor} ${colorrojo}0${fincolor}${colorgris}, por lo tanto${fincolor} ${colorrojo}perdemos${fincolor}"
          unset mi_sec[0]
          unset mi_sec[-1] 2>/dev/null

          mi_sec=(${mi_sec[@]})
          echo -e "${colorgris}La secucencia queda de la sigiente forma:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
            if [ "${#mi_sec[@]}" -ne 1 ] && [ "${#mi_sec[@]}" -ne 0 ]; then
               bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
            elif [ "${#mi_sec[@]}" -eq 1 ]; then
               bet=${mi_sec[0]}
            else
               echo -e "${colorrojo}[!]Hemos perdido la secuencia${fincolor}"
               mi_sec=(1 2 3 4)
               echo -e "${colorgris}Restableciendo secuencia a${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
               bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
            fi  
 


           else
        echo -e "${colorgris}El numero es impar,${fincolor} ${colorrojo}PIERDES!${fincolor}"
          
          unset mi_sec[0]
          unset mi_sec[-1] 2>/dev/null

          mi_sec=(${mi_sec[@]})

        echo -e "${colorgris}La secucencia queda de la sigiente forma:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
            if [ "${#mi_sec[@]}" -ne 1 ] && [ "${#mi_sec[@]}" -ne 0 ]; then
               bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
            elif [ "${#mi_sec[@]}" -eq 1 ]; then
               bet=${mi_sec[0]}
            else
               echo -e "${colorrojo}[!]Hemos perdido la secuencia${fincolor}"
               mi_sec=(1 2 3 4)
               echo -e "${colorgris}Restableciendo secuencia a${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
               bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
            fi  
      fi

    fi
    if [ "$par_impar" == "impar" ]; then
          if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
            echo -e "${colorgris}El numero es impar,${fincolor} ${colorverde}GANAS!${fincolor}"
            premio=$(($bet*2))
            money=$(($money + $premio))
            echo -e "${colorgris}Tenemos:${fincolor} ${colorverde}$money €${fincolor}"
            
            mi_sec+=($bet)
            mi_sec=(${mi_sec[@]})
         
            echo -e "${colorgris}La secuendia se queda en:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
            
            if [ "${#mi_sec[@]}" -ne 1 ]; then
              bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
            elif [ "${#mi_sec[@]}" -eq 1 ]; then
              bet=${mi_sec[0]}
            fi  
          elif [ "$random_number" -eq 0 ]; then
             echo -e "${colorgris}El numero que ha salido es${fincolor} ${colorrojo}0${fincolor}${colorgris}, por lo tanto${fincolor} ${colorrojo}perdemos${fincolor}"
              unset mi_sec[0]
              unset mi_sec[-1] 2>/dev/null

              mi_sec=(${mi_sec[@]})
              echo -e "${colorgris}La secucencia queda de la sigiente forma:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
                if [ "${#mi_sec[@]}" -ne 1 ] && [ "${#mi_sec[@]}" -ne 0 ]; then
                   bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
                elif [ "${#mi_sec[@]}" -eq 1 ]; then
                   bet=${mi_sec[0]}
                else
                   echo -e "${colorrojo}[!]Hemos perdido la secuencia${fincolor}"
                   mi_sec=(1 2 3 4)
                   echo -e "${colorgris}Restableciendo secuencia a${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
                   bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
                fi  
     


               else
            echo -e "${colorgris}El numero es par,${fincolor} ${colorrojo}PIERDES!${fincolor}"
              
              unset mi_sec[0]
              unset mi_sec[-1] 2>/dev/null

              mi_sec=(${mi_sec[@]})

            echo -e "${colorgris}La secucencia queda de la sigiente forma:${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
                if [ "${#mi_sec[@]}" -ne 1 ] && [ "${#mi_sec[@]}" -ne 0 ]; then
                   bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
                elif [ "${#mi_sec[@]}" -eq 1 ]; then
                   bet=${mi_sec[0]}
                else
                   echo -e "${colorrojo}[!]Hemos perdido la secuencia${fincolor}"
                   mi_sec=(1 2 3 4)
                     echo -e "${colorgris}Restableciendo secuencia a${fincolor} ${colormorado}[${mi_sec[@]}]${fincolor}"
                     bet=$((${mi_sec[0]} + ${mi_sec[-1]}))
                  fi  
            fi

          fi

  else
     echo -e "\n${colorrojo}Te has quedado sin pasta${fincolor}"
     echo -e "\n${colorgris}Las jugadas totales han sido:${fincolor}${colormorado}$jugadas_totales${fincolor}" 
     echo -e "\n${colorgris}El tope maximo ha sido:${fincolor}${colormorado}$(($renovar_apuesta - 50))${fincolor}" 
     exit 0
  fi
  #  sleep 4
  done
}

while getopts "m:t:h" arg; do 
  case $arg in 
    m) money="$OPTARG"; let parameter_counter+=1;;
    t) tecnica="$OPTARG"; let parameter_counter+=2;;
    h) heppanel;;
  esac
done

if [ "$money" ] && [ "$tecnica" ]; then
  if [ "$tecnica" == "martingala" ]; then
martingala 
 elif [ "$tecnica" == "inverselabrouchere" ]; then
    inverselabrouchere
  else
    echo -e "\n${colorrojo}[!] La tecnica elegida no existe...${fincolor}"
  fi
else
  helppanel
fi
