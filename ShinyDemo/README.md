Shiny Demo
==============================

![Bar Chart](barchart.png)

Demos
------------------------------

- [**Demo 1**](demo1/) shows a basic `shiny` app. To run this demo, use the following R code:

  ```R
  library(shiny)
  runGitHub("lectures", "msan622", subdir = "ShinyDemo/demo1")
  ```

- [**Demo 2**](demo2/) shows the same `shiny` app but with a different page layout. (Note you have to download these demos to run this example.)

- [**Demo 3**](demo3/) shows a different `shiny` app that simulates _brushing_, allowing the user to highlight different categories. To run this demo, use the following R code:

  ```R
  library(shiny)
  runGitHub("lectures", "msan622", subdir = "ShinyDemo/demo3")
  ```

  This example also uses _jittering_ to deal with overplotting. However, jitter is recalculated every time the plot is recalculated, causing the points to move. To avoid this, you can pre-jitter the dataset before plotting.

References
------------------------------

- [Shiny Package](http://www.rstudio.com/shiny/)
- [Shiny Application Layout Guide](https://github.com/rstudio/shiny/wiki/Shiny-Application-Layout-Guide)
- [Show Me Shiny](http://www.showmeshiny.com/)


