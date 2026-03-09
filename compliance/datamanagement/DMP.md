# Beispiel: Datenmanagementplan für ein Forschungsprojekt

## 1. Projektbeschreibung und Zielsetzung

Dieses Forschungsprojekt untersucht [Thema einfügen, z. B. Nutzerverhalten in digitalen Lernplattformen]. Ziel ist es, durch die Analyse verschiedener Datentypen Erkenntnisse über [Forschungsfrage] zu gewinnen.

Während des Projekts entstehen mehrere Datentypen, darunter:

- Umfragedaten (strukturierte Daten)
- Nutzungsprotokolle der Plattform (semi-strukturierte Logdaten)
- Interviewtranskripte (unstrukturierte Textdaten)
- Analyseergebnisse und Visualisierungen

Der folgende Datenmanagementplan beschreibt, wie diese Daten erhoben, gespeichert, dokumentiert, gesichert und langfristig verfügbar gemacht werden.

## 2. Datentypen und Datenformate

### Datentypen

Im Projekt werden folgende Daten erhoben oder erzeugt:

- Primärdaten: Umfrageergebnisse und Interviewdaten
- Sekundärdaten: bereits vorhandene Datensätze oder öffentliche Datenquellen
- Prozessdaten: Logdateien und Analyseprotokolle
- Analyseergebnisse: statistische Auswertungen, Visualisierungen und Modelle

### Datenformate

Zur Sicherstellung der langfristigen Nutzbarkeit werden möglichst offene und standardisierte Formate verwendet:

| Datentyp         | Format                        |
| ---------------- | ----------------------------- |
| Umfragedaten     | CSV, XLSX                     |
| Interviews       | TXT, PDF                      |
| Logdaten         | JSON                          |
| Analysen         | Python/Jupyter Notebooks, CSV |
| Visualisierungen | PNG, SVG                      |

## 3. Datenerhebung und Datenquellen

Die Datenerhebung erfolgt durch:

- Online-Umfragen
- qualitative Interviews mit Teilnehmern
- automatisierte Systemlogs der Plattform
- ergänzende öffentlich verfügbare Datensätze

Alle Teilnehmenden geben vor der Teilnahme eine informierte Einwilligung zur Datennutzung. Die Datenerhebung erfolgt unter Einhaltung der Datenschutzgrundverordnung (DSGVO).

## 4. Organisation, Dokumentation und Metadaten

Zur Sicherstellung der Nachvollziehbarkeit werden Daten umfassend dokumentiert.

Metadaten enthalten:

- Beschreibung des Datensatzes
- Erhebungsmethode
- Variablenbeschreibung
- Zeit- und Ortsangaben
- Verantwortliche Person

Die Dokumentation erfolgt in:

- README-Dateien für Datensätze
- Codebooks mit Variablenbeschreibungen
- Dokumentation der Datenerhebung und Analyseverfahren
- Versionierung der Analyse-Skripte (z. B. Git)

Diese Metadaten ermöglichen eine spätere Interpretation und Wiederverwendung der Daten.

## 5. Datenspeicherung und Datensicherheit

Während des Projekts werden Daten in einer gesicherten Forschungsumgebung gespeichert.

Sicherheitsmaßnahmen:

- Zugriff nur für autorisierte Projektmitglieder
- Passwortschutz und Nutzerverwaltung
- regelmäßige Backups
- Verschlüsselung sensibler Daten
- Backups erfolgen regelmäßig auf institutionellen Servern sowie in gesicherten Cloud-Speichern.
- Personenbezogene Daten werden pseudonymisiert oder anonymisiert, bevor sie weitergegeben oder veröffentlicht werden.

## 6. Datenqualität und Qualitätskontrolle

Die Qualität der Forschungsdaten wird durch mehrere Maßnahmen sichergestellt:

- Datenvalidierung bei der Datenerhebung
- regelmäßige Datenbereinigung
- Plausibilitätsprüfungen
- Dokumentation von Änderungen

Diese Maßnahmen gewährleisten konsistente und verlässliche Datensätze.

## 7. FAIR-Prinzipien

Die Forschungsdaten werden gemäß den FAIR-Prinzipien verwaltet.

Findable (auffindbar)

- Die Datensätze werden in einem Forschungsdatenrepositorium veröffentlicht und erhalten einen persistenten Identifikator (z. B. DOI).

Accessible (zugänglich)

- Die Daten werden öffentlich zugänglich gemacht, sofern keine Datenschutzbeschränkungen bestehen.

Interoperable (interoperabel)

- Nutzung standardisierter Datenformate
- Verwendung etablierter Metadatenstandards

Reusable (wiederverwendbar)

- ausführliche Dokumentation der Datensätze
- Veröffentlichung unter offenen Lizenzen (z. B. Creative Commons)

Es werden offene Datenformate und standardisierte Metadaten verwendet.

## 8. Datenlebenszyklus

Der Umgang mit den Daten orientiert sich am folgenden Lebenszyklus:

Planung

- Definition von Datentypen, Formaten und Methoden der Datenerhebung.

Datenerhebung

- Sammlung von Daten durch Umfragen, Interviews und Systemlogs.

Datenverarbeitung

- Bereinigung, Strukturierung und Integration der Daten.

Analyse

- Statistische Auswertung und Modellierung.

Publikation und Sharing

- Veröffentlichung von Datensätzen und Analyseergebnissen.

Archivierung

- langfristige Speicherung in einem Forschungsdatenrepositorium.

Nachnutzung oder Löschung

- Daten werden entweder wiederverwendet oder gemäß Datenschutzrichtlinien gelöscht.

## 9. Archivierung und Langzeitverfügbarkeit

Nach Abschluss des Projekts werden relevante Datensätze in einem Forschungsdatenrepositorium (z. B. institutionelles Repository oder Zenodo) archiviert.

Archivierungsmaßnahmen:

- Speicherung in offenen Formaten
- Vergabe von DOIs
- langfristige Aufbewahrung (mindestens 10 Jahre)
- Nicht anonymisierbare personenbezogene Daten werden nach Projektabschluss gelöscht.

## Fazit

Der Datenmanagementplan stellt sicher, dass Forschungsdaten strukturiert erhoben, sicher gespeichert, nachvollziehbar dokumentiert und langfristig verfügbar gemacht werden. Durch die Anwendung der FAIR-Prinzipien und des Datenlebenszyklus wird eine nachhaltige Nutzung der Daten ermöglicht und die Transparenz wissenschaftlicher Forschung erhöht.
