library(shiny)

shinyServer(function(input, output) {
  
  observeEvent(input$run, {
    
    # Metropolis-Hastings setup
    n <- input$n_iter
    step_size <- input$step_size
    samples <- numeric(n)
    accept <- 0
    
    # Target Distributions
    log_target <- switch(input$target,
                         "Standard Normal" = function(x) {
                           -0.5 * x^2  # log of standard normal
                         },
                         "Laplace" = function(x) {
                           -abs(x) 
                         },
                         "Bimodal" = function(x) {
                           log(0.5 * dnorm(x, mean = -4, sd = 1) + 
                               0.5 * dnorm(x, mean = 4, sd = 1))
                         },
                         "Uneven Mixture" = function(x) {
                           log(0.6 * dnorm(x, -5, 1) + 
                               0.3 * dnorm(x, 0, 0.5) + 
                               0.1 * dnorm(x, 5, 0.8))
                         }
    )
    
    # MH Algo
    samples[1] <- rnorm(1)
    for (i in 2:n) {
      proposal <- rnorm(1, mean = samples[i-1], sd = step_size)
      log_accept_ratio <- log_target(proposal) - log_target(samples[i-1])
      if (log(runif(1)) < log_accept_ratio) {
        samples[i] <- proposal
        accept <- accept + 1
      } else {
        samples[i] <- samples[i-1]
      }
    }
    
    # Traceplot
    output$tracePlot <- renderPlot({
      plot(samples, type = "l", main = "Trace Plot", xlab = "Iteration", ylab = "Position in Target Distriubtion")
    })
    
    # Histogram of samples
    output$histPlot <- renderPlot({
      hist(samples, breaks = 40, probability = TRUE,
           col = "skyblue", main = "Histogram of Samples",
           xlab = "Position in Target Distribution",
           xlim = c(-8, 8))
      
    # Display target distribution over sample histogram
    if (input$target == "Standard Normal") {
        curve(dnorm(x), 
              col = "red", lwd = 2, add = TRUE)
      } else if (input$target == "Laplace") {
        curve(0.5 * exp(-abs(x)), 
              col = "red", lwd = 2, add = TRUE, from = -10, to = 10)
      } else if (input$target == "Bimodal") {
        curve(0.5 * dnorm(x, -4, 1) + 
              0.5 * dnorm(x, 4, 1), 
              col = "red", lwd = 2, add = TRUE, from = -10, to = 10)
      }
      else if (input$target == "Uneven Mixture") {
        curve(0.6 * dnorm(x, -5, 1) +
              0.3 * dnorm(x, 0, 0.5) +
              0.1 * dnorm(x, 5, 0.8),
              col = "red", lwd = 2, add = TRUE, from = -10, to = 10)
      }
    })
    
  # Proposal acceptance rate
  output$acceptRate <- renderText({
      rate <- round(accept / n * 100, 2)
      paste("Acceptance Rate:", rate, "%")
    })
  })
})