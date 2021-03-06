library(usethis)
library(data.table)
library(odbc)
library(inesss)
library(askpass)
library(stringr)
library(lubridate)
# conn <- SQL_connexion(askpass("User"))

cod_din <- function() {

  ### Trouver la liste des codes pour chaque année
  to_year <- 1996:year(Sys.Date())  # année à analyser
  DT <- vector("list", length(to_year) * 12)  # contiendra les tableaux des requêtes
  i <- 1L
  for (yr in to_year) {  # pour chaque année
    for (mth in 1:12) {  # pour chaque mois
      dt <- as.data.table(dbGetQuery(  # liste unique des codes de service pour le mois
        conn, paste0(
          "select distinct SMED_COD_DIN as DIN\n",
          "from V_DEM_PAIMT_MED_CM\n",
          "where SMED_DAT_SERV between '",date_ymd(yr, mth, 1),"' and '",date_ymd(yr, mth, "last"),"';"
        )
      ))
      if (nrow(dt)) {
        dt[, ANNEE := yr]  # indiquer l'année
        DT[[i]] <- dt
      } else {
        DT[[i]] <- NULL
      }
      i <- i + 1L
    }
  }
  DT <- rbindlist(DT)  # un seul tableau
  setkey(DT, DIN, ANNEE)  # trier par DIN + ANNEE

  ### Indiquer les années où le code est présent
  DT <- DT[
    ,.(DEBUT = min(ANNEE), FIN = max(ANNEE)),
    .(DIN)
  ]

  return(DT)

}
cod_serv <- function() {

  ### Liste des codes de service dans chaque colonne (1 à 3) de SMED_COD_SERV_
  to_year <- 1996:year(Sys.Date())  # années à analyser
  DT <- vector("list", length(to_year) * 3)  # contiendra les tableaux des requêtes
  i <- 1L
  for (c_serv in 1:3) {  # codes de service 1 à 3
    for (yr in 1996:year(Sys.Date())) {  # mininum DAT_SERV de V_DEM_PAIMT_MED_CM = 1996-01-01
      dt <- as.data.table(dbGetQuery(  # liste unique des codes de service
        conn, paste0(
          "select distinct SMED_COD_SERV_",c_serv," as COD_SERV\n",
          "from V_DEM_PAIMT_MED_CM\n",
          "where SMED_DAT_SERV between '",paste0(yr,"-01-01"),"' and '",paste0(yr,"-12-31"),"';"
        )
      ))
      dt <- dt[!is.na(COD_SERV)]
      if (nrow(dt)) {
        dt[, `:=` (SERV = c_serv, ANNEE = yr)]  # indiquer numéro de service et année
        DT[[i]] <- dt
      } else {
        DT[[i]] <- NULL
      }
      i <- i + 1L
    }
  }
  DT <- rbindlist(DT)
  setkey(DT)

  ### Indiquer la période que le code a été utilisé : min(ANNEE)-max(ANNEE)
  DT <- DT[
    , .(PERIODE = paste0(min(ANNEE),"-",max(ANNEE))),
    by = .(COD_SERV, SERV)
  ]
  DT <- dcast(DT, COD_SERV ~ SERV, value.var = "PERIODE")  # lignes en colonnes
  for (col in 2:3) {  # Créer la colonne du code de service si absente
    if (!paste(col) %in% names(DT)) {
      DT[, paste(col) := NA]
    }
  }

  ### Dataset avec la description de chaque Code de service et ajouter à DT
  COD_SERV_DESC <- as.data.table(dbGetQuery(
    conn,
    "select distinct NMED_COD_SERV_MED as COD_SERV, NMED_DES_SERV_MED as COD_SERV_DESC
   from PROD.V_PARAM_SERV_MED;"
  ))
  setkey(COD_SERV_DESC, COD_SERV)
  DT <- merge(DT, COD_SERV_DESC,  # ajouter les descriptif
              by = "COD_SERV", all = TRUE)

  ### Arrangements finaux
  setnames(DT, paste(1:3), paste0("SERV_",1:3))  # nom des colonnes
  DT[, COD_SERV := str_remove_all(COD_SERV, " ")]  # supprimer espaces

  return(DT)

}
cod_sta_decis <- function() {
  ### Valeurs uniques

  years <- 1996:year(Sys.Date())
  DT <- vector("list", length(years) * 12)
  i <- 1L
  for (yr in years) {
    for (mth in 1:12) {
      DT[[i]] <- as.data.table(dbGetQuery(
        conn, statement = paste0(
          "select distinct(SMED_COD_STA_DECIS) as COD_STA_DECIS\n",
          "from V_DEM_PAIMT_MED_CM\n",
          "where SMED_DAT_SERV between '",date_ymd(yr, mth, 1),"' and '",date_ymd(yr, mth, "last"),"';"
        )
      ))
      DT[[i]][, ANNEE := yr]
      i <- i + 1L
    }
  }
  DT <- rbindlist(DT)
  setkey(DT, COD_STA_DECIS, ANNEE)

  DT <- DT[
    , .(DEBUT = min(ANNEE),
        FIN = max(ANNEE)),
    .(COD_STA_DECIS)
  ]

  return(DT)

}
cod_denom <- function() {

  to_year <- 1996:year(Sys.Date())
  DT <- vector("list", length(to_year) * 12)
  i <- 1L
  for (yr in to_year) {
    for (mth in 1:12) {
      dt <- as.data.table(dbGetQuery(conn, statement = paste0(
        "select distinct(SMED_COD_DENOM_COMNE) as DENOM\n",
        "from V_DEM_PAIMT_MED_CM\n",
        "where SMED_DAT_SERV between '",date_ymd(yr, mth, 1),"' and '",date_ymd(yr, mth, "last"),"';"
      )))
      dt[, ANNEE := yr]
      DT[[i]] <- dt
      i <- i + 1L
    }
  }
  DT <- rbindlist(DT)
  setkey(DT, DENOM, ANNEE)
  DT <- DT[
    , .(DEBUT = min(ANNEE),
        FIN = max(ANNEE)),
    .(DENOM)
  ]
  return(DT)

}


# SAVE --------------------------------------------------------------------

# V_DEM_PAIMT_MED_CM <- list()
V_DEM_PAIMT_MED_CM <- inesss::V_DEM_PAIMT_MED_CM

V_DEM_PAIMT_MED_CM$COD_DIN <- cod_din()
V_DEM_PAIMT_MED_CM$COD_SERV <- cod_serv()
V_DEM_PAIMT_MED_CM$COD_STA_DECIS <- cod_sta_decis()
V_DEM_PAIMT_MED_CM$COD_DENOM_COMNE <- cod_denom()

attr(V_DEM_PAIMT_MED_CM, "MaJ") <- Sys.Date()  # date de création

use_data(V_DEM_PAIMT_MED_CM, overwrite = TRUE)
