# BASIC CHARTS
# USING ECONOMICS DATASET

# GGPLOT2 GRAMMAR OF GRAPHICS
# - Dataset
# - Mapping from Variables to Aesthetics
# - Layers Including:
#   - Geometry
#   - Statistical Transformations
#   - Positions
#   - (Optionally Dataset and Aestetics)
# - Scales
# - Coordinates
# - Facet Specification (Small Multiples)

library(ggplot2)
library(scales)

# Scatter
scatterplot <- ggplot(economics, aes(x = date, y = psavert)) +
  geom_point() +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Year")

print(scatterplot)
ggsave("economics-scatter.png", width = 9, height = 4.25, dpi = 300, units = "in")


# Line
lineplot <- ggplot(economics, aes(x = date, y = psavert)) +
  geom_line() +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Year")

print(lineplot)
ggsave("economics-line.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Area
areaplot <- ggplot(economics, aes(x = date, y = psavert)) +
  geom_area() +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Year")

print(areaplot)
ggsave("economics-area.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Add Columns
# This will make it easier to filter and facet dataset
economics$year  <- 1900 + as.POSIXlt(economics$date)$year
economics$month <- 1 + as.POSIXlt(economics$date)$mon

# Bar
barplot <- ggplot(subset(economics, year >= 2003), aes(x = date, y= psavert)) +
  geom_bar(stat = "identity") +
  ylim(-5, 5) +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Year")

print(barplot)
ggsave("economics-bar.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Box
boxplot <- ggplot(subset(economics, year <= 1990), aes(x = factor(year), y = psavert)) +
  geom_boxplot() +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Year")

print(boxplot)
ggsave("economics-box.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Multi-Line
monthtext <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
multiplot <- ggplot(subset(economics, year %in% seq(1970, 2010, 5)),
                    aes(x = month, y = psavert,
                        group = factor(year),
                        color = factor(year))) +
  geom_line() +
  ggtitle("US Economic Time Series") +
  ylab("Personal Savings Rate") +
  xlab("Month") +
  scale_x_discrete(labels = monthtext) +
  labs(colour = "Year")

print(multiplot)
ggsave("economics-multi.png", width = 9, height = 4.25, dpi = 300, units = "in")

# Facet
facetplot <- multiplot +
  facet_wrap( ~ year, ncol = 4) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = seq(1, 12))

print(facetplot)
ggsave("economics-facet.png", width = 9, height = 4.25, dpi = 300, units = "in")
