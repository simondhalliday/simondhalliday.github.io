


library(tidyverse)
dCumul <- c(0.02, 0.06, 0.1, 0.16, 0.24, 0.32, 0.4, 0.56, 0.76, 1)
dAreaA <- c(0.08,	0.14,	0.2, 0.24, 0.26, 0.28, 0.3, 0.24, 0.14, 0)
deciles <- seq(0.1, 1, 0.1)
LorenzDF <- as.data.frame(cbind(dCumul, dAreaA, deciles))
# LorenzDF <- 
#   LorenzDF %>%  
#   mutate(Equality = dCumul + dAreaA)
LorenzDFNar <- 
  LorenzDF %>% 
  gather(Measure, share, -deciles)

LorenzDFNar <- 
  LorenzDFNar %>%
  mutate(Measure = factor(Measure,
                       levels = c("dAreaA", "dCumul"),
                       labels = c("Area A", "Area B")
                       )
         )

LorenzDFNar %>% 
  ggplot(aes(x = as.factor(deciles), y = share, color = Measure)) +
  geom_col(aes(fill = Measure), position = "stack") + 
  annotate("text", x = "0.2", y = 0.9, label = "Economy D") +
  annotate("text", x = "0.2", y = 0.8, label = paste0("Gini == ~frac(A, A + B)== 0.34"), parse = TRUE) + 
  xlab("Cumulative Population") + 
  scale_y_continuous(name = "Cumulative Density", 
                     breaks = seq(0.1, 1, 0.1),
                     labels = seq(0.1, 1, 0.1)) +
  scale_colour_grey(start = 0.7, end = 0.4, aesthetics = "colour") + 
  scale_fill_grey(start = 0.7, end = 0.4, aesthetics = "fill") +
  theme_classic()
ggsave(file = "lorenz_bar.png", width = 6, height = 4, units = c("in"), dpi = 300)
