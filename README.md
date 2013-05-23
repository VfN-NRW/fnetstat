fnetstat ist ein Diagnose-Werkzeug, und ein Statistik-Tool mit dem Freifunk-Router überwacht werden
und eine Statistik komprimiert und verschlüsselt an definierte Server übertragen kann. Es ist in
Shell-Script geschrieben.

In der Standardkonfiguration wird das Script menütlich mit dem Parameter cronjob gestartet. Dieses
sammelt die statistischen Daten im /tmp-Verzeichnis. In per Konfiguration definerten Intervallen
werden diese Informationen bzip2-Komprimiert und auf den Server per SCP übertragen.

Einmal täglich werden statische Daten wie die Position, eine Kontaktadresse und diverse Hard- und
Softwareparameterzusätzlich erfasst und an den Server übertragen.

Das Script lässt sich ebenfalls ohne den Parameter aufrufen um einen Status des Systems zu erhalten.

Es wird von RubenKelevra entwickelt.