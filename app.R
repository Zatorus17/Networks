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

# ---- source ----
source("lib/functions.R")

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
               checkboxInput("checkbox_input", "Klicken Sie hier, um fortzufahren")
      ),
      
      tabPanel("Tab 3",
               tableOutput("table_tab3")
      )
    )
)


# ---- server ----
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
    
    # output table for third tab
    output$table_tab3 <- renderTable({
      iris
    })
    
    output$distPlot <- renderPlot({
      
      x    <- faithful$waiting
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      hist(x, breaks = bins, col = "#007bc2", border = "white",
           xlab = "Waiting time to next eruption (in mins)",
           main = "Histogram of waiting times")
      
    })
}

# ---- Run the application ----
shinyApp(ui = ui, server = server)
