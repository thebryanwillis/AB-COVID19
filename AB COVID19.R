install.packages("tidyverse")
library(tidyverse)
install.packages("gganimate")
library(gganimate)
install.packages("gifski")
library(gifski)

#Read in and display the data
covid = read.csv(file = "/cloud/project/AB COVID.csv")
covid
#Produce static scatterplot graph for recoveries
p = ggplot(covid, aes(x=Day.Count, y=Case.Count, colour = Alberta.Health.Services.Zone))+geom_point(show.legend = FALSE)+labs(x="Days", y="# of Cases")
#Split by Health Zone, add trails, elapse by day
p = p + facet_wrap(~Alberta.Health.Services.Zone) +transition_time(Day.Count)+ shadow_mark(alpha = 0.3, size = 0.75)+labs(title = "Day: {frame_time} of Cases")
#Animate graph
animate(p, duration = 7, fps = 25, width = 800, height = 450, renderer = gifski_renderer())
anim_save("cases.gif")

#Produce static scatterplot graph for deaths
p2 = ggplot(covid, aes(x=Day.Count, y=Death.Count, colour = Alberta.Health.Services.Zone))+geom_point(show.legend = FALSE)+labs(x="Days", y="# of Deaths")
#Split by Health Zone, add trails, elapse by day
p2 = p2 + facet_wrap(~Alberta.Health.Services.Zone) +transition_time(Day.Count)+ shadow_mark(alpha = 0.3, size = 0.75)+labs(title = "Day: {frame_time} of Deaths")
#Animate graph
animate(p2, duration = 7, fps = 25, width = 800, height = 450, renderer = gifski_renderer())
anim_save("death.gif")

#Filter data to only show day 120
covid120 = covid %>% filter(Day.Count == 120)
#Produce graph to show total cases
case = ggplot(covid120, aes( y = Case.Count, x=Alberta.Health.Services.Zone, colour = Alberta.Health.Services.Zone))+geom_boxplot(show.legend = FALSE)+labs(x="Alberta Health Zone", y = "# of Cases")+theme(text = element_text(size=10), axis.text.x = element_text(angle=30, hjust=1))+geom_text(aes(label = Case.Count), size = 3, position=position_dodge(width=0.9), vjust=-0.5, show.legend = FALSE)
case
ggsave("case.png")
#Produce graph to show total deaths
death = ggplot(covid120, aes( y = Death.Count, x=Alberta.Health.Services.Zone, colour = Alberta.Health.Services.Zone))+geom_boxplot(show.legend = FALSE)+labs(x="Alberta Health Zone", y = "# of Deaths")+theme(text = element_text(size=10), axis.text.x = element_text(angle=30, hjust=1))+geom_text(aes(label = Death.Count), size = 3, position=position_dodge(width=0.9), vjust=-0.5, show.legend = FALSE)
death
ggsave("death.png")
