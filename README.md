valid movement functions:


pid_drive_set(int distance, int speed, bool slew) -> drive,distance,speed,slew
pid_wait() -> waitfor
pid_turn_set(int angle, int speed) -> turn,angle,speed
pid_wait_until(int length) -> waituntil,length
slew_drive_constants_set(int distance, int speed) -> slew,distance,speed


slew_global,false -> determines if the flag is for queue or server
slew,5_in,50    -> flag the QUEUE with the slew, if its global then flag the server.
drive,24_in,110,true -> if its true, it will apply the slew function
waitfor
drive,-24_in,110
waitfor