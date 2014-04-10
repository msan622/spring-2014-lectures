require(ggplot2)
source("sotu.r")

# http://stackoverflow.com/questions/17294824/counting-words-in-a-single-document-from-corpus-in-r-and-putting-it-in-dataframe

# Create a data frame comparing 2012 and 2014
freq_df <- data.frame(
    sotu2012 = sotu_matrix[, "sotu2012.txt"],
    sotu2014 = sotu_matrix[, "sotu2014.txt"],
    stringsAsFactors = FALSE)

rownames(freq_df) <- rownames(sotu_matrix)

# Filter out infrequent words
# freq_df <- freq_df[rowSums(freq_df) > 30,]

# Alternatively, just look at top 15
freq_df <- freq_df[order(
    rowSums(freq_df), 
    decreasing = TRUE),]

freq_df <- head(freq_df, 15)

# Plot frequencies
p <- ggplot(freq_df, aes(sotu2012, sotu2014))

p <- p + geom_text(
    label = rownames(freq_df),
    position = position_jitter(
        width = 2,
        height = 2))

p <- p + xlab("Year 2012") + ylab("Year 2014")
p <- p + ggtitle("State of the Union")
p <- p + scale_x_continuous(expand = c(0, 0))
p <- p + scale_y_continuous(expand = c(0, 0))
p <- p + coord_fixed(
    ratio = 5/6, 
    xlim = c(0, 60),
    ylim = c(0, 50))

print(p)

ggsave(
    filename = file.path("img", "sotu_freq.png"),
    width = 6,
    height = 4,
    dpi = 100
)