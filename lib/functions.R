
#' @param query (string) SQL
#'
#' @return result from database
dbQuery <- function (query) {
  # connect to database
  con <- dbConnect(RMariaDB::MariaDB(), 
                   host = "192.168.0.69", 
                   user = "Reiner", 
                   password = "91448", 
                   dbname = "network")
  
  # send query
  result <- dbGetQuery(con, paste(query))
  
  # close connection
  dbDisconnect(con)
  
  return(result)
}
