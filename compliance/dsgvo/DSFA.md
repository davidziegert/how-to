# Beispiel-Dokumentation: Datenschutz-Folgenabschätzung (DSFA)

Projektname: KI-gestützte Bewerberanalyse
Verantwortlicher: HR-Abteilung, Muster GmbH
Datum: 26.02.2026
DSFA durch: Datenschutzbeauftragter IT & Projektleiter HR

## 1. Beschreibung der geplanten Verarbeitung

Zweck: Automatisierte Analyse von Bewerbungsunterlagen zur Unterstützung der Personalauswahl.

Verarbeitete Daten:
- Name, Adresse, Telefonnummer, E-Mail
- Lebenslaufdaten: Bildung, Berufserfahrung, Qualifikationen
- Optional: Motivationsschreiben, Zeugnisse, Zertifikate
- Sensible Daten: Bewerbungsfotos, Angaben zu Behinderungen (nur wenn freiwillig)

Beteiligte Systeme:
- Bewerbermanagement-Software (Cloud-basiert)
- KI-Analyse-Modul (lokal gehostet, pseudonymisierte Daten)
- Backup- und Archivsysteme

## 2. Notwendigkeit und Verhältnismäßigkeit

- Verarbeitung ist erforderlich, um Bewerbungsprozesse effizient zu gestalten.
- Pseudonymisierung der Bewerberdaten vor KI-Analyse.
- Ergebnisse dienen nur internen HR-Entscheidungen.

Maßnahmen:
- Zugriff nur für HR-Team.
- Kein Export der Daten an externe Parteien.

## 3. Bewertung der Risiken für die Rechte und Freiheiten der Betroffenen

| Risiko | Beschreibung | Eintrittswahrscheinlichkeit | Schwere | Gesamtrisikoeinschätzung |
| :--- | :--- | :--- | :--- | :--- |
| Unbefugter Zugriff | Externe Hacker oder interne unautorisierte Zugriffe | Mittel | Hoch | Hoch |
| Fehlinterpretation durch KI | Diskriminierung von Bewerbern | Mittel | Hoch | Hoch |
| Datenverlust | Technisches Versagen / Backup-Fehler | Niedrig | Mittel | Mittel |
| Zweckentfremdung | Verwendung der Daten für andere HR-Prozesse | Niedrig | Mittel | Mittel |

## 4. Maßnahmen zur Risikominderung

Technische Maßnahmen:
- Verschlüsselung der Daten in Transit und im Ruhezustand
- Rollenbasierte Zugriffssteuerung
- Regelmäßige Sicherheitsupdates
- Backup- und Restore-Tests

Organisatorische Maßnahmen:
- Datenschutzschulungen für HR-Mitarbeiter
- Protokollierung aller Datenzugriffe
- KI-Modell auditiert auf Bias / Diskriminierung
- Einwilligung der Bewerber für KI-gestützte Analyse

## 5. Ergebnis der DSFA

- Risiken wurden identifiziert und bewertet.
- Technische und organisatorische Maßnahmen verringern Risiken auf ein akzeptables Niveau.

Empfehlung: Projekt kann umgesetzt werden unter Einhaltung der DSFA-Maßnahmen.

## 6. Monitoring & Review

- Halbjährliche Überprüfung der DSFA und Sicherheitsmaßnahmen
- Überprüfung der KI-Ergebnisse auf Diskriminierung
- Dokumentation von Vorfällen oder Datenschutzverletzungen