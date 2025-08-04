chassis.pid_drive_set(24_in, 110, true);
chassis.pid_wait();

chassis.pid_turn_set(45_deg, 90);
chassis.pid_wait();

chassis.pid_turn_set(-45_deg, 90);
chassis.pid_wait();

chassis.pid_turn_set(0_deg, 90);
chassis.pid_wait();

chassis.pid_drive_set(-24_in, 110, true);
chassis.pid_wait();