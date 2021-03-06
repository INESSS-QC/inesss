% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SQL_naif_switch1.R
\encoding{UTF-8}
\name{SQL_naif_switch1}
\alias{SQL_naif_switch1}
\title{Naïfs et Switchs}
\usage{
SQL_naif_switch1(
  conn,
  debut,
  fin,
  type_rx = "DENOM",
  codes,
  grouper_par = NULL,
  rx_retrospect_a_exclure = NULL,
  njours_sans_conso = 365,
  code_serv = c("1", "AD"),
  code_serv_filtre = "Exclusion",
  code_list = NULL,
  code_list_filtre = "Inclusion",
  ...
)
}
\arguments{
\item{conn}{Variable contenant la connexion entre R et Teradata. Voir \code{\link{SQL_connexion}}.}

\item{debut}{Date de début de la période d'étude au format \code{AAAA-MM-JJ} (une seule valeur).}

\item{fin}{Date de fin de la période d'étude au format \code{AAAA-MM-JJ} (une seule valeur).}

\item{codes}{Traitement(s) d'intérêt(s). Vecteur comprenant le ou les codes d'analyse au format numérique, sans zéros.}

\item{grouper_par}{Regrouper (aggréger) les résultats par :
\itemize{
\item \code{'Codes'} : Résultats par code analysé.
}}

\item{rx_retrospect_a_exclure}{Traitement(s) à inclure dans la période rétrospective. Voir \emph{Details}. Un individu qui a au moins un traitement durant la période rétrospective ne sera pas considéré comme \emph{naïf} ou \emph{switch}.}

\item{njours_sans_conso}{Nombre de jours qu'un individu ne doit pas avoir reçu de traitements avant sa date de référence (index) pour être considéré \emph{naïf} ou \emph{switch}.}

\item{code_serv}{Vecteur de type \code{character} comprenant le ou les codes de service (\code{SMED_COD_SERV_1}) à exclure ou à inclure, sinon inscrire \code{NULL}.}

\item{code_serv_filtre}{\code{'Inclusion'} ou \code{'Exclusion'} des codes de service \code{code_serv}. Inscrire \code{code_serv = NULL} s'il n'y a pas de filtre à appliquer.}

\item{code_list}{Vecteur de type \code{character} comprenant le ou les codes de catégories de liste de médicaments (\code{SMED_COD_CATG_LISTE_MED}) à exclure ou à inclure, sinon inscrire \code{NULL}.}

\item{code_list_filtre}{\code{'Inclusion'} ou \code{'Exclusion'} des codes de catégories de liste de médicaments \code{code_list}. Inscrire \code{code_list = NULL} s'il n'y a pas de filtre à appliquer.}
}
\value{
\code{data.table} contenant certaines de ces colonnes selon les cas :
\itemize{
\item \code{DATE_DEBUT} : Date(s) de début de la période d'étude.
\item \code{DATE_FIN} : Date(s) de fin de la période d'étude.
\item \code{MNT_MED} : Montant autorisé par la RAMQ pour le médicament ou le produit. Il comprend la part du grossiste (s’il y a lieu) et la part du manufacturier.
\item \code{MNT_SERV} : Montant de frais de service autorisé par la RAMQ à la date du service.
\item \code{MNT_TOT} : Somme des variables \code{MNT_MED} et \code{MNT_SERV}.
\item \code{COHORTE} : Nombre d'individus unique.
\item \code{NBRE_RX} : Nombre de prescriptions/paiements.
\item \code{QTE_MED} : Quantité totale des médicaments ou des fournitures dispensés.
\item \code{DUREE_TX} : Durée de traitement totale des prescriptions en jours.
\item \code{DENOM} ou \code{DIN} : Code(s) analysé(s) à l’intérieur de la période d’étude.
\item \code{RX_RETROSPECT_A_EXCLURE} : Code(s) de médicament(s) qui n'ont \emph{jamais} été consommé(s) durant la période rétrospective.
\item \code{NJOURS_SANS_CONSO} : Nombre de jours qu'un individu ne doit pas avoir reçu de traitements avant sa date de référence (index) pour être considéré comme \emph{naïf} ou \emph{switch}.
}
}
\description{
Statistiques générales pour un ou des médicaments à partir d'une cohorte consommant ce(s) médicament(s) pour la première fois.\cr
Un individu est considéré \emph{naïf} lorsqu'il a un traitement pour la première fois et qu'il n'a jamais eu d'autres traitements \emph{de la même famille}.\cr
Un individu est considéré \emph{switch} lorsqu'il a un traitement pour la première fois, mais qu'il a eu un autre traitement dans le passé appartenant \emph{à la même famille}.\cr
Vue utilisée : \code{\href{http://intranet/eci/ECI2/ASP/ECI2P04_DescVue.asp?Envir=PROD&NoVue=1823&NomVue=V\%5FDEM\%5FPAIMT\%5FMED\%5FCM+\%28DEMANDES+DE+PAIEMENT+\%2D+PROGRAMME+\%ABMEDICAMENT\%BB\%29}{V_DEM_PAIMT_MED_CM}}.
}
\details{
\strong{\code{rx_retrospect_a_exclure} :}\cr
La période rétrospective est construite à partir des dates de références (index) et de l'argument \code{njours_sans_conso} : \code{[INDEX - njours_sans_conso; INDEX - 1]}.\cr\cr
\strong{\code{code_serv_filtre}, \code{code_list_filtre} :}\cr
\code{'Exclusion'} inclus les \code{NULL}\cr
\code{'Inclusion'} exclus les \code{NULL}.
}
\examples{
\dontrun{
### DENOM
dt1 <- SQL_naif_switch1(
  conn, debut = c('2018-01-01', '2019-01-01'), fin = c('2018-12-31', '2019-12-31'),
  type_rx = 'DENOM', codes = c(47873, 47958, 48213), grouper_par = 'Codes',
  rx_retrospect_a_exclure = NULL, njours_sans_conso = 365,
  code_serv = '1', code_serv_filtre = 'Exclusion',
  code_list = NULL, code_list_filtre = 'Inclusion'
)
### GROUPER_PAR = NULL - Plusieurs codes pour un meme type de traitement
dt2 <- SQL_naif_switch1(
  conn, debut = c('2018-01-01', '2019-01-01'), fin = c('2018-12-31', '2019-12-31'),
  type_rx = 'DENOM', codes = c(47873, 47958, 48213), grouper_par = NULL,
  rx_retrospect_a_exclure = NULL, njours_sans_conso = 365,
  code_serv = '1', code_serv_filtre = 'Exclusion',
  code_list = NULL, code_list_filtre = 'Inclusion'
)
### DIN
dt3 <- SQL_naif_switch1(
  conn, debut = c('2018-01-01', '2019-01-01'), fin = c('2018-12-31', '2019-12-31'),
  type_rx = 'DIN', codes = 2241927, grouper_par = NULL,
  rx_retrospect_a_exclure = NULL, njours_sans_conso = 365,
  code_serv = '1', code_serv_filtre = 'Exclusion',
  code_list = NULL, code_list_filtre = 'Inclusion'
)
### RX_RETROSPECT_A_EXCLURE conteant plus de valeurs que CODES (avec ou sans les memes valeurs)
dt4 <- SQL_naif_switch1(
  conn, debut = c('2018-01-01', '2019-01-01'), fin = c('2018-12-31', '2019-12-31'),
  type_rx = 'DIN', codes = c(2257238, 2272903), grouper_par = NULL,
  rx_retrospect_a_exclure = c(2042479, 2042487, 2257238, 2272903, 2317192, 2317206),
  njours_sans_conso = 365,
  code_serv = '1', code_serv_filtre = 'Exclusion',
  code_list = NULL, code_list_filtre = 'Inclusion'
)
}
}
