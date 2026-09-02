#!/usr/bin/env bash
# Prueft die Erreichbarkeit der fuer die Analyse benoetigten Datenquellen (Schritt 0 des Auftrags).
# Ergebnis wird nach logs/network_access_check.log geschrieben (mit Zeitstempel).
set -uo pipefail

LOGFILE="$(dirname "$0")/../logs/network_access_check.log"
mkdir -p "$(dirname "$LOGFILE")"

DOMAINS=(
  "https://geo.apps.be.ch"
  "https://agi.dij.be.ch"
  "https://api3.geo.admin.ch/rest/services"
  "https://map.geo.admin.ch"
  "https://opendata.swiss"
  "https://regiogis.ch"
  "https://www.immoscout24.ch"
  "https://www.homegate.ch"
  "https://www.comparis.ch"
  "https://www.realadvisor.ch"
)

{
  echo "Netzwerk-Erreichbarkeitspruefung: $(date -u +%FT%TZ)"
  echo "================================================================"
  for url in "${DOMAINS[@]}"; do
    echo -n "$url -> "
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 15 "$url")
    if [ "$code" = "000" ]; then
      echo "KEIN VERBINDUNGSAUFBAU (Proxy/Gateway blockiert die Domain, HTTP 000)"
    else
      echo "HTTP $code"
    fi
  done
  echo "================================================================"
} | tee "$LOGFILE"
