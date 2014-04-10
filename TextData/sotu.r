# State of the Union Transcripts
# http://www.whitehouse.gov/state-of-the-union-2013
# http://www.presidency.ucsb.edu/sou.php

require(tm)        # corpus
require(SnowballC) # stemming

# Explore Sources #####
# getSources()
# getReaders()

# Create Corpus #####
# Many of these options are not required, but
# I want to show them to you.

sotu_source <- DirSource(
    # indicate directory
    directory = file.path("sotu"),
    encoding = "UTF-8",     # encoding
    pattern = "*.txt",      # filename pattern
    recursive = FALSE,      # visit subdirectories?
    ignore.case = FALSE)    # ignore case in pattern?

sotu_corpus <- Corpus(
    sotu_source, 
    readerControl = list(
        reader = readPlain, # read as plain text
        language = "en"))   # language is english

# Inspect Corpus #####
# print(sotu_corpus)
# summary(sotu_corpus)
# inspect(sotu_corpus)
# sotu_corpus[["sotu2013.txt"]]

# Transform Corpus #####
# getTransformations()
# sotu_corpus[[1]][3]

sotu_corpus <- tm_map(sotu_corpus, tolower)

sotu_corpus <- tm_map(
    sotu_corpus, 
    removePunctuation,
    preserve_intra_word_dashes = TRUE)

sotu_corpus <- tm_map(
    sotu_corpus, 
    removeWords, 
    stopwords("english"))

# getStemLanguages()
sotu_corpus <- tm_map(
    sotu_corpus, 
    stemDocument,
    lang = "porter") # try porter or english

sotu_corpus <- tm_map(
    sotu_corpus, 
    stripWhitespace)

# Remove specific words
sotu_corpus <- tm_map(
    sotu_corpus, 
    removeWords, 
    c("will", "can", "get", "that", "year", "let"))

# print(sotu_corpus[["sotu2013.txt"]][3])

# Calculate Frequencies
sotu_tdm <- TermDocumentMatrix(sotu_corpus)

# Inspect Frequencies
# print(sotu_tdm)
# inspect(sotu_tdm[40:44,])
# findFreqTerms(sotu_tdm, 20)
# inspect(sotu_tdm[findFreqTerms(sotu_tdm, 20),])

# Convert to term/frequency format
sotu_matrix <- as.matrix(sotu_tdm)
sotu_df <- data.frame(
    word = rownames(sotu_matrix), 
    # necessary to call rowSums if have more than 1 document
    freq = rowSums(sotu_matrix),
    stringsAsFactors = FALSE) 

# Sort by frequency
sotu_df <- sotu_df[with(
    sotu_df, 
    order(freq, decreasing = TRUE)), ]

# Do not need the row names anymore
rownames(sotu_df) <- NULL

# Check out final data frame
# View(sotu_df)