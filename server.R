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
        plot(household_income$income_husband,household_income$number_children)
        mtext(expression(bold("The lower the income of the husband, the lesser the number of his children.\n  ", font=4)))
        mtext('   x-axis: Income of the husband\n y-axis: Number of children', side=1, line=3.5, at=9)
      }
      if(input$attribute == "Number of bedroom"){
        plot(household_income$income_husband,household_income$bedrooms)
        mtext("Average of the household have 4 beds in the house regardless of the income they earned\n ", font=4)
        mtext('   x-axis: Income of the husband\n y-axis: Number of bedrooms', side=1, line=3.5, at=9)
      }
      if(input$attribute == "Availability of Internet"){
        plot(household_income$income_husband,household_income$internet)
        mtext("People of all income range prefer to have internet at home\n", font=4)
        mtext('   x-axis: Income of the husband\n y-axis: Availability of Internet', side=1, line=3.5, at=9)
      }
      
      if(input$attribute == "Ownership Of the house"){
        plot(household_income$income_husband,household_income$own)
        mtext("Most of the household owned a house regardless of the income they earned\n ", font=4)
        mtext('   x-axis: Income of the husband\n     y-axis: Ownership Of the house', side=1, line=3.5, at=9)
      }
    } else if (input$plot_type == "ggplot2") {
      if(input$attribute == "Number of Children"){
        print(ggplot(household_income, aes(household_income$income_husband,household_income$number_children)) +ggtitle("The lower the income of the husband, the lesser the number of his children\n x-axis: Income of the husband\n y-axis: Number of children\n ")+ geom_point())
        
      }
      if(input$attribute == "Number of bedroom"){
       print(ggplot(household_income, aes(household_income$income_husband,household_income$bedrooms)) +ggtitle("The lesser the income of the husband, the lesser the number of the bedrooms\n x-axis: Income of the husband\n y-axis: Number of bedrooms\n") + geom_point())
      
      }
      if(input$attribute == "Availability of Internet"){
      print(ggplot(household_income, aes(household_income$income_husband,household_income$internet))+ ggtitle("0 shows that no Internet available, 1 shows that Internet is available\n x-axis: Income of the husband\n y-axis: Availability of Internet\n") + geom_point())
        
      }
      if(input$attribute == "Ownership Of the house"){
       print(ggplot(household_income, aes(household_income$income_husband,household_income$own)) +ggtitle("1 shows house rented, 2 shows they own houses\n x-axis: Income of the husband\n y-axis: Ownership Of the house\n")+ geom_point())
      }
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