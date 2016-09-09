library(shiny)
shinyUI(pageWithSidebar(
    headerPanel(
        h1("Predicting a Car's MPG")
    ),
    
    sidebarPanel(
        
        selectInput("am", "Transmission Type", c("Auto", "Manual")),
        selectInput("cyl", "Number of Cylinders", c("4", 6, 8)),
        sliderInput("hp", "Horse Power (hp)", value = 200, min = 50, max = 350, step = 10),
        sliderInput('wt', "Weight (1000 lbs)", value = 3.3, min = 1.0, max = 5.5, step = 0.1),
        submitButton('Submit')
    ),
    
    mainPanel(
        p("This app is used to predict mpg values for a car based on 1974", em("Motor Trend"), "data."),
        p("The mpg is predicted by linear model consisting of transmission type, number of cylinders, horsepower and car weight (1000 lbs)."),
        p("A", a(href = "https://xinyuanwu9.github.io/Data-Products-Course-Project/index.html#1", "5-page presentation"), "is used to summarizes data processing and regression model."),
        hr(),
        plotOutput("hist")
        
    )
    
    
    
    
))