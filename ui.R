library(shiny)
library(ggplot2)
library(Cairo)
# Define UI for dataset viewer application
fluidPage( 
  
  # Application title.
  titlePanel("Analysis on Household's income and expenditure."),
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view. The helpText function is
  # also used to include clarifying text. Most notably, the
  # inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). This is useful if
  # the computations required to render output are inordinately
  # time-consuming.
  sidebarLayout(
    sidebarPanel(
      selectInput("attribute", "Choose an attribute:", 
                  choices = c("Total Income", "Number of Children","Number of bedroom","Availability of Internet", "Ownership Of the house")),
      
      numericInput("obs", "Number of observations to view:", 5),
      
      helpText("Note: while the data view will show only the specified",
               "number of observations, the summary will still be based",
               "on the full dataset."),
      
     # radioButtons("dist", "Distribution type:",c("Total Income", "Number of Children", "Ownership of the Houses")),
      
    #  sliderInput("n", "Number of observations:", 
     #             value = 500,
      #            min = 1, 
       #           max = 1000),
  
      
      submitButton("Update View")
    ),
  fluidRow( 
    column(width = 4, wellPanel(
      radioButtons("plot_type", "Plot type",
                   c("base", "ggplot2")
      )
    )))),
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      tabsetPanel(type = "tabs", 
                              tabPanel("Plot", plotOutput("plot")), 
                              tabPanel("Summary", verbatimTextOutput("summary")), 
                              tabPanel("Observations", tableOutput("view"))

    )
    )
)
  

    

