# Datenmanagement

## Kurzfassung

Datenmanagement umfasst alle Prozesse zur Erfassung, Speicherung, Organisation, Qualitätssicherung und Nutzung von Daten innerhalb einer Organisation. Ziel ist es, Daten als strategische Ressource zu nutzen, um fundierte Entscheidungen zu treffen und Geschäftsprozesse zu optimieren.

Ein zentraler Bestandteil ist die Datenstrategie, die festlegt, welche Daten benötigt werden, wie sie gesammelt und verarbeitet werden und welchen Beitrag sie zur Erreichung der Unternehmensziele leisten. Unterstützt wird dies durch Data Governance, die Richtlinien, Rollen und Verantwortlichkeiten für den Umgang mit Daten definiert. Typische Rollen sind beispielsweise Data Owner und Data Stewards, die für Datenqualität und korrekte Nutzung verantwortlich sind.

Ein weiterer wichtiger Aspekt ist die Datenarchitektur, die beschreibt, wie Daten strukturiert, gespeichert und zwischen Systemen integriert werden. Hier kommen Technologien wie Data Warehouses, Data Lakes oder ETL/ELT-Prozesse zum Einsatz. Gleichzeitig spielt das Datenqualitätsmanagement eine zentrale Rolle, um sicherzustellen, dass Daten vollständig, korrekt und aktuell sind. Methoden wie Datenprofilierung, Datenbereinigung und kontinuierliches Monitoring unterstützen diesen Prozess.

Unternehmen arbeiten zudem mit unterschiedlichen Datentypen, darunter strukturierte Daten (z. B. Tabellen), unstrukturierte Daten (z. B. Texte oder Bilder) sowie semi-strukturierte Daten wie JSON oder XML.

Neben technischen Aspekten sind auch Datenschutz, Datensicherheit und Compliance, beispielsweise im Rahmen der DSGVO, essenziell. Ergänzend hilft ein Datenmanagementplan (DMP) dabei, den gesamten Lebenszyklus der Daten - von der Erhebung bis zur Archivierung oder Löschung - strukturiert zu planen.

Insgesamt erfordert erfolgreiches Datenmanagement das Zusammenspiel von Strategie, Technologie, klaren Verantwortlichkeiten und kontinuierlicher Sicherung der Datenqualität.

## 1. Methoden und Verfahren des Datenmanagements

Dieser Abschnitt beschreibt die zentralen Methoden und technischen Ansätze des modernen Datenmanagements. Ziel ist es, Daten als strategische Ressource zu strukturieren, zu sichern, zu integrieren und für Analysen nutzbar zu machen.

Die wichtigsten Bereiche sind:

### 1. Strategie und Governance

- Data Governance Framework definiert Richtlinien, Standards und Verantwortlichkeiten für den Umgang mit Daten.
- Data Lifecycle Management (DLM) beschreibt die Verwaltung von Daten über ihren gesamten Lebenszyklus - von der Erfassung bis zur Archivierung oder Löschung.
- Data Stewardship sorgt durch verantwortliche Personen für Datenqualität und Einhaltung von Regeln.

### 2. Datenqualitätsmanagement

Zur Sicherstellung zuverlässiger Daten werden verschiedene Methoden eingesetzt:

- Datenprofilierung zur Analyse von Struktur und Inhalt von Daten
- Datenbereinigung zur Korrektur von Fehlern und Entfernung von Dubletten
- Datenvalidierung zur Prüfung anhand definierter Regeln
- Data Monitoring zur kontinuierlichen Überwachung der Datenqualität

### 3. Datenarchitektur und Integration

Die technische Infrastruktur des Datenmanagements umfasst:

- Data Mesh / Data Fabric als moderne, dezentrale Datenarchitekturen
- ETL- bzw. ELT-Prozesse zur Integration und Transformation von Daten
- Data Warehouses und Data Lakes zur Speicherung strukturierter bzw. unstrukturierter Daten
- Master Data Management (MDM) zur Sicherstellung konsistenter Stammdaten

### 4. Analyse und Nutzung von Daten

Daten werden durch Analyseverfahren nutzbar gemacht:

- CRISP-DM und Data Mining als strukturierte Analyseprozesse
- Vier Analysearten: Descriptive, Diagnostic, Predictive und Prescriptive Analytics
- Metadatenmanagement zur Dokumentation von Datenherkunft und -struktur.

## 2 - Grundlagen und Organisation des Datenmanagements

Dieser Abschnitt beschreibt die organisatorischen und konzeptionellen Grundlagen des Datenmanagements sowie die unterschiedlichen Datenarten.

### Definition

Datenmanagement umfasst die Planung, Organisation und Kontrolle aller Prozesse, die notwendig sind, um Daten zu erfassen, zu speichern, zu verarbeiten und zu analysieren. Dabei spielen sowohl technische Lösungen als auch organisatorische Maßnahmen eine Rolle.

### Arten von Unternehmensdaten

Unternehmen arbeiten mit verschiedenen Datentypen, beispielsweise:

- Kundendaten
- Transaktionsdaten
- Stammdaten
- Finanzdaten
- Verhaltens- und Marketingdaten
- Produktionsdaten
- Audit- und Referenzdaten

Diese Daten werden je nach Zweck unterschiedlich verwaltet und analysiert. Strukturierte, unstrukturierte und semi-strukturierte Daten.

- Strukturierte Daten: klar definierte Formate (z. B. Tabellen oder Datenbanken)
- Unstrukturierte Daten: z. B. Texte, Bilder, Videos oder E-Mails
- Semi-strukturierte Daten: Mischformen wie JSON, XML oder Logdateien

Diese unterschiedlichen Datenformen erfordern unterschiedliche Speicher- und Analyseverfahren.

### Grunddisziplinen des Datenmanagements

- Datenstrategie
  - definiert Ziele und Nutzen von Daten
  - legt fest, wie Daten gesammelt und verwendet werden
- Rollen und Verantwortlichkeiten
  - z. B. Data Owner und Data Steward
  - klare Zugriffsrechte und Verantwortlichkeiten
- Datenarchitektur
  - strukturiert die Speicherung und Integration von Daten aus verschiedenen Quellen.
- Datenqualitätsmanagement
  - stellt sicher, dass Daten vollständig, korrekt und aktuell sind.
- Datenschutz und Compliance
  - Einhaltung gesetzlicher Vorgaben wie DSGVO
  - Transparenz bei Datenerhebung und -nutzung
  - Schutz personenbezogener Daten.

## 3 - Komponenten und Strategie des Datenmanagements

Dieser Abschnitt beschreibt die strategischen Bausteine einer ganzheitlichen Datenmanagementstrategie.

### Grundverständnis

Datenmanagement umfasst die Verwaltung und Nutzung von Daten über den gesamten Lebenszyklus hinweg.
Eine zentrale Rolle spielt die Datenstrategie, die festlegt, wie Daten zur Verbesserung von Geschäftsprozessen eingesetzt werden.

Datenmanagement ist heute eine unternehmensweite Aufgabe und nicht mehr nur auf die IT-Abteilung beschränkt.

### Wichtige Komponenten des Datenmanagements

- Datenarchitektur
  - strukturelles Fundament der Datenverwaltung
  - definiert Datenstrukturen und Systeme.
- Data Governance und Stammdatenmanagement
  - Regeln und Prozesse zur Sicherstellung konsistenter Daten
  - Verwaltung zentraler Unternehmensdaten (Stammdaten).
- Datenmodellierung und -design
  - Gestaltung von Datenbanken und Datenstrukturen.
- Datensicherheit
  - Schutz vor unbefugtem Zugriff
  - sichere Speicherung und verantwortungsvolle Löschung von Daten.
- Datenintegration und Interoperabilität
  - Zusammenführung von Daten aus unterschiedlichen Systemen
  - Grundlage für Analysen und Reporting.
- Datenqualitätsmanagement
  - kontinuierliche Überwachung und Verbesserung der Datenqualität.

### Umsetzung einer Datenmanagementstrategie

Wichtige Schritte sind:

- Definition von Rollen und Verantwortlichkeiten im Datenmanagement
- Festlegung von Datenprozessen für Erfassung, Speicherung und Nutzung
- Auswahl geeigneter Technologien und Fachkräfte
- Etablierung von Data Governance zur Sicherstellung von Qualität, Sicherheit und Compliance.

## 4 - Ergänzende wichtige Aspekte des Datenmanagements

### Datenmanagementplan ([DMP](./DMP.md))

Ein Datenmanagementplan beschreibt wie Daten im gesamten Projekt oder Unternehmen verwaltet werden. Typische Inhalte sind:

- Datenerhebung und Datenquellen
- Speicherorte und Backup-Strategien
- Datenformate und Metadaten
- Zugriffsrechte und Datenschutz
- Archivierung und Löschung der Daten

DMPs werden besonders in Forschungsprojekten und Förderprogrammen verlangt.

### FAIR-Prinzipien

Moderne Datenstrategien orientieren sich häufig an den FAIR-Prinzipien:

- Findable - Daten müssen auffindbar sein
- Accessible - Daten müssen zugänglich sein
- Interoperable - Daten müssen kompatibel mit verschiedenen Systemen sein
- Reusable - Daten sollen wiederverwendbar sein

### Datenlebenszyklus

Ein vollständiges Datenmanagement berücksichtigt den gesamten Data Lifecycle:

- Datenerfassung
- Speicherung
- Verarbeitung
- Analyse und Nutzung
- Archivierung oder Löschung
