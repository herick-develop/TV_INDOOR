#!/bin/bash

MAX_ATTEMPTS=5

get_elapsed_time() {
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  echo "$elapsed_time"
}

execute_ares_extend_dev() {
  attempts=0
  while [ $attempts -lt $MAX_ATTEMPTS ]; do
    # Executa o ares-extend-dev para tv_ti
    ./ares-extend-dev -d tv_ti
    if [ $? -eq 0 ]; then
      break  # Sai do loop se o comando for bem-sucedido
    else
      attempts=$((attempts + 1))
      echo "Tentativa $attempts de $MAX_ATTEMPTS: O comando ares-extend-dev para tv_ti falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done

  attempts=0
  while [ $attempts -lt $MAX_ATTEMPTS ]; do
    # Executa o ares-extend-dev para farmacia
    ./ares-extend-dev -d frm_umuarama
    if [ $? -eq 0 ]; then
      break  # Sai do loop se o comando for bem-sucedido
    else
      attempts=$((attempts + 1))
      echo "Tentativa $attempts de $MAX_ATTEMPTS: O comando ares-extend-dev para farmacia falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done
}

start_time=$(date +%s)

while true; do
  elapsed_time=$(get_elapsed_time)
  if [ "$elapsed_time" -ge 21600 ]; then
    execute_ares_extend_dev  # Executa a função
    start_time=$(date +%s)  # Reinicializa o tempo de início
  fi
  sleep 21600  # Espera 6 horas (21600 segundos) antes de verificar novamente
done
