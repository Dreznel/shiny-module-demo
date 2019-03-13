ui <- shiny::fluidPage(
  shiny::mainPanel(
    # ratethis::ratethisInput("catRating", label = "This cat"),
    # ratethis::catDispenserUi("catDispenser1", label = "GIMME DAT KITTEH"),
    # ratethis::catDispenserOutput("catDispenser1", label = "Label?"),
    ratethis::catRaterUi(id = "catRater"),
    shiny::textOutput("ratingForCurrentCat")
  )
)

server <- function(input, output, session) {

  # shiny::callModule(ratethis::catDispenser, "catDispenser1")

  # output$ratingForCurrentCat <- renderText({
  #   result <- shiny::callModule(ratethis::ratethis, "catRating")
  #   glue::glue("This cat gets a {as.character(result())} rating.")
  # })

  shiny::callModule(module = ratethis::catRater, id = "catRater")

}

shiny::shinyApp(ui = ui, server = server)
