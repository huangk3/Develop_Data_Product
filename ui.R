library(shiny)

shinyUI(fluidPage(
  #Application title
  titlePanel(h2("Predict your car's MPG!")),
  
  sidebarLayout(
    sidebarPanel(
      p("Please input your car's weight, select the type of your cylinder and transmission from below panel. 
      Your car's predicted mpg  as well as the 95% confidence interval will be shown in the right panel reactively."),
      textInput("wt", h4("The weight of your car (lb):"), value=3000),
      selectInput("cyl", h4("Cylinder Type:"), choices=list("4 Cylinders"=4, "6 Cylinders"=6, "8 Cylinders"=8),selected=4),
      radioButtons('am', h4("Transmission Type:"), choices=list("Automatic"="0", "Manual"="1"),selected="0"),
      p("Select the category you want the points to be grouped by, 
        the app will produce an overview of the relationship between mpg and weight in the 'mtcars' 
        dataset. A linear regression line as well as the standard error interval for each 
        category are added as well."),
      radioButtons('tp', h5("Plot of MPG~Weight in Database and Grouped By:"), choices=list("Cylinder type"="cyl", "Transmission type"="am", "NoGroup"="NULL"),selected="NULL")
        ),
    mainPanel(
      h4("The predicted MPG of your car is:"),
      textOutput("p_mpg"),
      br(),
      h4("The 95% Confidence Interval is:"),
      textOutput("ci"),
      br(),
      plotOutput("plot_mpg_wt")
        )
      )
    )
  )