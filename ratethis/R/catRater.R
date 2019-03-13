
#' @param id
#' @export
#' @importFrom shiny fluidPage fluidRow actionButton
catRaterUi <- function(id) {
  ns <- shiny::NS(id)
  return(
    shiny::bootstrapPage(
      shiny::titlePanel("Cat Rater Demo"),

      shiny::fluidRow(
        ratethis::catDispenserUi(id = ns("catDispenserImage"), label = "New Cat"),
        ratethis::catDispenserOutput(ns("catDispenserImage"), label = "Cat Picture"),
        ratethis::ratethisInput(ns("catRating"), label = "Rate this Cat!")
        # shiny::actionButton(ns("submitRating"), "Submit")
      )
    )
  )
}

#' @param input
#' @param output
#' @param session
#' @export
#' @importFrom shiny showNotification
catRater <- function(input, output, session) {

  shiny::callModule(
    module = ratethis::catDispenser,
    id = "catDispenserImage"
  )

  reactiveRating <- shiny::callModule(
    ratethis::ratethis,
    id = "catRating"
  )

  observeEvent(reactiveRating, {
    shiny::showNotification("Rating submitted.")
  })
}
