ui <- shiny::fluidPage(
  shiny::sidebarPanel(
    shiny::actionButton("fetchButton", label = "Button, Sir"),
    shiny::textOutput("ratingForCurrentCat")

  ),
  shiny::mainPanel(
    # shiny::textOutput("textId"),
    ratethis::ratethisInput("catRating", label = "This cat"),
    ratethis::catDispenserUi("catDispenser1", label = "GIMME DAT KITTEH"),
    ratethis::catDispenserOutput("catDispenser1", label = "Label?")
  )
)

server <- function(input, output, session) {
  # shiny::observeEvent(input$fetchButton, {
  #
  # })
  shiny::callModule(ratethis::catDispenser, "catDispenser1")
  output$ratingForCurrentCat <- renderText({
    result <- shiny::callModule(ratethis::ratethis, "catRating")
    cat(result())
    as.character(result())
    #glue::glue("This cat gets a {result} rating.")
  })

}

shiny::shinyApp(ui = ui, server = server)
