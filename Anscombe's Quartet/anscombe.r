# Original Post
# http://4dpiecharts.com/2011/08/22/more-useless-statistics/

library(ggplot2)
library(plyr)

# Load the Anscombe's Quartet dataset
data(anscombe)

# Combine all x and y points into a single vectors
x <- with(anscombe, c(x1, x2, x3, x4))
y <- with(anscombe, c(y1, y2, y3, y4))

# Indicate which group each (x, y) point belongs
group <- gl(4, nrow(anscombe))

# Place everything into single dataframe
df <- data.frame(group, x, y)

# Statistics are near identical
# Uses plyr package to calculate
stats <- ddply(df, .(group), summarize,
               mean_x = mean(x),
               mean_y = mean(y),
               var_x = var(x),
               var_y = var(y),
               correlation = cor(x, y),
               lm_intercept = lm(y ~ x)$coefficients[1],
               lm_x_effect = lm(y ~ x)$coefficients[2])

print(stats)

# Plot values in ggplot2
p <- ggplot(df, aes(x, y, color = group)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE) +
  scale_x_continuous(limits=c(0, 20), expand = c(0, 0), breaks = seq(5, 20, 5)) +
  scale_y_continuous(limits=c(0, 15), expand = c(0, 0), breaks = seq(0, 15, 5)) +
  ggtitle("Anscombe's Quartet") +
  theme(legend.position = "none") +
  facet_wrap(~ group, nrow = 1)

print(p)
ggsave("anscombe.png", width = 9, height = 3.0)
