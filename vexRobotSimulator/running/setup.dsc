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
                - run load_files
                - narrate "<&a>Loaded <util.list_files[src/output].size> files!"
            
            - case spawn_field:
                




load_files:
    type: task
    debug: false
    script:
        - define path src/output

        - foreach <util.list_files[<[path]>]> as:fileName:
            - ~fileread path:<[path]>/<[fileName]> save:data
            - define fileData <entry[data].data.utf8_decode>
            - define autonName <[fileName].split[.].first>

            - foreach <[fileData].split[*]> as:line:
                - debug debug <[line].split[,]>
                - define command <[line].split[,].first>
                - define arguments <[line].split[,].remove[1]>

                - flag server simulation.<[autonName]>.<[loop_index]>.<[command]>:<[arguments]>


