#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
##
##library(shiny)
##library(httr)
##library(imager)

#' @param id
#' @export
catDispenserUi <- function(id, label = "New Kitty!") {

    ns <- shiny::NS(id)
    return({
      shiny::actionButton(ns("catButton"), label = label)
    })

}

#' @param id
#' @param label
#' @export
catDispenserOutput <- function(id, label) {
  ns <- shiny::NS(id)
  return({
    shiny::imageOutput(ns("catPic"))
  })
}

#' @param import
#' @param export
#' @param session
#' @importFrom httr GET content
#' @export
catDispenser <- function(input, output, session) {

  observeEvent(input$catButton, {
    cat("New Kitty button pressed.")

    response1 <- httr::GET("https://api.thecatapi.com/v1/images/search?mime_types=png")
    catUrl <- httr::content(response1)[[1]]$url
    cat(paste0("Downloading file to ", getwd()))
    download.file(
      catUrl,
      file.path(getwd(), 'currentPicture.PNG'),
      mode = 'wb'
    )

    output$catPic <- shiny::renderImage({
      list(
        src = file.path(getwd(), 'currentPicture.PNG'),
        contentType = 'image/png',
        alt = 'This is alternate text.'
      )
    }, deleteFile = TRUE)
  })
}

# Run the application
#shinyApp(ui = ui, server = server)
