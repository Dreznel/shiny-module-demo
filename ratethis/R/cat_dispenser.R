

#' @param id module id
#' @export
catDispenserUi <- function(id, label = "New Kitty!") {

    ns <- shiny::NS(id)
    return({
      shiny::actionButton(ns("catButton"), label = label)
    })

}

#' @param id module id
#' @param label
#' @importFrom glue glue
#' @importFrom shiny bootstrapPage wellPanel tags imageOutput
#' @export
catDispenserOutput <- function(id, label) {
  ns <- shiny::NS(id)
  return({
    shiny::bootstrapPage(
      shiny::wellPanel(
        shiny::tags$head(shiny::tags$style(
          type="text/css",
          "img {max-width: 600; width: 100%; height: auto}"
        )),

        shiny::imageOutput(
          ns("catPic")
        )
      )
    )
  })
}

#' @param import
#' @param export
#' @param session
#' @importFrom httr GET content
#' @export
catDispenser <- function(input, output, session) {

  # returnValues <- shiny::reactiveValues()
  # returnValues$ratingSubmitted <- -1

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
