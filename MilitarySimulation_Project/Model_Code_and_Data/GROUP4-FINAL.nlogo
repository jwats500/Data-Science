extensions [time]

globals [

  japanese31th
  japanese15th
  japanese33th

  british17th
  british20th
  british23rd
  british50th
  british2nd
  british5th
  british7th

  combat_area
  max_supplies

  patch-midpoint1
  patch-midpoint2
  patch-midpoint3
  patch-kohima
  patch-imphal

  patch-british-retreat1
  patch-british-retreat2
  patch-japanese-retreat1
  patch-japanese-retreat2
  patch-japanese-retreat3

  date
  month
  retreat-time
  control-imphal
  control-kohima
  victor

  goal-radius
  japan-casualties-combat
  britain-casualties-combat
  japan-casualties-hunger
  britain-casualties-hunger
]


turtles-own [
  tag
  goal ; target location
  team
  status
  supplies
  hunger
  health
  goal-patch
  retreat-patch
]

patches-own [terrain]

to initial_setup
  clear-all

  set date time:anchor-to-ticks (time:create "1944-03-08") 1 "days"
  ;;set t-day time:create "01-02"
  set goal-radius 0.1

  ;; change me
  set max_supplies 1000

  ;; set locations
  set patch-midpoint1 patch  5 7
  set patch-midpoint2 patch  6 -3
  set patch-midpoint3 patch  -3 -13
  set patch-kohima patch  2 14
  set patch-imphal patch  -1 -3

  set patch-british-retreat1 patch -6 15
  set patch-british-retreat2 patch -15 -1
  set patch-japanese-retreat1 patch 14 4
  set patch-japanese-retreat2 patch 14 -6
  set patch-japanese-retreat3 patch 11 -12

  set control-imphal "Britain"
  set control-kohima "Britain"

  import-pcolors-rgb "ImphalKohimaMap.jpg"
  import-drawing "ImphalKohimaMap.jpg"

  let forest patches with [pcolor = [162 192 158] ] ;light green
  let mountForest patches with [pcolor = [133 146 116] ] ;deeper green
  let mountain patches with [pcolor = [199 199 191] ] ;purple
  let flatland patches with [pcolor = [227 231 208] ] ;white

  ask forest [set terrain "Forest"]
  ask mountForest [set terrain "MountForest"]
  ask mountain [set terrain "Mountain"]
  ask flatland [set terrain "Flatland"]

  ;; represents number of units, each one brigade or about 1,000 soldiers
  ; Japan starts 80,000 strong and has only 4,000 reinforcements
  ; Britain starts at only but reaches 120,000 via reinforcements
  set japanese31th 15
  set japanese15th 18
  set japanese33th 18

  ; other forces ?
  let japanese-other 36

  ; japanese reinforcements arrive how (?)

  set british17th 15
  set british20th 15
  set british23rd 15

  set british50th 15
  set british2nd 15
  set british5th 15
  set british7th 15

  ;;set japanese_supplies max_supplies
  ;;set british_supplies max_supplies

  ; Japanese 31st division (the northern group)
  create-turtles japanese31th [
    set tag "Japanese 31st"
    let new-goal randomize-goal patch-japanese-retreat1
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-japanese-retreat1
    set color red
    set shape "circle"
    set size 0.5
    set status "Attack"
    set goal "Kohima"
    set goal-patch patch-midpoint1
    set health 1000
    set team "Japan"
    set supplies japanese_supplies
  ]

  ; create Japanese 15th division (the middle group)
  create-turtles japanese15th [
    set tag "Japanese 15th"
    let new-goal randomize-goal patch-japanese-retreat2
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-japanese-retreat2
    set color red
    set shape "circle"
    set size 0.5
    set status "Attack"
    set goal "Imphal"
    set goal-patch patch-midpoint2
    if goal-patch = 0 [set color yellow]
    set health 1000
    set team "Japan"
    set supplies japanese_supplies
  ]

  ; create Japanese 33rd division (the southern group)
  create-turtles japanese33th [
    set tag "Japanese 33rd"
    let new-goal randomize-goal patch-japanese-retreat3
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-japanese-retreat3
    set color red
    set shape "circle"
    set size 0.5
    set status "Attack"
    set goal "Imphal"
    set goal-patch patch-midpoint3
    set health 1000
    set team "Japan"
    set supplies japanese_supplies
  ]

  ; create Japanese army reserves
  create-turtles 32 [
    set tag "Japanese Reserves"
    set color red
    set shape "circle"
    set size 0.5
    set status "Attack"
    set health 1000
    set team "Japan"
    set supplies japanese_supplies

    ;; assigns reserves to the different attack groups
    ifelse True [
      let new-goal randomize-goal patch-japanese-retreat1
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-japanese-retreat1
      set goal "Kohima"
      set goal-patch patch-midpoint1
    ] [ifelse random 2 = 1
      [
      let new-goal randomize-goal patch-japanese-retreat2
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-japanese-retreat2
      set goal "Imphal"
      set goal-patch patch-midpoint2
      ]
      [
      let new-goal randomize-goal patch-japanese-retreat3
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-japanese-retreat3
      set goal "Imphal"
      set goal-patch patch-midpoint3
      ]
    ]
  ]

  ; create British 17th division units and set starting positions and goals
  create-turtles british17th [
    set tag "British 17th"
    let new-goal randomize-goal patch 6 -12
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-british-retreat2
    set color blue
    set shape "square"
    set size 0.5
    set status "Hold"
    set goal "Imphal"
    set goal-patch patch-midpoint3
    set health 1000
    set team "Britain"
    set supplies british_supplies
  ]

  ; create British 20th division units and set starting positions and goals
  create-turtles british20th [
    set tag "British 20th"
    let new-goal randomize-goal patch-midpoint2
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-british-retreat2
    set color blue
    set shape "square"
    set size 0.5
    set status "Hold"
    set goal "Imphal"
    set goal-patch patch-midpoint2
    set health 1000
    set team "Britain"
    set supplies british_supplies
  ]

  ; create British 23rd division units and set starting positions and goals
  create-turtles british23rd [
    set tag "British 23rd"
    let new-goal randomize-goal patch 1 -1
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-british-retreat2
    set color blue
    set shape "square"
    set size 0.5
    set status "Hold"
    set goal "Imphal"
    set goal-patch patch-midpoint2
    set health 1000
    set team "Britain"
    set supplies british_supplies
  ]

  ; create British 50th division units and set starting positions and goals
  create-turtles british50th [
    set tag "British 50th"
    let new-goal randomize-goal patch 5 7
    setxy item 0 new-goal item 1 new-goal
    set retreat-patch patch-british-retreat2
    set color blue
    set shape "square"
    set size 0.5
    set status "Hold"
    set goal "Kohima"
    set goal-patch patch-kohima
    set health 1000
    set team "Britain"
    set supplies british_supplies
  ]

  set combat_area 1.5
  reset-ticks
  update-date
end

to-report randomize-goal [target-patch]
  ;; adds some randomness to a target position
  ;; spreads out units, improves visibility, adds realism
  let x 0 let y 0
  ask target-patch [set x pxcor set y pycor]
  set x (x - 1 + random-float 2)
  set y (y - 1 + random-float 2)
  report list x y
end

to reinforcements
  if ticks = 19 [
    ; create British 5th division units
    ; arrive by air March 27th (19th tick)
    create-turtles british5th [
      set tag "British 5th"
      let new-goal randomize-goal patch-british-retreat1
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-british-retreat1
      set color blue
      set shape "square"
      set size 0.5
      set status "Attack"
      set goal "Kohima"
      set goal-patch patch-kohima
      set health 1000
      set team "Britain"
      set supplies british_supplies
    ]
  ]
  if ticks = 43 [
    ; create British 2nd division
    ; arrive in Kohima on April 20th, 43rd tick
    create-turtles british2nd [
      set tag "British 2nd"
      let new-goal randomize-goal patch-british-retreat1
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-british-retreat1
      set color blue
      set shape "square"
      set size 0.5
      set status "Attack"
      set goal "Kohima"
      set goal-patch patch-kohima
      set health 1000
      set team "Britain"
      set supplies british_supplies
    ]
  ]
  if ticks = 59 [
    ; create British 7th division units
    ; arrive on May 6th, 59th tick
    create-turtles british7th [
      set tag "British 7th"
      let new-goal randomize-goal patch-british-retreat1
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-british-retreat1
      set color blue
      set shape "square"
      set size 0.5
      set status "Attack"
      set goal "Kohima"
      set goal-patch patch-kohima
      set health 1000
      set team "Britain"
      set supplies british_supplies
    ]
  ]
  if ticks = 60 [
    ; representing fresh troop replacements for 2nd division
    ; arrives on May 7th, 60th tick
    create-turtles 15 [
      set tag "British Reinforcements"
      let new-goal randomize-goal patch-british-retreat2
      setxy item 0 new-goal item 1 new-goal
      set retreat-patch patch-british-retreat2
      set color blue
      set shape "square"
      set size 0.5
      set status "Attack"
      set goal "Imphal"
      set goal-patch patch-imphal
      set health 1000
      set team "Britain"
      set supplies british_supplies
    ]
  ]
end

to go
  ;; end simulation if either army is completley defeated
  if count turtles with [team = "Japan"] = 0 [set victor "Britain" stop]
  if count turtles with [team = "Britain"] = 0 [set victor "Japan" stop]
  ;;if ticks > 300 [stop]

  ;; end simulation if Japan controls both cities
  if control-imphal = "Japan" and control-kohima ="Japan" [set victor "Japan" stop]

  ask turtles [
    if health <= 0 [die]
    stay-in-bounds

    let myteam team
    let possible_targets (turtles with [team != myteam] in-radius combat_area)

    ; while attacking, units will shoot if a target is nearby
    ; if a target is not nearby, it will instead move towards its goal
    if status = "Attack" [
      ifelse any? possible_targets
      [combat]
      [move-towards-goal]
    ]
    ; while holding units will shoot, but not move
    if status = "Hold" [
      if any? possible_targets
      [combat]
    ]
    ;; while retreating units do not fight
    if status = "Retreat" [ move-towards-goal ]

    ;; these functions change
    ifelse team = "Japan" [ update-goals ] [update-goals-british]

    manage-supplies
    ;; british are regularly resupplied Jay ADDED MAX SUPPLY CONDITION
    if ticks mod 10 = 0 and team = "Britain" and supplies + 10 < 100 [set supplies supplies + 10]
    if ticks mod 10 = 0 and team = "Japan"  and supplies + japanese-resupply-rate < 100 [set supplies supplies + japanese-resupply-rate]
    manage-hunger
  ]

  ;;links are a visual of who attacks who, and only serve visual purposes
  clear-links

  ;;ask (turtles with [initial-strength <= 0] ) [die]
  tick
  update-date
  ;; condition to stop the simulation if all Japanese have retreated
  if count turtles with [team = "Japan"] = count turtles with [
   team = "Japan" and status = "Retreat"] [
    ;;start retreat
    set retreat-time retreat-time + 1
  ]

  ;; this gives the remaining units a chance to retreat before ending the simulation
  if retreat-time > 20 [
    set victor "Britain"
    stop]

  reinforcements
  check-control
end

to stay-in-bounds
   if xcor < min-pxcor + 0.1 [ set xcor min-pxcor + 0.1]
   if xcor > max-pxcor - 0.1 [ set xcor max-pxcor - 0.1]
   if ycor < min-pycor + 0.1 [ set ycor min-pycor + 0.1]
   if ycor > max-pycor - 0.1 [ set ycor max-pycor - 0.1]
end

to face-goal [goal-coordinates]
  face goal-patch
 set heading heading + random 20 - 10
end


to move-towards-goal
  if goal-patch = 0 [set color yellow]

  let myteam team

  let terrain_factor 0
  if pcolor = [227 231 208] [ set terrain_factor 0 ] ;flatland
  if pcolor = [162 192 158] [ set terrain_factor 0.1 ] ;forest
  if pcolor = [199 199 191] [ set terrain_factor 0.2 ] ;mountain
  if pcolor = [133 146 116] [ set terrain_factor 0.4 ] ;mountforest

  ; each speed factor has the max list 0 _ to avoid odd situations where they become negative

  ;; carrying more supplies slows the unit down
  ;; each day of food slows unit done by 0.1 %, a max of 20%
  let supply-speed max list 0.5 (1 - (supplies / 100))
  ;; each day without food lowers speed by 5%, to a max of 20%
  let hunger-speed max list 0 (1 - (hunger / 20) )
  if disable-hunger-penalties [set hunger-speed 1]

  ;; terrain lowers speed by a max of 20%
  let terrain-factor (1 - terrain_factor)

  ;; combine all the speed factors
  let speed 1.5 * terrain-factor * hunger-speed * supply-speed

  ;; set a minimum speed (speed of 0 results in turtles getting stuck)
  set speed max list speed 0.1

  ;; this avoids turtles jumping over their goal, usually avoids behind enemy lines
  set speed min (list speed (distance goal-patch ) )

  face-goal goal
  fd speed
end

to combat
  let myteam team
  let possible_targets (turtles with [team != myteam] in-radius 3.5)
  if any? possible_targets [
    let target (one-of possible_targets)
    create-link-with target [set color black]

    ;; this spreads out turtles in a firing line, avoids too much clumping
    face target
    ifelse random 2 = 1 [left 90] [right 90]
    fd 0.1

    ;; terrain reduces damage (based on terrain of unit receiving the attack)
    let terrain-penalty terrain-damage(target)

    ;; hunger makes combat more difficult
    let hunger-penalty 1
    if not disable-hunger-penalties [
      ;; each day without food will lower damage by 5%, units abandon the fight before this goes negative
      set hunger-penalty (20 - hunger) / 20
    ]

    ;; represents advantages in weapons and training of Japanese forces
    let elite-bonus 1
    if team = "Japan" [set elite-bonus 1.08 ]

    ;; create multiplier for the damage
    let multiplier (terrain-penalty +  hunger-penalty) / 3


    ;; base damage is 18, meaning 18 casualties for a day of combat
    let damage 18 * multiplier * elite-bonus
    set damage round damage

    ;; units taking damage are forced back slightly based on damage
    ;; the /health allows weakened units to be pushed back more easily
    let knockback 5 * damage / health
    set knockback min list knockback 1
      ;; this improves the way combat looks
      ;; allows a superior attacking force to push back defenders

    ;; Divisions are able to capture some supplies from retreating enemies
    let amount 0
    let chance random-float 1
    ;; only British forces drop supplies, historically accurate
    if 2 * chance < knockback and [team] of target = "Britain"[
      ;; target drops 1/10th of supplies its carrying
      ask target [
        ;; for ease of use, we round supply values
        set amount round (supplies / 10)
      ]
    ]
    ;; apply these various effects to the target
    ask target [
      ;;apply supply loss, if any
      set supplies supplies - amount

      ;; apply knockback
      ;; randomness in the direction of knockback keeps agents in formation
      face retreat-patch
      set heading heading + 180 + random 10 - 5
      ;; without knockback both armies end up on a single point
      back knockback

      ;; store damage as casualties for data purposes
      if team = "Japan" [set japan-casualties-combat japan-casualties-combat + damage]
      if team = "Britain" [set britain-casualties-combat britain-casualties-combat + damage]


      ;; apply the damage, killing if necessary
      set health health - damage
      if health <= 0 [
        ;; if a unit is defeated, all of its supplies are scavenged
        set amount supplies
        die]

    ]
    ;; adds any supplies captured to the attacking unit JAY ADDED max amount
    if supplies + amount <= 100 [set supplies supplies + amount]


  ]
end

;; combat sub-function
to-report terrain-damage [target]
  let t 1
  ask target [set t patch-here ]
  ask t [set t terrain]

  if t = "Flatland" [report 1]  ;white flatland
  if t  = "Forest" [report 0.9]  ;light green forest
  if t = "Mountain" [report 0.8]  ;purple mountain
  if t  = "MountForest" [report 0.6]  ;dark green mountforest
  report 1
end

to manage-supplies
  ;; adding rationing logic, units eat less when supplies are low
  ;; this slows down the effects of hunger
  ;; when supplies are high, eat 3 meals a day
  if supplies > 7 [
    set supplies supplies - 1
  ]
  ;; units plan ahead, begin rationing when supplies look low
  ;; this represents eating two meals a day
  if supplies <= 7 and supplies > 3 [
    set supplies supplies - ( 2 / 3)
    ;set hunger hunger
  ]
  ;; when supplies are very low, units eat just one meal a day
  if supplies <= 3 and supplies > 0 [
    set supplies supplies - ( 1 / 3)
    set hunger hunger + (2 / 3)
  ]
  if supplies <= 0
  [ set hunger hunger + 1]
end

to manage-hunger
  ;; after effectively skipping 3 days worth of food, casualties start to occur
  if hunger >= 3 and not disable-hunger-penalties [
    let damage-starvation floor (health * 0.01)
    set health health - damage-starvation
    if team = "Japan" [ set japan-casualties-hunger japan-casualties-hunger + damage-starvation ]
    if team = "Britain" [set britain-casualties-hunger britain-casualties-hunger + damage-starvation]
    if health <= 0 [die]
  ]
  ;; after two weeks of missing meals the unit just quits
  if hunger >= 14 and not disable-hunger-penalties
  [set status "Retreat"]
end


to update-goals
  let myteam team
  ;; when arriving at a midpoint, change goal to intended city
  if patch-here = patch-midpoint1   [set goal-patch patch-kohima]
  if patch-here = patch-midpoint2   [set goal-patch patch-imphal]
  if patch-here = patch-midpoint3   [set goal-patch patch-imphal]

  ;; if "Retreat" (meaning hunger was too high), divisions gives up
  if status = "Retreat" [ set goal-patch retreat-patch ]

  ;; after capturing either city, change goal to the other one
  if patch-here = patch-imphal and
  count turtles with [team != myteam] in-radius 3 * combat_area < 1
  [set goal-patch patch-kohima]

  if patch-here = patch-kohima and
  count turtles with [team != myteam] in-radius 3 * combat_area < 1
  [set goal-patch patch-imphal]
end

to update-goals-british
  ;; first wave of retreating
  if ticks = 5 and tag = "British 17th" [
    ;;set color yellow
    set goal-patch patch-midpoint3
    set status "Retreat"
  ]
  if ticks = 5 and tag = "British 23rd" [
    ;;set color yellow
    set goal-patch patch-midpoint2
    set status "Retreat"
  ]
  if ticks = 8 and tag = "British 20th" [
    set goal-patch patch-midpoint2
    set status "Retreat"
  ]

  ;; second wave of retreating
  if ticks = 15 and tag = "British 17th" [
    ;;set color yellow
    set goal-patch patch-imphal
    set status "Retreat"
  ]
  if ticks = 15 and tag = "British 20th" [
    set goal-patch patch-imphal
    set status "Retreat"
  ]
  if ticks = 16 and tag = "British 50th" [
    set goal-patch patch-kohima
    set status "Retreat"
  ]
  if ticks = 16 and tag = "British 23rd" [
    set goal-patch patch-imphal
    set status "Retreat"
  ]

  ;; get British units to stop retreating and hold their ground
  if patch-here = patch-kohima [
    set status "Attack"
    ;; randomness spreads out the turtles, avoids clumping
    set heading random 360
    fd random-float 1
    set goal-patch patch-kohima]
  if patch-here = patch-imphal [
    set status "Attack"
    set heading random 360
    fd random-float 1
    set goal-patch patch-imphal
  ]

  ;; this represents the british retreating if they are losing
  ;; losing condition is British casualties reaching 20%
  if britain-casualties-combat > 2 and False
  [
    set status "Retreat"
    ifelse (distance patch-british-retreat1 < distance patch-british-retreat2)
    [set goal-patch patch-british-retreat1]
    [set goal-patch patch-british-retreat2]

  ]
end

to update-date
  set month time:get "month" date
  if month = 1 [set month "January"]
  if month = 2 [set month "February"]
  if month = 3 [set month "March"] ;23 days from 8th till end
  if month = 4 [set month "April"] ;30 days
  if month = 5 [set month "May"] ; 31 days
  if month = 6 [set month "June"] ; 30 days
  ; historical end date was July 18th, a total of 132 ticks
  if month = 7 [set month "July"] ; 31 days
  if month = 8 [set month "August"] ;
  if month = 9 [set month "September"] ;
  if month = 10 [set month "October"] ;
  if month = 11 [set month "November"] ;
  if month = 12 [set month "December"] ;

end

to check-control
  ;; change control of imphal if Japan has more units in the city than Britain
  if count turtles with [team = "Japan" and patch-here = patch-imphal] > 0 and count turtles with [team = "Britain" and patch-here = patch-imphal] = 0
  [set control-imphal "Japan" ]

  ;; change control of imphal if Japan has more units in the city than Britain
  if count turtles with [team = "Japan" and patch-here = patch-kohima] > 0 and count turtles with [team = "Britain" and patch-here = patch-kohima] = 0
  [set control-kohima "Japan" ]

  ;; same triggers, but in case the British retake them
  ;; change control of imphal if Japan has more units in the city than Britain
  if count turtles with [team = "Britain" and patch-here = patch-imphal] > 0 and count turtles with [team = "Japan" and patch-here = patch-imphal] = 0
  [set control-imphal "Britain" ]

  ;; change control of imphal if Japan has more units in the city than Britain
  if count turtles with [team = "Britain" and patch-here = patch-kohima] > 0 and count turtles with [team = "Japan" and patch-here = patch-kohima] = 0
  [set control-kohima "Britain" ]

end
@#$#@#$#@
GRAPHICS-WINDOW
300
13
638
352
-1
-1
10.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
9
13
143
46
initial_setup
initial_setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
9
327
133
372
Japanese Battalions
count turtles with [team = \"Japan\"]
17
1
11

BUTTON
147
13
279
46
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
137
327
264
372
British Battalions
count turtles with [team = \"Britain\"]
17
1
11

SLIDER
147
51
279
84
british_supplies
british_supplies
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
10
51
141
84
japanese_supplies
japanese_supplies
0
100
100.0
1
1
NIL
HORIZONTAL

PLOT
7
129
275
323
Count of Troops
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -13345367 true "" "plot sum [health] of turtles  with [team = \"Britain\"]"
"pen-1" 1.0 0 -2674135 true "" "plot sum [health] of turtles  with [team = \"Japan\"]"

MONITOR
7
425
190
470
British Avg Troops per Battalion
mean [health] of turtles with [team = \"Britain\"]
4
1
11

MONITOR
7
379
188
424
Japanese Avg Troops per Battalion
mean [health] of turtles with [team = \"Japan\"]
4
1
11

MONITOR
360
356
427
401
Month
month
17
1
11

MONITOR
641
371
851
416
Average Supplies of Japanese Battalions
mean [supplies] of turtles with [team = \"Japan\"]
17
1
11

MONITOR
640
420
850
465
Average Hunger of Japanese Divisions
mean [hunger] of turtles with [team = \"Japan\"]
17
1
11

MONITOR
860
421
1047
466
Average Hunger of British Battalions
mean [hunger] of turtles with [team = \"Britain\"]
17
1
11

MONITOR
432
356
490
401
Date
time:get \"day\" date
17
1
11

MONITOR
300
355
358
400
Year
time:get \"year\" date
17
1
11

PLOT
643
13
843
163
Casualties (Combat)
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot japan-casualties-combat"
"pen-1" 1.0 0 -14070903 true "" "plot britain-casualties-combat"

PLOT
846
13
1046
163
Casualties (Starvation)
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot japan-casualties-hunger\n"
"pen-1" 1.0 0 -14070903 true "" "plot britain-casualties-hunger"

MONITOR
644
310
824
355
Japan % Casualties from Combat
100 * (japan-casualties-combat) / (japan-casualties-combat + japan-casualties-hunger)
17
1
11

MONITOR
846
314
1044
359
Britain % Casualties from Combat
100 * (britain-casualties-combat) / (britain-casualties-combat + britain-casualties-hunger)
17
1
11

SWITCH
8
474
198
507
disable-hunger-penalties
disable-hunger-penalties
1
1
-1000

MONITOR
201
402
298
447
Control of Imphal
control-imphal
17
1
11

MONITOR
201
449
298
494
Control of Kohima
control-kohima
17
1
11

MONITOR
644
262
826
307
Total Japanese Casualties
japan-casualties-combat + japan-casualties-hunger
17
1
11

MONITOR
846
266
1007
311
Total British Casualties
britain-casualties-combat + britain-casualties-hunger
17
1
11

SLIDER
9
91
181
124
japanese-resupply-rate
japanese-resupply-rate
0
10
10.0
1
1
NIL
HORIZONTAL

MONITOR
860
372
1047
417
Average Supplies of British Battalions
mean [supplies] of turtles with [team = \"Britain\"]
17
1
11

MONITOR
644
166
825
211
Japanese Casualties (Combat)
japan-casualties-combat
17
1
11

MONITOR
644
213
826
258
Japanese Causalties (Starvation)
japan-casualties-hunger
17
1
11

MONITOR
846
167
1008
212
British Casualties (Combat)
britain-casualties-combat
17
1
11

MONITOR
846
216
1008
261
British Casualties (Starvation)
britain-casualties-hunger
17
1
11

MONITOR
300
402
477
447
Japanese Battalions in Imphal
count turtles with [team = \"Japan\" and patch-here = patch-imphal]
17
1
11

MONITOR
456
402
597
447
British Battalions in Imphal
count turtles with [team = \"Britain\" and patch-here = patch-imphal]
17
1
11

MONITOR
457
449
597
494
British Battalions in Kohima
count turtles with [team = \"Britain\" and patch-here = patch-kohima]
17
1
11

MONITOR
300
449
453
494
Japanese Battalions in Kohima
count turtles with [team = \"Japan\" and patch-here = patch-kohima]
17
1
11

MONITOR
495
355
591
400
Victor
victor
17
1
11

BUTTON
191
92
246
125
75
set japanese_supplies 75
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="exp2a" repetitions="100" runMetricsEveryStep="false">
    <setup>initial_setup</setup>
    <go>go</go>
    <metric>britain-casualties-hunger</metric>
    <metric>britain-casualties-combat</metric>
    <metric>japan-casualties-hunger</metric>
    <metric>japan-casualties-combat</metric>
    <metric>control-imphal</metric>
    <metric>control-kohima</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="british_supplies">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="japanese-resupply-rate">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="japanese_supplies">
      <value value="0"/>
      <value value="10"/>
      <value value="25"/>
      <value value="50"/>
      <value value="75"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="disable-hunger-penalties">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="exp2b" repetitions="100" runMetricsEveryStep="false">
    <setup>initial_setup</setup>
    <go>go</go>
    <metric>britain-casualties-hunger</metric>
    <metric>britain-casualties-combat</metric>
    <metric>japan-casualties-hunger</metric>
    <metric>japan-casualties-combat</metric>
    <metric>control-imphal</metric>
    <metric>control-kohima</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="british_supplies">
      <value value="100"/>
    </enumeratedValueSet>
    <steppedValueSet variable="japanese-resupply-rate" first="2" step="2" last="10"/>
    <enumeratedValueSet variable="japanese_supplies">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="disable-hunger-penalties">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="exp2c" repetitions="100" runMetricsEveryStep="false">
    <setup>initial_setup</setup>
    <go>go</go>
    <metric>britain-casualties-hunger</metric>
    <metric>britain-casualties-combat</metric>
    <metric>japan-casualties-hunger</metric>
    <metric>japan-casualties-combat</metric>
    <metric>control-imphal</metric>
    <metric>control-kohima</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="british_supplies">
      <value value="100"/>
    </enumeratedValueSet>
    <steppedValueSet variable="japanese-resupply-rate" first="6" step="2" last="10"/>
    <enumeratedValueSet variable="japanese_supplies">
      <value value="0"/>
      <value value="10"/>
      <value value="25"/>
      <value value="50"/>
      <value value="75"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="disable-hunger-penalties">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="exp3" repetitions="10" runMetricsEveryStep="false">
    <setup>initial_setup</setup>
    <go>go</go>
    <metric>britain-casualties-hunger</metric>
    <metric>britain-casualties-combat</metric>
    <metric>japan-casualties-hunger</metric>
    <metric>japan-casualties-combat</metric>
    <metric>control-imphal</metric>
    <metric>control-kohima</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="british_supplies">
      <value value="100"/>
    </enumeratedValueSet>
    <steppedValueSet variable="japanese-resupply-rate" first="0" step="1" last="10"/>
    <steppedValueSet variable="japanese_supplies" first="0" step="1" last="100"/>
    <enumeratedValueSet variable="disable-hunger-penalties">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="exp1" repetitions="100" runMetricsEveryStep="true">
    <setup>initial_setup</setup>
    <go>go</go>
    <metric>britain-casualties-hunger</metric>
    <metric>britain-casualties-combat</metric>
    <metric>japan-casualties-hunger</metric>
    <metric>japan-casualties-combat</metric>
    <metric>count turtles with [team = "Japan" and status = "Retreat"]</metric>
    <metric>control-imphal</metric>
    <metric>control-kohima</metric>
    <metric>ticks</metric>
    <enumeratedValueSet variable="british_supplies">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="japanese-resupply-rate">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="japanese_supplies">
      <value value="0"/>
      <value value="10"/>
      <value value="25"/>
      <value value="50"/>
      <value value="75"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="disable-hunger-penalties">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
