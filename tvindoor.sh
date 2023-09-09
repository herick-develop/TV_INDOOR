#!/bin/bash

# Define a função para executar o ares-extend-dev até que tenha sucesso
execute_ares_extend_dev() {
  while true; do
    # Executa o ares-extend-dev para tv_ti
    ares-extend-dev -d tv_ti
    if [ $? -eq 0 ]; then
      break  # Sai do loop se o comando for bem-sucedido
    else
      echo "O comando ares-extend-dev para tv_ti falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done

  while true; do
    # Executa o ares-extend-dev para farmacia
    ares-extend-dev -d farmacia
    if [ $? -eq 0 ]; then
      break  # Sai do loop se o comando for bem-sucedido
    else
      echo "O comando ares-extend-dev para farmacia falhou. Tentando novamente em 10 segundos."
      sleep 10
    fi
  done
}

# Função para calcular o tempo decorrido em segundos desde o início do script
get_elapsed_time() {
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  echo "$elapsed_time"
}

# Inicializa o tempo de início do script
start_time=$(date +%s)

# Loop principal
while true; do
  # Calcula o tempo decorrido desde o início do script em segundos
  elapsed_time=$(get_elapsed_time)

  # Verifica se já se passaram 995 horas (3594000 segundos)
  if [ "$elapsed_time" -ge 3594000 ]; then
    execute_ares_extend_dev  # Executa a função
    start_time=$(date +%s)  # Reinicializa o tempo de início
  fi

  # Resto do seu script aqui
  ping -c 1 10.11.50.27
  if [ $? -eq 0 ]; then
    ares-launch --device tv_ti com.tvti.app &
  fi
  sleep 15

  ping -c 1 10.11.50.240
  if [ $? -eq 0 ]; then
    ares-launch --device farmacia com.tvindoor.app
  fi
  sleep 15
done
