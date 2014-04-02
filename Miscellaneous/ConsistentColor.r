# This demonstrates how to keep color consistent even
# when you filter out data.

library(ggplot2)
library(scales)

# Load test dataset
data("iris")

# Plot the iris dataset
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species))
p <- p + geom_point()
p <- p + xlim(4, 8)
p <- p + ylim(1, 5)
print(p)

# Filter out "setosa" points
df <- subset(iris, Species != "setosa")

# Plot the filtered dataset
p <- ggplot(df, aes(x = Sepal.Length, y = Sepal.Width, color = Species))
p <- p + geom_point()
p <- p + xlim(4, 8)
p <- p + ylim(1, 5)
print(p)

# Note that the plot now assigns red to "versicolor", and
# "setosa" doesn't even show up on the legend anymore.

# We can the "limits" attribute to indicate color should
# still consider all the levels found in the original dataset.

p <- ggplot(df, aes(x = Sepal.Length, y = Sepal.Width, color = Species))
p <- p + geom_point()
p <- p + xlim(4, 8)
p <- p + ylim(1, 5)

# This is where we force the color calculation to consider
# the original unfiltered dataset.
p <- p + scale_colour_discrete(limits = levels(iris$Species))
print(p)
