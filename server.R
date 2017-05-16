library(shiny)
# Define server logic required to summarize and view the 
# selected dataset

dataset<- read.csv(file="household_income.csv",header=FALSE,sep=",")
function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$attribute,
           "income_husband"=income_husband,
           "number_children" = number_children,
           "bedrooms"= bedrooms,
           "internet"=internet,
           "own"=own)
    dist(input$n)
  })
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$plot <- renderPlot({
  
    if (input$plot_type == "base") {
      if(input$attribute == "Number of Children"){
      plot(household_income$income_husband,household_income$number_children)}
      if(input$attribute == "Number of bedroom"){
        plot(household_income$income_husband,household_income$bedrooms)}
      if(input$attribute == "Availability of Internet"){
        plot(household_income$income_husband,household_income$internet)}
      if(input$attribute == "Ownership Of the house"){
        plot(household_income$income_husband,household_income$own)}
    } else if (input$plot_type == "ggplot2") {
        if(input$attribute == "Number of Children"){
        ggplot(household_income, aes(household_income$income_husband,household_income$number_children)) + geom_point()}
      if(input$attribute == "Number of bedroom"){
        ggplot(household_income, aes(household_income$income_husband,household_income$bedrooms)) + geom_point()}
      if(input$attribute == "Availability of Internet"){
        ggplot(household_income, aes(household_income$income_husband,household_income$internet)) + geom_point()}
      if(input$attribute == "Ownership Of the house"){
        ggplot(household_income, aes(household_income$income_husband,household_income$own)) + geom_point()}
    }
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
   # dataset <- datasetInput()
    summary(dataset)
  })
  
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(dataset, n = input$obs)
  })
 
}