# Tend & Defend #

## Summary ##

Tend & Defend is an endless Tower Defense game with action-packed gameplay, precise economy control, and a variety of
threatening enemies. The goal of this game is to survive an endless number of enemies who come in rounds, increasing in
difficulty per wave. To accomplish this, the player has two defense mechanisms to manipulate; towers and a moveable
character. 

## Project Resources

[Web-playable version of your game.](https://itch.io/)  
[Trailer](https://youtube.com)  
[Press Kit](https://dopresskit.com/)  
[Proposal](https://docs.google.com/document/d/1gyG7b2Upl4-9ODWC7Yq1yP8rd9siS_M9wfrzslGFUY8/edit?usp=sharing)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**


**Game Explanation**

 There are two main components of Tend & Defend, the towers and the player. Towers: During waves of enemies, towers will attack enemies on the lane of which the tower resides on. They shoot a projectile which will do a certain amount of damage each bullet, at a specific frequency and range. During the buy phase,
Towers may be upgraded with currency to specialize in either power, frequency, or range. If the tower is damaged to an extent
by enemies, it will fall for that round, resetting to base statistics for the next round. Next the player-controlled character: A free-roaming character will exist on the battlefield, capable of jumping between lanes and attacking enemies. The player itself will have a health bar and can fall in battle with enemies, to respawn with base statistics for the next round. The character may be upgraded through rounds to upgrade its damage. This is done by selecting 1 of 3 weapons; a hammer, a badminton racket, or an iron steel rod. 

**Button Mappings**

Movement for the player can be done either using WASD or the arrow keys. Attack is done by pressing the enter key or left mouse button. During the buy phase selecting a tower type can be done by clicking the button for your selected tower and then pressing the confirm button at the end of the lane. Upgrading the tower stats can be done by simply clicking the upgrade button that appears after selecting a tower type.

**Suggested Strategy**

Focus on range or power turrets first rather than frequency and make use of the ability to spam click upgrades for the towers. The player character is very useful for helping out weaker lanes or lanes that receive bad enemy RNG.

**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

# Main Roles #

## Game Logic (Simon Yoo) ##
As the game logician, here is a list of the systems I implemented:  
* Object Factories and Specs
* Dynamic Wave Managing/Wave Difficulty Management
* Autoloaded Global Scripts/Scenes
* Scene Switching
* Buy Phase Logic
* Upgrading Turrets and Turret Stats
* Signaling for Audio

As the game logician, I decided how the different data we needed to run the game was stored and shared across scenes and objects.  
  
*I utilized autoloaded globals* - I utilized autoloaded globals to store variables and information in a way that the different scripts could use for keeping a consistent game state. I used the [global_vars.gd](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/global_vars.gd#L1) script as the main place to store variables I knew would need to be global in order to have them persist across scenes. Within it, I kept variables that were attributed to player stats, such as currency, score, health, etc. I also added some global variables for wave generation logic. I had a [turret_type](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_type.gd#L1) script that was also autoloaded and global. This one kept track of all the turret stats so that turret stats could be updated in the buy phase and rebuilt using said stats/arrays when returning to the waves.

*I used the factory pattern for generating turrets, projectiles, and enemies.* - Just like in exercise 3, I utilzed [spec scripts](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_spec.gd#L1) and [factory scripts](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_factory.gd#L1) that had [build functions](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_factory.gd#L12) in order to build differnt types of the same object. This allowed us to have different turrets with varying stats that we could upgrade. It also allowed for different projectile types coming from those turrets and different enemy types as well.

*I implemented the different phases of the game and how to switch between them.* - I created a [global scene switcher](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/scene_switch.gd#L1) that was created using [this tutorial](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html#custom-scene-switcher) from the Godot Docs. I have the scene switcher switch to the buy phase after every enemy is defeated or dead, and I have it switch back after the buy phase timer runs out.

*I implemented a wave manager script.* - I created a [wave_manager.gd](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/waves_manager.gd#L1) script. This is one of the main game managers for the stage1 scene. This script builds all the turrets based on the global variables storing turret stats in [turret_type.gd](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_type.gd#L1). It also creates the variables necessary to store enemy generation and then generates those enemies. It decides which enemies and how many to spawn based on algorithms found in functions like [calc_num_to_spawn](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/waves_manager.gd#L145), [create_enemy_schedule](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/waves_manager.gd#L63), and [spawn_enemies](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/waves_manager.gd#L111).

*I implemented the buy phase for upgrading* - I created a buy phase scene that runs off of the [buy_phase.gd](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/buy_phase.gd#L1) script. This has many button elements that change the values in arrays found in [turret_type.gd](https://github.com/varun22/ECS179-FinalProject/blob/df5385c29f3f817d47d4cd4c57156d99dfee79ae/tend%26defend/scripts/turret_type.gd#L1) which is an autoloaded global script. This allows the player to upgrade turrets and player features with the click of those buttons. The changes will then be implemented using the [rebuild](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/turret_factory.gd#L22) function in the turret factory.

## Producer

**Describe the steps you took in your role as producer. Typical items include group scheduling mechanisms, links to meeting notes, descriptions of team logistics problems with their resolution, project organization tools (e.g., timelines, dependency/task tracking, Gantt charts, etc.), and repository management methodology.**

Early in the game's creation, I offered feedback on how gameplay systems could work as well as creating a [dependency map](https://lucid.app/lucidchart/38c5f6f2-af6c-4aaf-9f01-ea6828f57e6b/edit?viewport_loc=-1254%2C-387%2C3462%2C1784%2C0_0&invitationId=inv_ba75bc30-26f2-42a9-93a5-5e81a859d64b) for the major code files. I kept track of important due dates for the project and insured everyone was aware of what they had to do for things like the progress report and organized a meeting so we could finalize game progress ahead of our presentation and took [notes](https://docs.google.com/document/d/1504CdvgLSkfjD5s2aA8LvRw1AbyOrO5VQlXhDs5T7SM/edit?usp=sharing). I also stepped in to help other roles when they were busy with other gameplay systems by using the assets made by our animator and importing and creating all the animations in godot. As well as doing large portions of documents such as the progress report and parts of this document as well.

## User Interface and Input

**Describe your user interface and how it relates to gameplay. This can be done via the template.**
**Describe the default input configuration.**

**Add an entry for each platform or input style your project supports.**

## Movement/Physics

**Describe the basics of movement and physics in your game. Is it the standard physics model? What did you change or modify? Did you make your movement scripts that do not use the physics system?**

## Animation and Visuals

**List your assets, including their sources and licenses.**

All assets are custom sprites created to fit the unique asks of each game mechanic including the tower upgrade animations, death animations, weapon upgrade animations, custom enemy animations, title screen, game over screen, game field & towers.

**Describe how your work intersects with game feel, graphic design, and world-building. Include your visual style guide if one exists.**

Creating different custom animations such as the turret animations add polish and help improve the game feel of the game. The 2d-pixel art style contributes to helping tie the entire game together by standardizing all the assets. 

## Game Logic

**Document the game states and game data you managed and the design patterns you used to complete your task.**

# Sub-Roles

## Audio

**List your assets, including their sources and licenses.**  
All sound effects were found within [this free, online library: Pixabay.](https://pixabay.com/sound-effects/search/library/)  
All music was created by Simon Gooden.

**Describe the implementation of your audio system.**  
The audio was implemented through a [sound_manager.gd](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/sound_manager.gd#L1) script attached to a node that is parent to audioStreamPlayer2d nodes, each loaded with an individual sound. I then use signals from [signals.gd](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/signals.gd#L1) which is autoloaded global to decide when to play the sounds. I added a signal connection for each signal in the sound_manager script that just links to a function that has the audioplayer play the sound. [Here is an example of one of my calls for a sound to be played through signals.](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/player.gd#L117) [Here is the signal.](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/signals.gd#L9) [Here is the function in sound_manager.gd.](https://github.com/varun22/ECS179-FinalProject/blob/db38ff435ec8f4510de542aca470792466931935/tend%26defend/scripts/sound_manager.gd#L35). I took inspiration from the sound manager from exercise 3.

**Document the sound style.**  
The sound style consists of simplistic sounds mainly for the purpose of communicating an interaction to the user.

## Gameplay Testing

**Add a link to the full results of your gameplay tests.**

[Playtester Feedback](https://docs.google.com/document/d/1LpOJOBH7_QBpGSa18CgOnpX9Q-sSwfqE5ZRHqFvY6oU/edit?usp=sharing)

**Summarize the key findings from your gameplay tests.**

The playtests were all done on an earlier unfinished branch of the game so there were lots of concerns about bugs with the player to enemy interactions as well as how health worked in the game. There was also a lot of confusion about why the player attack were bound to enter which is not a key most people intuitively tried to attack with. Some people really enjoyed the music while other found it too repetitive after a while but everyone liked the animations/assets. For further improvements people suggested an increased level of difficulty, character customization, and adding more variety of enemies, weapons, and maps.

## Narrative Design

**Document how the narrative is present in the game via assets, gameplay systems, and gameplay.** 

## Press Kit and Trailer

**Include links to your presskit materials and trailer.**

**Describe how you showcased your work. How did you choose what to show in the trailer? Why did you choose your screenshots?**

## Game Feel and Polish

**Document what you added to and how you tweaked your game to improve its game feel.**

I was apart of testing process to review and advise on game mechanics: towers, upgrades, placement. Conversed with team to formulate programmable ideas for each mechanic to keep on the same page with all game design choices.

