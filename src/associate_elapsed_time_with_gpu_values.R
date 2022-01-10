
df_temp <- data.frame()
df_power <- data.frame()
df_gpu_util <- data.frame()
df_gpu_memory_util <- data.frame()

for(i in 1:1024){
  message(i)
  gpu1 <- gpu  %>% filter(machine_id == i)
  gpu1_task <- application.tasks %>%  filter(machine_id == i) 
  for(row in 1:nrow(gpu1_task)){
    ## find gpu values between start time and endtime
    findGpu <- gpu1 %>% filter(timestamp >= gpu1_task[row, "start_time"][[1]]) %>%  filter(timestamp <= gpu1_task[row, "timestamp"][[1]]) 
    temp_summary = summary(findGpu$gpuTempC)
    power_summary = summary(findGpu$powerDrawWatt)
    gpu_util_summary = summary(findGpu$gpuUtilPerc)
    gpu_memory_util_summary = summary(findGpu$gpuMemUtilPerc)
    
    
    ## adding to new dataframe
    task_summary_temp <- data.frame(taskId=gpu1_task[row, "taskId"],
                                    jobId=gpu1_task[row, "jobId"],
                                    hostname=gpu1[1,"hostname"],
                                    gpuSerial=gpu1[1,"gpuSerial"],
                                    level=gpu1_task[row, "level"],
                                    x=gpu1_task[row, "x"],
                                    y=gpu1_task[row, "y"],
                                    elapsed_time=gpu1_task[row, "elapsed_time"],
                                    Q1=temp_summary["1st Qu."][[1]],
                                    Q3=temp_summary["3rd Qu."][[1]],
                                    MEDIAN=temp_summary["Median"][[1]],
                                    MEAN=temp_summary["Mean"][[1]],
                                    MIN=temp_summary["Min."][[1]],
                                    MAX=temp_summary["Max."][[1]],
                                    SD=sd(findGpu$gpuTempC),
                                    COV=(sd(findGpu$gpuTempC) / mean(findGpu$gpuTempC))*100,
                                    machine_id=gpu1_task[row, "machine_id"])
    
    task_summary_power <- data.frame(taskId=gpu1_task[row, "taskId"],
                                     jobId=gpu1_task[row, "jobId"],
                                     hostname=gpu1[1,"hostname"],
                                     gpuSerial=gpu1[1,"gpuSerial"],
                                     level=gpu1_task[row, "level"],
                                     x=gpu1_task[row, "x"],
                                     y=gpu1_task[row, "y"],
                                     elapsed_time=gpu1_task[row, "elapsed_time"],
                                     Q1=power_summary["1st Qu."][[1]],
                                     Q3=power_summary["3rd Qu."][[1]],
                                     MEDIAN=power_summary["Median"][[1]],
                                     MEAN=power_summary["Mean"][[1]],
                                     MIN=power_summary["Min."][[1]],
                                     MAX=power_summary["Max."][[1]],
                                     SD=sd(findGpu$powerDrawWatt),
                                     COV=(sd(findGpu$powerDrawWatt) / mean(findGpu$powerDrawWatt))*100,
                                     machine_id=gpu1_task[row, "machine_id"])
    
    task_summary_gpu_util <- data.frame(taskId=gpu1_task[row, "taskId"],
                                     jobId=gpu1_task[row, "jobId"],
                                     hostname=gpu1[1,"hostname"],
                                     gpuSerial=gpu1[1,"gpuSerial"],
                                     level=gpu1_task[row, "level"],
                                     x=gpu1_task[row, "x"],
                                     y=gpu1_task[row, "y"],
                                     elapsed_time=gpu1_task[row, "elapsed_time"],
                                     Q1=gpu_util_summary["1st Qu."][[1]],
                                     Q3=gpu_util_summary["3rd Qu."][[1]],
                                     MEDIAN=gpu_util_summary["Median"][[1]],
                                     MEAN=gpu_util_summary["Mean"][[1]],
                                     MIN=gpu_util_summary["Min."][[1]],
                                     MAX=gpu_util_summary["Max."][[1]],
                                     SD=sd(findGpu$gpuUtilPerc),
                                     COV=(sd(findGpu$gpuUtilPerc) / mean(findGpu$gpuUtilPerc))*100,
                                     machine_id=gpu1_task[row, "machine_id"])
    
    task_summary_gpu_util <- data.frame(taskId=gpu1_task[row, "taskId"],
                                        jobId=gpu1_task[row, "jobId"],
                                        hostname=gpu1[1,"hostname"],
                                        gpuSerial=gpu1[1,"gpuSerial"],
                                        level=gpu1_task[row, "level"],
                                        x=gpu1_task[row, "x"],
                                        y=gpu1_task[row, "y"],
                                        elapsed_time=gpu1_task[row, "elapsed_time"],
                                        Q1=gpu_memory_util_summary["1st Qu."][[1]],
                                        Q3=gpu_memory_util_summary["3rd Qu."][[1]],
                                        MEDIAN=gpu_memory_util_summary["Median"][[1]],
                                        MEAN=gpu_memory_util_summary["Mean"][[1]],
                                        MIN=gpu_memory_util_summary["Min."][[1]],
                                        MAX=gpu_memory_util_summary["Max."][[1]],
                                        SD=sd(findGpu$gpuMemUtilPerc),
                                        COV=(sd(findGpu$gpuMemUtilPerc) / mean(findGpu$gpuMemUtilPerc))*100,
                                        machine_id=gpu1_task[row, "machine_id"])
    

    
    df_temp <- rbind(df_temp, task_summary_temp)
    df_power <- rbind(df_power, task_summary_power)
    df_gpu_util <- rbind(df_temp, task_summary_gpu_util)
    df_gpu_memory_util <- rbind(df_temp, task_summary_gpu_util)
  }
}