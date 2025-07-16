chassis.slew_drive_set(false);  // Disables global slew
chassis.slew_drive_constants_set(5_in, 50);

// Over the first 5 inches, the robot will ramp the speed limit from 50 to 110 
chassis.pid_drive_set(24_in, 110, true);  // Slew will be enabled for this motion
chassis.pid_wait();

// This will not use slew to travel backwards 24in
chassis.pid_drive_set(-24_in, 110);  
chassis.pid_wait();