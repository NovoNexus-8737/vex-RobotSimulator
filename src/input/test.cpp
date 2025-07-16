chassis.pid_drive_set(24_in, DRIVE_SPEED, true);
chassis.pid_wait();

chassis.pid_turn_set(45_deg, TURN_SPEED);
chassis.pid_wait();

chassis.pid_swing_set(ez::RIGHT_SWING, -45_deg, SWING_SPEED, 45);
chassis.pid_wait();

chassis.pid_turn_set(0_deg, TURN_SPEED);
chassis.pid_wait();

chassis.pid_drive_set(-24_in, DRIVE_SPEED, true);
chassis.pid_wait();