### Datenvisualisierung mit ggplot2 - Teil 3: Unser Scatterplot erweitern und anpassen {#scatter}
### -------------------------------------------------------------------------------------------------------

## Wichtige Pakete laden und Datensatz importieren
library(tidyverse) # lädt alle Pakete des "tidyverse" - unter anderem ggplot2 und readr

# Verwenden Sie bitte den Auszug aus dem QOG-Datensatz - beispielsweise mit
# qog <- read.csv("./Data/qog_sample.csv") # Laufwerk und Verzeichnis anpassen
# oder
# qog <- load("./Data/qog_sample.rdata") # Laufwerk und Verzeichnis anpassen

# Streudiagramm aus dem letzten Tutorial nochmal erstellen
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp))
p + geom_point()

# Schätzlinie darstellen
p + geom_smooth()

# Regressionsgerade aus einem linearen Modell - ohne Vertrauensbereich
p + geom_smooth(method = "lm", se = FALSE)

# Punkte und Regressionsgerade darstellen
p + geom_smooth(method = "lm", se = FALSE) +
  geom_point()

# Regressionsgerade ÜBER die Punkten legen
p + geom_point() +
  geom_smooth(method = "lm", se = FALSE)

## Zwei Diagramme nebeinenader darstellen
# patchwork laden
library(patchwork)

# Zwei Diagramme nebeneinander darstellen
p1 <- p + geom_point() +
  geom_smooth(method = "lm", se = FALSE)
p2 <- p + geom_smooth(method = "lm", se = FALSE)

p1 | p2

### -------------------------------------------------------------------------------------------------------

### Die scale()-Funktion

# help.search()-Funktion von R verwenden (?? ist gleichbedeutend mit help.search())
??scale_

# Koordinatensystem mit einer Skalierung von 0 bis 100 auf beiden Achsen
p + scale_x_continuous(limits = c(0, 100)) +
  scale_y_continuous(limits = c(0, 100))

# Streudiagramm mit manuell festgelegter Skalierung der beiden Achsen
p + geom_point() +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90))

# Regressionslinie mit manuell festgelegter Skalierung der beiden Achsen
p + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90))

# Beide Diagramme nebeneinander darstellen
p1 <- p + geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90))

p2 <- p + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90))

p1 | p2

# 10er-Intervall auf der y-Achse (in diesem Fall per default festgelegt)
p + geom_point() +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90))

# Manuell festgelegtes 5er-Intervall auf der y-Achse
p + geom_point() +
  scale_x_continuous(limits = c(0, 13)) +
  scale_y_continuous(limits = c(50, 90), breaks = c(50, 55, 60, 65, 70, 75, 80, 85, 90))

# Sequenz-Funktion verwenden:
seq(from = 50, to = 90, by = 5)

# Sequenz-Funktion in kürzerer Schreibweise (from, to, by)
seq(50,90,5)

# Streudiagramm mit manuell festgelegten Skalengrenzen und -intervallen
p + geom_point() +
  scale_x_continuous(limits = c(0, 13),
                     breaks = seq(0, 13, 2)) +
  scale_y_continuous(limits = c(50, 90),
                     breaks = seq(50, 90, 5))

# Achsen neu bennenen
p + geom_point() +
  scale_x_continuous(limits = c(0, 13),
                     breaks = seq(0, 13, 2),
                     name = "Gesundheitsausgaben") +
  scale_y_continuous(limits = c(50, 90),
                     breaks = seq(50, 90, 5),
                     name = "Lebenserwartung")

# Weitere Beschriftungen hinzufügen
p + geom_point() +
  scale_x_continuous(limits = c(0, 13),
                     breaks = seq(0, 13, 2)) +
  scale_y_continuous(limits = c(50, 90),
                     breaks = seq(50, 90, 5)) +
  labs(x = "Gesundheitsausgaben",
       y = "Lebenserwartung",
       title = "Überschrift",
       subtitle = "Unterüberschrift",
       caption = "Quelle: QOG")
### -------------------------------------------------------------------------------------------------------

### Drei und mehr Variablen verwenden {#drei}

# Variablen zur Identifikation einzelner Länder
qog %>%
  select(ccodealp, ccode, cname) %>%
  head()

# Länder einfärben
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, colour = ccodealp))
p + geom_point()

# Länderkürzel darstellen
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, label = ccodealp))
p + geom_point()

# geom_label() hinzufügen
p + geom_point() +
  geom_label()

# Text statt "labels" verwenden
p + geom_text()

# Verwendung des Pakets "ggrepel"
library(ggrepel)

p +
  geom_point() +
#  geom_text_repel(max.overlaps = Inf) # max.overlapps = Inf - ohne dieses Argument würden überlappende
 #labels ggf. nicht angezeigt werden
geom_label_repel(max.overlaps = Inf)

# Einfärbung der Punkte nach Kontinenten
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, colour = continent))
p + geom_point()

# Punktgröße in Abhängigkeit der Einwohnerzahlen der jeweiligen Länder variieren
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, size = wdi_pop, color = continent))
p + geom_point()

# Skalierung der Punktgröße anpassen
p + geom_point() +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio."))

### -------------------------------------------------------------------------------------------------------

### Darstellung verbessern {#verbessern}

# Umrandete Punkte verwenden
p + geom_point(shape = 21) +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio."))

# Unterschiedliche Formen ("shapes") ausprobieren
p +
  # geom_point(shape = 3) +
  # geom_point(shape = 7) +
  # geom_point(shape = 10) +
  geom_point(shape = 21) +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio."))

# Punkte mit "fill=" einfärben
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, size = wdi_pop,
                     #color = continent,
                     fill = continent
))

p + geom_point(shape = 21) +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio."))

# Transparenz der Füllung festlegen
p + geom_point(shape = 21,
               alpha = 0.75
               # alpha = 0.50
               # alpha = 0.25
               # alpha = 0.05
) +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio."))

# All in One
p <- ggplot(qog, aes(x = wdi_dgovhexp, y = wdi_lifexp, size = wdi_pop, fill = continent))
p + geom_point(shape = 21, alpha = 0.7) +
  scale_x_continuous(limits = c(0, 12),
                     breaks = seq(0, 13, 2)) +
  scale_y_continuous(limits = c(50, 85),
                     breaks = seq(50, 90, 5)) +
  scale_size(breaks = c(1000000, 10000000, 100000000, 1000000000),
             labels = expression("< 1 Mio.", "1-10 Mio.", "10-100 Mio.", "> 100000 Mio.")) +
  labs(x = "Gesundheitsausgaben in Prozent am BIP",
       y = "Lebenserwartung",
       size = "Einwohnerzahl",
       fill = "Kontinent",
       title = "Öffentliche Gesundheitsausgaben und Lebenswerwartung",
       subtitle = "Daten aus dem Jahr 2019",
       caption = "Quelle: QOG (Standard)") +
  theme_minimal()
