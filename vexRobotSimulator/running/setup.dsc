vexRobotSimulator:
    type: command
    name: vexRobotSimulator
    aliases:
        - vrs
    description: A simulator for VEX robots.
    usage: /vexRobotSimulator [reload]|[spawn_field]|[start_auton] (location) (file)
    script:
        - define args <context.args.first>

        - choose <[args]>:
            - case reload:
                - flag server vex.simulation:!
                - run load_files
                - narrate "<&a>VEX Robot Simulator has been reloaded successfully."
            # - case start_auton:

inches_to_meters:
    type: procedure
    debug: false
    definitions: inches
    script:
        - determine <[inches].mul[0.0254]>


auton_test_1:
    type: task
    debug: true
    script:
        - foreach <server.flag[vex.simulation.easy_drive]> key:sequence as:data:
            - define command <[data].keys.first>
            - define args <[data].values.first>

            - debug debug <[command]>_<[args]>


drive_function:
    type: task
    debug: false
    definitions: robot|distance|drive_speed
    script:

        # Gear ratio = 3/4
        - define gear_ratio <element[3].div[4]>

        - define wheel_diameter <element[3.25].proc[inches_to_meters]>

        # Circumference = π * diameter
        - define wheel_circumference <util.pi.mul[<[wheel_diameter]>]>

        - define RPM <[drive_speed].div[127].mul[450]>

        - define wheel_RPS <[RPM].div[60].mul[<[gear_ratio]>]>

        - define speed <[wheel_RPS].mul[<[wheel_circumference]>]>

        - define speed_per_tick <[speed].div[20]>

        - define current_distance 0
        - while <[current_distance]> < <[distance].proc[inches_to_meters]>:
            - teleport <[robot]> <[robot].location.forward_flat[<[speed_per_tick]>]>
            - define current_distance <[current_distance].add[<[speed_per_tick]>]>
            - wait 1t



rotate_function:
    type: task
    debug: true
    definitions: robot|angle|rotate_speed
    script:

        - define max_degrees_per_second 360

        - define degrees_per_tick <[rotate_speed].div[127].mul[<[max_degrees_per_second]>].div[20]>

        - define current_angle 0
        - while <[current_angle]> < <[angle]>:
            - debug debug <[current_angle]>
            - define current_angle <[current_angle].add[1]>
            - if <[loop_index].mod[20]> == 0:
                - wait 1t


# field is 12ftx12ft
# aka 3.6576x3.6576 meters
# 1 inch = 0.0254 meters

# robot is 0.4572x0.4572 meters
# every 4 rotations of the motor is 3 rotations of the wheel
# convert to speed per tick, then do the rotations ^^


load_files:
    type: task
    debug: false
    script:
        - define path scripts/src/output

        - foreach <util.list_files[<[path]>]> as:fileName:
            - ~fileread path:<[path]>/<[fileName]> save:data
            - define fileData <entry[data].data.utf8_decode>
            - define autonName <[fileName].split[.].first>

            - foreach <[fileData].split[*]> as:line:
                - debug debug <[line].split[,]>
                - define command <[line].split[,].first>
                - define arguments <[line].split[,].remove[1]>

                - flag server vex.simulation.<[autonName]>.<[loop_index]>.<[command]>:<[arguments]>


