# Resources on WordClouds in R
# http://cran.r-project.org/web/packages/tm/vignettes/tm.pdf
# http://georeferenced.wordpress.com/2013/01/15/rwordcloud/

require(wordcloud) # word cloud
source("sotu.r")   # get data

# Create Wordcloud
# Can create directly from corpus too!

# png(
#     file.path("img", "sotu_cloud.png"),
#     width = 600,
#     height = 600)

wordcloud(
    sotu_df$word,
    sotu_df$freq,
    scale = c(0.5, 6),      # size of words
    min.freq = 10,          # drop infrequent
    max.words = 30,         # max words in plot
    random.order = FALSE,   # plot by frequency
    rot.per = 0.3,          # percent rotated
    # set colors
    # colors = brewer.pal(9, "GnBu")
    colors = brewer.pal(12, "Paired"),
    # color random or by frequency
    random.color = TRUE,
    # use r or c++ layout
    use.r.layout = FALSE    
)

# dev.off()