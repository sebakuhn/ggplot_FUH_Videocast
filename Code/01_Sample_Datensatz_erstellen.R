### Auszug aus dem QOG-Datensatz erstellen und zusätzliche Variablen hinzufügen ###
## Sebastian Kuhn. 29.09.2021

## countrycode-Paket laden
# Im QOG-Datensatz ist sine keine Informationen zur kontinentalen Zugehörigkeit der Länder enthalten.
# Das countrycode-Paket umfasst neben dieser Variable auch zahlreiche weitere länderspezifischen ID-Variablen

# install.packages("countrycode")
library(countrycode)
library(tidyverse)

## QOG-Daten importieren
qogx <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_cs_jan21.csv") #Standard-Datensatz
qog_ts <- readr::read_csv("https://www.qogdata.pol.gu.se/data/qog_std_ts_jan21.csv") #Zeitreihen-Datensatz

## Informationen zu den Kontinenten zum Datensatz hinzufügen
# Standard-Datensatz
df <- as.data.frame(qog[, "ccodealp"])
df$continent <- countrycode(sourcevar = df[, "ccodealp"],
                            origin = "iso3c",
                            destination = "continent")
qog <- merge(qog, df)
rm(df)

qog <-
  qog %>%
  select(
    ccodealp,
    ccode,
    cname,
    ccodecow,
    ccodewb,
    wdi_dgovhexp,
    wdi_gdppppcon2017,
    wdi_lifexp,
    wdi_pop,
    continent,
    wdi_gdpcapcon2010,
    vdem_corr,
    wdi_popurb,
    wdi_poprul,
    wvs_pmi12,
    wvs_pmi4,
    wvs_auton,
    wdi_litrad,
    wdi_chexppgdp,
    undp_hdi,
    wdi_hwf,
    wdi_hwfr,
    wdi_hwfu,
    who_let,
    ht_colonial,
    mad_gdppc1600,
    mad_gdppc1700,
    mad_gdppc1900,
    van_index,
    bti_ds,
    sgi_qd,
    van_index,
    vdem_libdem,
    wdi_gdpcapcon2010,
    wdi_gdpcappppcon2017,
    wdi_gdppppcon2017,
    wdi_incsh10h,
    gd_ptsh,
    gd_ptsa,
    wbgi_pve)


# Zeitreihen-Datensatz
df <- as.data.frame(qog_ts[, "ccodealp"])
df$continent <- countrycode(sourcevar = df[, "ccodealp"],
                            origin = "iso3c",
                            destination = "continent")
qog_ts <- cbind(qog_ts, df)
rm(df)

qog_ts$ccodealpx <- qog_ts$ccodealp

qog_ts <-
  qog_ts %>%
  select(
    ccodealpx,
    ccode,
    cname,
    cname_year,
    year,
    ccodecow,
    ccodewb,
    wdi_dgovhexp,
    wdi_gdppppcon2017,
    wdi_lifexp,
    wdi_pop,
    continent,
    wdi_gdpcapcon2010,
    vdem_corr,
    wdi_popurb,
    wdi_poprul,
    wvs_pmi12,
    wvs_pmi4,
    wvs_auton,
    wdi_litrad,
    wdi_chexppgdp,
    undp_hdi,
    wdi_hwf,
    wdi_hwfr,
    wdi_hwfu,
    who_let,
    ht_colonial,
    mad_gdppc1600,
    mad_gdppc1700,
    mad_gdppc1900,
    van_index,
    bti_ds,
    sgi_qd,
    van_index,
    vdem_libdem,
    wdi_gdpcapcon2010,
    wdi_gdpcappppcon2017,
    wdi_gdppppcon2017,
    wdi_incsh10h)

qog_ts <-
qog_ts %>%
  rename(
    ccodealp = ccodealpx,
    )

## Bearbeiteten Datensatz speichern
readr::write_csv(qog, "Data/qog_sample.csv")
save(qog, file = "Data/qog_sample.rdata")
rm(qog)

readr::write_csv(qog_ts, "Data/qog_ts_sample.csv")
save(qog, file = "Data/qog_ts_sample.rdata")
rm(qog_ts)


