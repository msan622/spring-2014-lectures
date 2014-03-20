# BASIC CHARTS
# USING MOVIES DATASET

library(ggplot2)

# Add Columns
print(colnames(movies)[18:24]) # should be the genres
movies$num_genres <- rowSums(movies[, 18:24])

# Histogram
histplot1 <- ggplot(movies, aes(x = rating)) +
  geom_histogram(binwidth = 0.5) +
  ggtitle("Movie IMDB Ratings") +
  xlab("Rating") +
  ylab("Count")

print(histplot1)
ggsave("movies-hist1.png", width = 9, height = 4.25, dpi = 300, units = "in")

histplot2 <- ggplot(movies, aes(x = rating)) +
  geom_histogram(binwidth = 0.25) +
  ggtitle("Movie IMDB Ratings") +
  xlab("Rating") +
  ylab("Count")

print(histplot2)
ggsave("movies-hist2.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Stack Bar
stackbar <- ggplot(subset(movies, mpaa != ""), aes(x = rating, fill = mpaa)) +
  geom_bar(binwidth = 0.25) +
  labs(fill = "MPAA Rating") +
  ggtitle("Movie IMDB Ratings") +
  xlab("Rating") +
  ylab("Count") +
  theme(legend.justification = 'right') +
  theme(legend.position = c(1, 0.81))

print(stackbar)
ggsave("movies-stackbar.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Stack Area
stackarea <- ggplot(subset(movies, mpaa != ""), aes(x = rating, fill = mpaa)) +
  stat_bin(binwidth = 0.1, geom = "area") +
  labs(fill = "MPAA Rating") +
  ggtitle("Movie IMDB Ratings") +
  xlab("Rating") +
  ylab("Count") +
  theme(legend.justification = 'right') +
  theme(legend.position = c(1, 0.81))

print(stackarea)
ggsave("movies-stackarea.png", width = 9, height = 4.25, dpi = 300, units = "in")
