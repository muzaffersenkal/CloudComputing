
## Calculation of elapsed time for event type
application.events <- application.checkpoints %>% 
  arrange(timestamp, taskId,eventName) %>%
  group_by(taskId, eventName) %>%
  mutate(elapsed_time = abs(as.numeric(timestamp)- as.numeric(lag(timestamp)))) %>%
  filter(elapsed_time != "" )


## Calculation of elapsed time for tasks
application.tasks <- application.events %>% filter(eventName == "TotalRender")