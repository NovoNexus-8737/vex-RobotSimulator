slew_calc:
    type: procedure
    debug: false
    definitions: distance_traveled|slew_distance|final_distance|initial_speed|final_speed
    script:
        - if <[distance_traveled]> > <[slew_distance]>:
            - determine <[final_speed]>

        - define normalizedSpeed <[final_speed].sub[<[initial_speed]>]>
        - define speed <[initial_speed].add[<[normalizedSpeed]>].mul[<[distance_traveled].div[<[final_distance]>]>]>
        - determine <[speed]>

