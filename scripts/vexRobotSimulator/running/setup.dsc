vexRobotSimulator:
    type: command
    name: vexRobotSimulator
    aliases:
        - vrs
    description: A simulator for VEX robots.
    usage: /vexRobotSimulator [reload]|[spawn_field]|[spawn_robot]|[start_auton] (location) (file)
    script:
        - define args <context.args>




load_files:
    type: task
    debug: true
    script:
        - debug debug works
        - define path src/output

        - foreach <util.list_files[<[path]>]> as:filePath:
            - ~fileread path:<[path]>/<[filePath]> save:data
            - define fileData <entry[data].data.utf8_decode>
            - debug debug <[fileData]>

