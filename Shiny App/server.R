library(shiny)

set.seed(1314)
# data processing
data(mtcars)
mtcars$am <- factor(mtcars$am, labels = c("Auto", "Manual"))
mtcars$cyl <- as.factor(mtcars$cyl)
tidy <- mtcars[, c(9, 2, 4, 6, 1)]

# fit
fit <- lm(mpg ~ am + cyl + hp + wt + am:wt, data = tidy)

shinyServer(
    function(input, output){
    output$hist <- renderPlot({
        am <- input$am
        cyl <- input$cyl
        hp <- input$hp
        wt <- input$wt
        a <- data.frame(am = am, cyl = cyl, hp = hp, wt = wt)
        mpgPred <- predict(fit, a)
        hist(tidy$mpg, xlab = "MPG (Miles Per Gallon)", ylab = "Frequency", col = "lightblue",
             ylim = c(0, 20), xlim = c(0, 40), breaks = 10, main = 'Histogram of MPG')
        lines(c(mpgPred, mpgPred), c(0, 16), col= "red", lwd = 5)
        text(8, 19, paste("MPG = ", round(mpgPred, 2)))
        })

    }
)