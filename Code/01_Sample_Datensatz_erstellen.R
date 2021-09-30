### Auszug aus dem QOG-Datensatz erstellen und zusätzliche Variablen hinzufügen ###
## Sebastian Kuhn. 29.09.2021

## countrycode-Paket laden
# Im QOG-Datensatz ist sine keine Informationen zur kontinentalen Zugehörigkeit der Länder enthalten.
# Das countrycode-Paket umfasst neben dieser Variable auch zahlreiche weitere länderspezifischen ID-Variablen

# install.packages("countrycode")
library(countrycode)
library(readr)

## QOG-Daten importieren
qog <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_cs_jan21.csv") #Standard-Datensatz
qog_ts <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_ts_jan21.csv") #Zeitreihen-Datensatz

## Informationen zu den Kontinenten zum Datensatz hinzufügen
# Standard-Datensatz
df <- as.data.frame(qog[, "ccodealp"])
df$continent <- countrycode(sourcevar = df[, "ccodealp"],
                            origin = "iso3c",
                            destination = "continent")
qog <- merge(qog, df)
rm(df)

# Zeitreihen-Datensatz
df <- as.data.frame(qog_ts[, "ccodealp"])
df$continent <- countrycode(sourcevar = df[, "ccodealp"],
                            origin = "iso3c",
                            destination = "continent")
qog_ts <- cbind(qog_ts, df)
rm(df)

## Bearbeiteten Datensatz speichern
readr::write_csv(qog, "Data/qog_sample.csv")
rm(qog)

readr::write_csv(qog_ts, "Data/qog_ts_sample.csv")
rm(qog_ts)

