This interactive Shiny app demonstrates how Markov Chains behave when exploring various target distributions using the Metropolis–Hastings algorithm. It’s designed to help students build intuition about how parameter choices affect performance and sampling quality.

## Features
- Adjust the number of iterations, step size, and target distribution
- Observe how step size influences exploration and convergence
- Explore scenarios where the chain gets stuck or fails to sample properly, such as in bimodal distributions

A small step size can cause the chain to remain in one region, while a large step size may reduce acceptance rates. The app allows real-time tuning to visualize these effects.

**Live App:** [https://nghojc-thomas-wright.shinyapps.io/metropolis-hastings_visualizer/](https://nghojc-thomas-wright.shinyapps.io/metropolis-hastings_visualizer/)

## License
MIT License
