ui <- shiny::fluidPage(
  shiny::sidebarPanel(
    shiny::actionButton("fetchButton", label = "Button, Sir")

  ),
  shiny::mainPanel(
    shiny::textOutput("textId"),
    ratethis::catDispenserUi("catDispenser1", label = "GIMME DAT KITTEH"),
    ratethis::catDispenserOutput("catDispenser1", label = "Label?")
  )
)

server <- function(input, output, session) {
  shiny::observeEvent(input$fetchButton, {
    output$textId = shiny::renderText(
      paste0("Button pressed ", as.character(input$fetchButton), " times.")
    )
  })
  shiny::callModule(ratethis::catDispenser, "catDispenser1")
}

shiny::shinyApp(ui = ui, server = server)
