
## get first and last rows for each grouped machine
machine_first_last <- application.tasks %>%
  group_by(machine_id) %>%
  arrange(timestamp) %>%
  filter(row_number()==1 | row_number()==n())


## total elapsed time by machine
total_elapsed_time <- application.tasks %>% group_by (machine_id) %>% summarize(total_elapsed_time= sum(elapsed_time))

machine_schedule_time <- data.frame()

for(i in 1:1024){
  
  find_total_time <- total_elapsed_time %>% filter(machine_id == i)
  fm <- machine_first_last %>% filter(machine_id == i)
  
  # find expected time
  expected_time <- abs(as.numeric(fm[1,"start_time"])- as.numeric(fm[2,"timestamp"]))
  
  item <- data.frame(expected_time=expected_time, elapsed_time=find_total_time[1,"total_elapsed_time"][[1]], machine_id=i)
  
  machine_schedule_time <- rbind(machine_schedule_time, item)
  
}

## calculate difference between elapsed and expected time (delay)
machine_schedule_time <- machine_schedule_time %>% mutate(delay_time = expected_time - elapsed_time)
