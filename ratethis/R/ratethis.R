# Module UI function
#' @param id
#' @param label
#' @import shiny
#' @export
ratethisInput <- function(id, label = "Thing to Rate") {

  # Create a namespace function using the provided id
  ns <- shiny::NS(id)
  shiny::fluidRow(
    shiny::column(
      width = 3,
      shiny::radioButtons(
        inputId = ns("rating"),
        label = "Rating",
        choices = c(
          "☆",
          "☆☆",
          "☆☆☆",
          "☆☆☆☆",
          "☆☆☆☆☆"
        )
      ),
      shiny::actionButton(ns("submit"), label = "Submit")
    )
  )
}

#' @param input
#' @param output
#' @param session
#' @export
#' @import shiny
ratethis <- function(input, output, session) {

  returnValues = shiny::reactiveValues()
  returnValues$rating = "Not rated."

  result <- eventReactive(input$submit, {
    input$rating
  })

  return(result)

}
