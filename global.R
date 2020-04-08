

library(ggplot2)
library(dplyr)
library(RColorBrewer)
temp <- read.csv("Temperature_1961-2010.csv", stringsAsFactors = FALSE)
col_strip <- brewer.pal(11, "RdBu")
