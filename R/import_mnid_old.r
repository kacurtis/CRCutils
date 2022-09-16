#' @title Import MN ID data using old table names (before September 2022)
#' 
#' @description 
#' Import data from MN ID database, including humpback sightings, location code 
#' reference table, and biopsy sample table. Uses table names from before 
#' September 2022. 
#' 
#' @param datdir Directory path for MN ID database file
#' @param mnidfile File path for MN ID database file
#' 
#' @return list with sightings, loccode, and biopsy sample tables
#' 
#' @export
import_mnid_old <- function(datdir, mnidfile) {

  # get connection to MN ID db
  driver_string <- "Driver={Microsoft Access Driver (*.mdb, *.accdb)};"
  dbq_string <- paste0("DBQ=",datdir,mnidfile)
  db_connect_string <- paste0(driver_string, dbq_string)
  myconn <- DBI::dbConnect(odbc::odbc(), .connection_string = db_connect_string)
  # fetch data
  sight <- DBI::dbReadTable(myconn, "MN ID Sightings")
  loccode <- DBI::dbReadTable(myconn, "Loc Code")
  biop <- DBI::dbReadTable(myconn, "Mn ID Samples")
  # disconnect
  DBI::dbDisconnect(myconn)
  rm(driver_string, dbq_string, db_connect_string, myconn)

  return(list(sight=sight, loccode=loccode, biop=biop))
}
