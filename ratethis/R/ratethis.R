# Module UI function
#' @param id
#' @param label
#' @import shiny
#' @export
rtInput <- function(id, label = "Thing to Rate") {

  # Create a namespace function using the provided id
  ns <- shiny::NS(id)
  shiny::fluidRow(
    shiny::column(
      width = 3,
      shiny::radioButtons(
        inputId = ns("rating"),
        choices = c(
          "☆",
          "☆☆",
          "☆☆☆",
          "☆☆☆☆",
          "☆☆☆☆☆"
        )
      )
    ),
    shiny::column(
      width = 9,
      shiny::imageOutput("content")
    )
  )
}

#' @param input
#' @param output
#' @param session
#' @param image_to_rate
#' @export
#' @import shiny
rtOutput <- function(input, output, session, image_to_rate) {

  returnValues = shiny::reactiveValues()
  returnValues$rating = "Not rated."

  observe(
    output$content <- renderImage(image_to_rate)
  )

  observeEvent(input$rating, {
    returnValues$rating <- input$rating
  })

  return(returnValues$rating)

}
