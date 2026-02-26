# DSGVO

## 1. Einführung: Was ist die DSGVO?

Die Datenschutz-Grundverordnung (DSGVO) ist eine EU-Verordnung zum Schutz personenbezogener Daten. Sie gilt seit dem 25. Mai 2018 unmittelbar in allen EU-Mitgliedstaaten und betrifft jedes Unternehmen, das personenbezogene Daten von Personen in der EU verarbeitet – unabhängig vom Unternehmenssitz.

Ziele:
- Schutz der Grundrechte und -freiheiten natürlicher Personen
- Einheitliche Datenschutzstandards in der EU
- Stärkung der Betroffenenrechte
- Rechenschaftspflicht für Unternehmen

## 2. Grundprinzipien der DSGVO (Art. 5)

### 2.1 Rechtmäßigkeit, Verarbeitung nach Treu und Glauben, Transparenz

Daten dürfen nur auf einer gültigen Rechtsgrundlage verarbeitet werden (z. B. Vertrag, Einwilligung).

Praxisbeispiel (IT-Abteilung):
Ein CRM-System darf Kundendaten nur speichern, wenn:
- ein Vertrag besteht oder
- eine dokumentierte Einwilligung vorliegt.

### 2.2 Zweckbindung

Daten dürfen nur für festgelegte, eindeutige Zwecke verarbeitet werden.

Praxisbeispiel:
- E-Mail-Adressen aus einer Supportanfrage dürfen nicht automatisch für Marketing verwendet werden.

### 2.3 Datenminimierung

Nur so viele Daten erheben wie nötig.

Praxisbeispiel:
- Ein Download-Formular benötigt keine Telefonnummer, wenn sie nicht erforderlich ist.

### 2.4 Speicherbegrenzung

Daten dürfen nicht unbegrenzt gespeichert werden.

Praxisbeispiel:
- Automatische Löschroutinen im ERP-System nach 10 Jahren für steuerrelevante Dokumente.

### 2.5 Integrität und Vertraulichkeit

Technische und organisatorische Maßnahmen (TOM) sind verpflichtend. (siehe Punkt 6.)

## 3. Personenbezogene Daten

Personenbezogene Daten sind alle Informationen, die sich auf eine identifizierte oder identifizierbare Person beziehen.

Beispiele:
- Name, Adresse
- IP-Adresse
- Geräte-ID
- Standortdaten
- Bewerberdaten
- Kundennummer (wenn rückführbar)
- Besonders sensible Daten (Art. 9 DSGVO):
    - Gesundheitsdaten
    - Religionszugehörigkeit
    - Biometrische Daten

IT-Beispiel:
- Ein Logfile mit IP-Adresse + Zeitstempel = personenbezogen.

## 4. Rollen: Verantwortlicher vs. Auftragsverarbeiter

### Verantwortlicher
Bestimmt Zweck und Mittel der Verarbeitung.

Beispiel:
- Ein Online-Shop-Betreiber.

### Auftragsverarbeiter

Verarbeitet Daten im Auftrag.

Beispiel:
- Cloud-Hosting-Anbieter wie
    - Amazon Web Services
    - Microsoft Azure
    - Google Cloud

→ Erfordert Auftragsverarbeitungsvertrag (AVV).

## 5. Rechtsgrundlagen in der Praxis

### 5.1 Vertragserfüllung

Beispiel: Speicherung von Lieferadresse im Shopsystem.

### 5.2 Einwilligung

Beispiel: Newsletter-Anmeldung mit Double-Opt-In.

### 5.3 Berechtigtes Interesse

Beispiel: Videoüberwachung im Rechenzentrum.

## 6. Technische und organisatorische Maßnahmen (TOM)

Art. 32 DSGVO verlangt „angemessene Sicherheit“.

Dokumentationsbeispiel siehe [hier](./TOM.md)

## 7. Betroffenenrechte (IT-Umsetzung entscheidend)

### 7.1 Auskunftsrecht

Betroffene können verlangen:

- Welche Daten?
- Wo gespeichert?
- Zweck?
- Empfänger?

IT-Praxis:
Unternehmen müssen Daten aus:
- CRM
- ERP
- Ticketsystem
- HR-System
- Backups (eingeschränkt)

zusammenführen können.

### 7.2 Recht auf Löschung („Recht auf Vergessenwerden“)

Praxisbeispiel:
- Ein ehemaliger Nutzer verlangt Löschung:
    - Account deaktivieren
    - Daten aus Produktivsystem löschen
    - Archiv- und Testsysteme berücksichtigen

### 7.3 Recht auf Datenübertragbarkeit

Daten müssen maschinenlesbar bereitgestellt werden (z. B. JSON, CSV).

## 8. Datenschutz-Folgenabschätzung (DSFA)

Erforderlich bei hohem Risiko.

Dokumentationsbeispiel siehe [hier](./DSFA.md)

## 9. Datenschutzverletzungen (Data Breach)

Meldepflicht:
- binnen 72 Stunden an die Aufsichtsbehörde
- ggf. Information der Betroffenen

Praxisfall:
- Ein falsch konfigurierter S3-Bucket speichert Kundendaten öffentlich zugänglich.

Konsequenzen:
- Incident-Analyse
- Meldung
- Dokumentation
- Sicherheitsanpassungen

## 10. Bußgelder

Bis zu: 20 Mio. € oder 4 % des weltweiten Jahresumsatzes

## 11. DSGVO im IT-Arbeitsalltag

### 11.1 Softwareentwicklung (Privacy by Design & Default)

- Minimale Datenerhebung
- Standardmäßig deaktivierte Tracking-Funktionen
- Pseudonymisierung

Beispiel:
- Ein neues Kundenportal speichert nur Hashwerte statt Klartext-IDs.

### 11.2 Cloud-Nutzung

Checkliste:
- AVV abgeschlossen?
- Serverstandort EU?
- Verschlüsselung aktiv?
- Zugriff dokumentiert?

### 11.3 HR-IT

- Bewerberdaten nach 6 Monaten löschen
- Zugriff nur für HR
- Keine private Cloud-Speicherung

### 11.4 IT-Support

Ticket-System:
- Keine unnötigen Screenshots mit sensiblen Daten
- Protokollierung von Zugriffen

### 11.5 Forschung und Forschungsdaten

Die Verarbeitung personenbezogener Daten in der Forschung erfordert besondere Sorgfalt, insbesondere bei sensiblen Daten (z. B. Gesundheitsdaten, Genomdaten, psychologische Daten). Ziel ist, Forschungsfortschritt zu ermöglichen, ohne die Rechte der Betroffenen zu verletzen.

Praxisbeispiele:
- Pseudonymisierung und Anonymisierung
- Originaldaten werden pseudonymisiert (z. B. durch ID-Nummern ersetzt) oder anonymisiert, bevor sie für Analysen genutzt werden.

Beispiel: Ein klinisches Studienprojekt speichert Patienten-Daten mit Codes, die nur ein verschlüsseltes Schlüsselmapping im IT-System auflösen kann. Analysten sehen nur die Pseudonyme.

#### Zugriffs- und Rollenmanagement

Nur Forscher mit berechtigtem Projektzugang dürfen personenbezogene Daten sehen.

Beispiel: Ein universitäres Rechenzentrum nutzt rollenbasierte Berechtigungen: Datenanalysten erhalten nur aggregierte Datensätze, während Projektleiter Zugriff auf pseudonymisierte Rohdaten haben.

#### Datenverarbeitung in der Cloud

Cloud-Anbieter müssen DSGVO-konform sein, Standort der Server in der EU oder mit Standardvertragsklauseln.

Beispiel: Ein Bioinformatik-Labor nutzt Azure EU-Regionen für Genomdaten und verschlüsselt Daten „at rest“ und „in transit“.

#### Einwilligung und Zweckbindung

Teilnehmer müssen informiert werden, wofür ihre Daten genutzt werden. Einmal erfasste Daten dürfen nur für genehmigte Forschungszwecke genutzt werden.

Beispiel: Forschungsplattform für soziale Verhaltensstudien: Teilnehmer geben Einwilligung für die aktuelle Studie, ihre Daten werden nicht automatisch für andere Studien freigegeben.

#### Langzeitarchivierung

Forschungsdaten werden oft über Jahre gespeichert. IT-Systeme müssen Löschfristen dokumentieren, pseudonymisierte Versionen können länger behalten werden.

Beispiel: Ein Langzeitprojekt speichert Rohdaten 15 Jahre in verschlüsselten Archiv-Volumes, pseudonymisierte Analysedaten bleiben 25 Jahre verfügbar.

#### Datensicherheitsmaßnahmen

Backup, Verschlüsselung, Audit-Trails für Forschungsdaten.

Beispiel: Ein Labor implementiert tägliche Backups, die verschlüsselt und versioniert in einer separaten Storage-Lösung abgelegt werden. Jede Datenabfrage wird protokolliert.

## 12. Typische DSGVO-Risiken in IT-Projekten

- Shadow IT
- Unverschlüsselte Backups
- Unklare Löschkonzepte
- Fehlende Rollenmodelle
- Alte Testdaten mit Echtdaten

## 13. Best Practices für IT-Abteilungen

- Verzeichnis der Verarbeitungstätigkeiten pflegen
- Regelmäßige Security-Audits
- Penetrationstests
- Verschlüsselung „at rest“ & „in transit“
- Logging & Monitoring
- Automatisierte Löschkonzepte
- Schulungen für Entwickler

## 14. Fazit

Die DSGVO ist kein reines „Rechts-Thema“, sondern ein IT-Kernthema.

Moderne Datenschutz-Compliance bedeutet:
- Sicherheit technisch umsetzen
- Prozesse dokumentieren
- Transparenz schaffen
- Risiken aktiv managen

Unternehmen, die Datenschutz strategisch in ihre IT-Architektur integrieren, profitieren langfristig durch:
- Vertrauen der Kunden
- Weniger Sicherheitsvorfälle
- Bessere Datenqualität
- Wettbewerbsvorteile