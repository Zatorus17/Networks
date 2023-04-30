#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# ---- libraries ----
library(shiny)
library(RMariaDB)
library(DT)

# ---- source ----
source("lib/functions.R")

# ---- Testarea ----

# Funktion, die aufgerufen wird, wenn eine Zeile geklickt wird
row_dblclicked <- function(data) {
  print(data)
  # hier können Sie den Inhalt der geklickten Zeile als Eingabe für eine weitere Verarbeitung verwenden
}

# ---- -------- ----


# ---- ui ----
ui <- fluidPage(

    # Application title
    titlePanel("Gsindl Gfrast Mongo Spasst"),

    # panel with three tabs
    tabsetPanel(
      
      tabPanel("Tab 1",
               sliderInput(inputId = "bins",
                           label = "Number of bins:",
                           min = 1,
                           max = 50,
                           value = 30),
               plotOutput(outputId = "distPlot")
      ),
      
      tabPanel("Tab 2",
               checkboxInput("checkbox_input", "Klicken Sie hier, um fortzufahren"),
               
               # input field
               textInput("input_message", "write something"),
               
               # popup button
               actionButton("popup_button", "show popup")
               
      ),
      
      tabPanel("Tab 3", dataTableOutput(outputId = "peopleTable"))
    )
)


# ---- server ----
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    


      # output table for third tab
    output$peopleTable <- renderDT(
      dbQuery("SELECT * FROM People"),
      options = list(pageLength = 10),
      callback = JS(
        "table.on('dblclick', 'tr', function() {
        var data = table.row(this).data();
        Shiny.setInputValue('dblclicked_row', data);
      });"
      )
    )
  
  # register callback function for double-clicking rows
  observeEvent(input$dblclicked_row, {
    row_dblclicked(input$dblclicked_row)
  })
    
    output$distPlot <- renderPlot({
      
      x    <- faithful$waiting
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      hist(x, breaks = bins, col = "#007bc2", border = "white",
           xlab = "Waiting time to next eruption (in mins)",
           main = "Histogram of waiting times")
      
    })
    
    # example popup button
    observeEvent(input$popup_button, {
      showModal(
        modalDialog(
          title = "important popup",
          paste(input$input_message, ", du Mongo!")
        )
      )
    })
    
    
}


# ---- Run the application ----
shinyApp(ui = ui, server = server)
