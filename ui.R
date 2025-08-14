library(shiny)

shinyUI(fluidPage(
  titlePanel("Metropolis-Hastings: Markov Chain Intuition"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("step_size", "Proposal SD (Step Size)", min = 0.01, max = 5, value = 1, step = 0.01),
      numericInput("n_iter", "Number of Iterations", value = 1000, min = 100),
      selectInput("target", "Target Distribution",
                   choices = c("Standard Normal", "Laplace", "Bimodal", "Uneven Mixture")),
      actionButton("run", "Run Sampler")
  ),
    
    mainPanel(
      plotOutput("tracePlot"),
      plotOutput("histPlot"),
      textOutput("acceptRate")
    )
  )
))
