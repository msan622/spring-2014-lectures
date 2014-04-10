require(ggplot2)
source("sotu.r")

# Sort bars by frequency
bar_df <- head(sotu_df, 10)
bar_df$word <- factor(bar_df$word, 
    levels = bar_df$word, 
    ordered = TRUE)

# Print a simple bar plot of the top 10 words
p <- ggplot(bar_df, aes(x = word, y = freq)) +
    geom_bar(stat = "identity", fill = "grey60") +
    ggtitle("State of the Union Address 2012 to 2014") +
    xlab("Top 10 Word Stems (Stop Words Removed)") +
    ylab("Frequency") +
    theme_minimal() +
    scale_x_discrete(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme(panel.grid = element_blank()) +
    theme(axis.ticks = element_blank())

print(p)

ggsave(
    filename = file.path("img", "sotu_bar.png"),
    width = 6,
    height = 4,
    dpi = 100
)