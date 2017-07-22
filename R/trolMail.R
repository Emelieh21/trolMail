#' Function that prepares & sends a friendly email for you.
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' trolMail()
#'
#' @import RCurl
#' @import jsonlite
#' @import mailR
#' @import rvest
#' @import sodium
#' 
#' @export
#'

trolMail <- function(){
  library(rvest)
  library(mailR)
  sender = readline("Please enter your gmail address (sorry - currently only works with gmail): ")
  PW=charToRaw(.rs.askForPassword("Please enter your e-mail password: "))
  
  term = readline("What is the random giph you want?: ")
  key = Sys.getenv("giphy_key")
  if (key == ""){
    stop("Please request your Giphy API key from https://developers.giphy.com/ and save it in your .Renviron file.")
  }
  search = gsub(" ","+",term)
  
  get <- getURL(paste0("http://api.giphy.com/v1/gifs/search?q=",search,"&api_key=",key,"&limit=1"))
  dat <- fromJSON(get)
  dat$data$id
  url = paste0("https://media.giphy.com/media/",dat$data$id,"/giphy.gif")
  url
  download.file(url,'giphy.gif', mode = 'wb')
  
  html <- read_html("http://toykeeper.net/programs/mad/compliments")
  text <- html %>%
    html_nodes(".blurb_title_1") %>%
    html_text(trim=TRUE)
  
  x = readline("Who do you want to send to? (seperate e-mails by ;): ")
  receivers = as.list(strsplit(x, ";")[[1]])
  receivers = trimws(receivers)
  receivers
  print("One moment while we prepare your e-mail...")
  
  send.mail(from = sender,
            to = receivers,
            replyTo = c("Reply to someone else <someone.else@gmail.com>"),
            subject = term,
            body = paste0('<div> <h1>',text,'</h1> </div> <div> <img src="/giphy.gif"> </div>'),
            html = TRUE,
            inline = TRUE,
            smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "emeliehofland@gmail.com", passwd = rawToChar(PW), ssl = TRUE),
            authenticate = TRUE,
            send = TRUE)
  print("Success!")
}


