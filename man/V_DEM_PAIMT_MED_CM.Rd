% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-datas.R
\docType{data}
\encoding{UTF-8}
\name{V_DEM_PAIMT_MED_CM}
\alias{V_DEM_PAIMT_MED_CM}
\title{Data}
\format{
\code{list} de trois (3) éléments :
\describe{
\item{\href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30939&TypOrigElmVue=T&NoSeqElmOrig=1265}{\code{COD_DIN}}}{Description des codes d'identification du médicament :\cr - \code{DIN} : Code d'identification du médicament. \code{integer}.\cr - \code{DEBUT} : Première année où le code a été inscrit dans la base de données. \code{integer}.\cr - \code{FIN} : Dernière année où le code a été inscrit dans la base de données. \code{integer}.}
\item{COD_SERV}{Description et années d'utilisation des codes de service. \code{NA} indique que le code n'a pas été utilisé.\cr - \code{COD_SERV} : Code de service. \code{character}.\cr - \code{SERV_1} : Première et dernière année que le code de service a été inscrit dans la colonne \href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30954&TypOrigElmVue=T&NoSeqElmOrig=6295}{SMED_COD_SERV_1}. \code{character}.\cr - \code{SERV_2} : Première et dernière année que le code de service a été inscrit dans la colonne \href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30955&TypOrigElmVue=T&NoSeqElmOrig=6397}{SMED_COD_SERV_2}. \code{character}.\cr - \code{SERV_3} : Première et dernière année que le code de service a été inscrit dans la colonne \href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30956&TypOrigElmVue=T&NoSeqElmOrig=6398}{SMED_COD_SERV_3}. \code{character}.\cr - \code{COD_SERV_DESC} : Description du code de service. \code{character}.}
\item{\href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30958&TypOrigElmVue=T&NoSeqElmOrig=6162}{COD_STA_DECIS}}{Codes de statut de décision qui existent dans la base de données \href{http://intranet/eci/ECI2/ASP/ECI2P04_DescVue.asp?Envir=PROD&NoVue=1823&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29}{V_DEM_PAIMT_MED_CM}.\cr - \code{COD_STA_DECIS}: Code de statut de décision. \code{character}.\cr - \code{DEBUT} : Première année où le code a été inscrit dans la base de données. \code{integer}.\cr - \code{FIN} : Dernière année où le code a été inscrit dans la base de données. \code{integer}.}
\item{\href{http://intranet/eci/eci2/asp/ECI2P06_ElmSpec.asp?Envir=PROD&min=1&max=10&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29&NoSeqElmVue=30994&TypOrigElmVue=T&NoSeqElmOrig=1233}{COD_DENOM_COMNE}}{Codes de dénominations communes qui existent dans la base de données \href{http://intranet/eci/ECI2/ASP/ECI2P04_DescVue.asp?Envir=PROD&NoVue=1823&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29}{V_DEM_PAIMT_MED_CM}.\cr - \code{DENOM} : Code de dénomination commune. \code{character}.\cr - \code{DEBUT} : Première année où le code a été inscrit dans la base de données. \code{integer}.\cr - \code{FIN} : Dernière année où le code a été inscrit dans la base de données. \code{integer}.}
}
}
\source{
\href{http://intranet/eci/ECI2/ASP/ECI2P04_DescVue.asp?Envir=PROD&NoVue=1823&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29}{Dictionnaire EI}
}
\usage{
data('V_DEM_PAIMT_MED_CM')
}
\description{
Base de données sur les demandes de paiement de médicaments.
}
\details{
L'attribut \code{MaJ} indique la dernière mise à jour ou la date de création
}
\keyword{datasets}
