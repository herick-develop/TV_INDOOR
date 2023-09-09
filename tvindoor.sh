execute_ares_extend_dev() {
  while true; do

    ares-extend-dev -d tv_ti
    if [ $? -eq 0 ]; then
      break  
    else
      echo "O comando ares-extend-dev para tv_ti falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done

  while true; do

    ares-extend-dev -d farmacia
    if [ $? -eq 0 ]; then
      break
    else
      echo "O comando ares-extend-dev para farmacia falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done
}

get_elapsed_time() {
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  echo "$elapsed_time"
}

start_time=$(date +%s)

while true; do

  elapsed_time=$(get_elapsed_time)

  if [ "$elapsed_time" -ge 3594000 ]; then #token expires
    execute_ares_extend_dev  
    start_time=$(date +%s)  
  fi

  ping -c 1 $IPTV_ONE #IPTV
  if [ $? -eq 0 ]; then
    ares-launch --device $name_TV_ONE $name_APP_ONE
  fi
  sleep 15

  ping -c 1 $IPTV_TWO #IPTV
  if [ $? -eq 0 ]; then
    ares-launch --device $name_TV_TWO $name_APP_TWO
  fi
  sleep 15
done
