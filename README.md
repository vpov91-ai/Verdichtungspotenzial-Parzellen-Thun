# Verdichtungspotenzial Parzellen Thunersee

Systematische Analyse von Grundstücken im Raum Thunersee (Thun/Gwatt, Einigen/Spiez,
Hünibach/Hilterfingen, Oberhofen am Thunersee, Gunten/Sigriswil) auf Verdichtungspotenzial
(Ersatzneubau MFH statt bestehendem EFH).

## Status: Datenerhebung blockiert (siehe unten)

**Der eigentliche Analyseauftrag (Schritte 1–11) konnte in dieser Ausführungsumgebung nicht
durchgeführt werden.** Grund: Schritt 0 des Auftrags (Netzwerkzugriff verifizieren) zeigt, dass
alle benötigten Datenquellen durch die Netzwerk-Egress-Policy dieser Umgebung blockiert sind:

| Domain | Zweck | Ergebnis |
|---|---|---|
| geo.apps.be.ch | Kanton Bern Geoportal (Grundeigentum) | blockiert (403 am Proxy-Gateway) |
| agi.dij.be.ch | Amt für Geoinformation Kanton Bern | blockiert (403 am Proxy-Gateway) |
| api3.geo.admin.ch | Bundes-Geoportal REST-API | blockiert (403 am Proxy-Gateway) |
| map.geo.admin.ch | Bundes-Geoportal Kartenviewer | blockiert (403 am Proxy-Gateway) |
| opendata.swiss | Open-Data-Portal Schweiz | blockiert (403 am Proxy-Gateway) |
| regiogis.ch | Zonenpläne Region Thun | blockiert (403 am Proxy-Gateway) |
| immoscout24.ch | Vergleichspreise | blockiert (403 am Proxy-Gateway) |
| homegate.ch | Vergleichspreise | blockiert (403 am Proxy-Gateway) |
| comparis.ch | Vergleichspreise | blockiert (403 am Proxy-Gateway) |
| realadvisor.ch | Vergleichspreise | blockiert (403 am Proxy-Gateway) |

Das ist eine Netzwerk-Policy-Blockade dieser Ausführungsumgebung (Gateway antwortet mit
`403` auf den `CONNECT`, bevor die Zielserver überhaupt erreicht werden) – kein Login-/Bot-Schutz
der Zielseiten und kein TLS-/Zertifikatsproblem. Rohbelege: [`logs/network_access_check.log`](logs/network_access_check.log).

Gemäss Auftragsvorgabe ("Bei Blockade dokumentieren statt mit Schätzwerten weiterarbeiten",
"Keine geschätzten/erfundenen Zahlen") wurden **keine** Platzhalter- oder Schätzwerte für
Fläche, Zone, Preis oder Eigentümer erzeugt. Stattdessen enthält
[`output/verdichtungspotenzial_thun.xlsx`](output/verdichtungspotenzial_thun.xlsx) die korrekte
Spaltenstruktur (Tabellenblatt "Parzellen", mit AutoFilter) ohne Dateninhalte, plus ein
zweites Tabellenblatt "Methodik & Quellen" mit vollständiger Dokumentation der Blockade und
den nächsten Schritten.

## Nächste Schritte

1. Netzwerk-Egress-Policy dieser Umgebung für die zehn oben genannten Domains freigeben
   (nur durch Owner/Admin der Ausführungsumgebung möglich), oder
2. Auftrag in einer Umgebung mit freiem Internetzugang erneut starten.
3. Danach: Schritte 0–12 des ursprünglichen Auftrags ausführen (Pilotlauf Thun/Gwatt zuerst,
   Zwischenstand melden, danach Ausweitung auf die übrigen 4 Gemeinden).

## Inhalt dieses Repos

- `scripts/00_check_network_access.sh` – Erreichbarkeitsprüfung der Datenquellen (Schritt 0).
- `scripts/01_build_workbook.py` – Erzeugt `output/verdichtungspotenzial_thun.xlsx`.
- `logs/network_access_check.log` – Rohprotokoll der Verbindungstests.
- `output/verdichtungspotenzial_thun.xlsx` – Ergebnisdatei (Struktur + Methodik, 0 Datenzeilen).
