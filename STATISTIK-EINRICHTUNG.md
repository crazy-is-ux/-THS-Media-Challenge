# THS Media Challenge – QR-Codes und Statistik

## Fertig eingerichtet
- QR-Code 1 führt zur Bild- und Medien-Challenge (index.html).
- QR-Code 2 führt zum Webseiten-Check (webseiten-check.html).
- Die beiden Quizze senden nach Abschluss ihre anonymen Antworten an die konfigurierte Datenbank.
- auswertung.html zeigt Fehlerquoten pro Frage und Teilnehmerzahlen.

## Einmalige Aktivierung der Datenbank
1. Kostenloses Supabase-Projekt anlegen.
2. In Supabase > SQL Editor den Inhalt von supabase-setup.sql ausführen.
3. Unter Project Settings > API die **Project URL** und den **anon/publishable key** kopieren.
4. In stats.js bei THS_CONFIG url und anonKey eintragen. **Niemals service_role/secret key verwenden.**
5. GitHub Pages aktualisieren lassen und beide Quizze testweise abschließen.
6. auswertung.html öffnen. Wenn Ergebnisse erscheinen, funktioniert die Statistik.

## Datenschutz und Grenzen
Es werden keine Namen, E-Mail-Adressen oder Antworten im Browser dauerhaft gespeichert. In der Supabase-Tabelle stehen Quiztyp, Antwort-Richtig/Falsch pro Frage und Zeitstempel. Server können technisch Verbindungsmetadaten protokollieren. Bei einer öffentlichen Schulveranstaltung sollte die Schule die datenschutzrechtliche Freigabe klären und einen Hinweis am QR-Plakat anbringen.

Das Dashboard ist öffentlich aufrufbar und zeigt nur aggregierte Zahlen. Die Quizdatenbank ist für anonyme Nutzer nicht lesbar. Ohne Supabase-Konfiguration werden Ergebnisse **nicht** zentral gespeichert; die Quizze bleiben spielbar. Bei öffentlich zugänglicher Einreichung ist Spam/Manipulation möglich; Ergebnisse sind daher keine wissenschaftliche Messung.
