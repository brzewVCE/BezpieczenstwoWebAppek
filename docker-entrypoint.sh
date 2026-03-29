#!/bin/bash
set -e

echo "[*] Starting services..."

/run.sh &

echo "[*] Waiting for services..."
sleep 10

until curl -s http://localhost > /dev/null; do
  sleep 2
done

echo "[*] Checking if bWAPP is initialized..."

if ! mysql -uroot -e "USE bWAPP;" >/dev/null 2>&1; then
  echo "[*] Initializing bWAPP via install.php..."

  curl -s http://localhost/install.php?install=yes > /dev/null

  echo "[+] bWAPP initialized!"
else
  echo "[*] Database already exists, skipping init."
fi

wait
