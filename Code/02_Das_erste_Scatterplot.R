### Datenvisualisierung mit ggplot2 - Teil 2: Das erste Scatterplot
### -------------------------------------------------------------------------------------------------------

## Wichtige Pakete laden und Datensatz importieren
library(tidyverse) # lädt alle Pakete des "tidyverse" - unter anderem ggplot2 und readr

# Import des QOG Standard_Datensatzes
#qog <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_cs_jan21.csv") #Standard-Datensatz

# Import des QOG Zeitreihen-Datensatz
#qog_ts <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_ts_jan21.csv") #Zeitreihen-Datensatz

### -------------------------------------------------------------------------------------------------------

### Und los geht's!: Das erste Streudiagramm

## Variablen:

# wdi_dgovhexp
#   Öffentliche Ausgaben für Gesundheit aus inländischen Quellen als Anteil der Wirtschaft,
#   gemessen am BIP.
# wdi_lifexp
#   Die Lebenserwartung bei der Geburt gibt die Anzahl der Jahre an, die ein
#   Neugeborenes leben würde, wenn die zum Zeitpunkt seiner Geburt vorherrschenden
#   Sterblichkeitsmuster zum Zeitpunkt seiner Geburt sein ganzes Leben lang gleich bleiben würden.

## Daten übergeben
ggplot(data = qog)
ggplot(qog) # Führt zum selben Ergebnis

# Das "Mapping-Argument" - die Zuordnung von Variablen zu Aesthetics
ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp))

# Das erste Streudiagramm
ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp)) + # Neue Ebenen werden mit dem "+"-Operator hinzugefügt
  geom_point()

### -------------------------------------------------------------------------------------------------------

### ggplot-Befehle sinnvoll aufbauen

# Das erste Streudiagramm - kürzere Variante
ggplot(qog, aes(wdi_dgovhexp, wdi_lifexp)) + geom_point()

# Das erste Streudiagramm - kürzere Variante mit anderer Reihenfolge
ggplot(qog, aes(wdi_lifexp, wdi_dgovhexp)) + geom_point()

# Das erste Streudiagramm - y vor x
ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp)) + geom_point()

# Das erste Streudiagramm - y vor x
ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp)) +
  geom_point() # Zur besseren Lesbarkeit und Übersicht bitte in einer neuen Zeile

# Daten und Mapping in "p" zwischenspeichern
p <- ggplot(qog, aes(y = wdi_lifexp, x = wdi_dgovhexp))
p

# Darstellung als Scatterplot
p + geom_point()

# Darstellung als Liniendiagramm
p + geom_line()

# Darstellung mit Dichte-Plot
p + geom_density_2d() +
  geom_point()

## Sinnvoller Aufbau eines ggplots
# Wir beginnen mit einem möglichst "aufgeräumten" Datensatz und gehen dann wie folgt vor:

# 1. Teilen Sie der Funktion ggplot() mit, welche Daten Sie verwenden wollen.
# 2. Sagen Sie ggplot(), welche Variablen Sie dargestellt haben wollen.
#     Der Einfachheit halber speichern Sie die Ergebnisse der ersten beiden Schritte in ein Objekt namens "p".
# 3. Teilen Sie ggplot mit, welchen Darstellungstyp Sie gerne sehen wollen.
#     Verwenden Sie dazu die vorgesehenen geom_()-Funktionen, indem Sie diese einzeln und nacheinander zum Objekt "p" hinzufügen.
# 4. Verwenden Sie Zusatzfunktionen, um Skalen, Beschriftungen, Markierungen, Titel
#     und vieles mehr hinzufügen.
