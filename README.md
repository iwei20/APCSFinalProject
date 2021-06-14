# APCSFinalProject
Processing Wars - https://docs.google.com/document/d/1jCxJlMErQpc8d1ON0SRkjM86jRKr0KJYfQS17Rnp_Hk/edit?usp=sharing
<br><hr><br>
A version of the GBA game Advance Wars using Processing. Advance Wars is a turn-based tile strategy game where two commanders duke it out in a fight.
<br>
Controls are WASD to move the cursor, I to select unit/action and U to go back (think of it as U = b button, I = a button)
<br><hr>
## Changelog
### 5/25/2021
- Ivan - Created initial project, copied all classes from UML, and created skeletons for Map, Tile, TileSubobject
- Cameron - created graphics for units, wrote Sprite and Terrain classes and started work on Unit class 
### 5/26/2021
- Cameron - Wrote cursor class, wrote render method for map, wrote displayRange method, wrote move method, wrote loadMap method
### 5/27/2021
- Ivan - Introduce map scrolling and aligned cursor with it
- Cameron - Aligned units to scrolling, implemented better displayRange() method with actual checks, wrote menuOption() and menuCursor() classes, imported some more graphics, improved displayRange() to also support attack range checks (not fully done yet).
### 5/28/2021
- Cameron - finished displayRange(), implemented methods to allow you to attack, added unit damage chart/table, added damage formula for calcPower() method.
### 5/29/2021
- Ivan - Hopefully created final fixes to map scrolling, created an animated battle preview, expanded the testing map, added the Advance Wars font and imported textures for city, horizontal and vertical roads
- Cameron - finally got displayRange() to display the right info, added better movement penalities for different types of units, started work on Captureable class
### 5/30/2021
- Cameron - worked on Captureable class, created new graphics as well.
### 5/31/2021
- Cameron - created new map, made it so that vehicules cant run over other units, changed how movment works otherwise to be closer to the game, made turn number and player appear at the beginning of each turn.
### 6/1/2021
- Ivan - Started work on creating ProductionMenu and rendering it
- Cameron - created HQ graphics and made player win if its captured
### 6/3/2021
- Ivan - Adjusted ProductionMenu appearance, and connected all proper inputs to allow for opening the menu and spawning units. Implemented money system.
- Cameron - created Base/Factory graphics, fixed bug to only allow base selection if it is on that side.
### 6/4/2021
- Ivan - Turn indicator is now permanent and switches sides based on cursor position, also recolored production menu
### 6/8/2021
- Ivan - Spent extra time adding road/coast variations to prepare for sprite variations
- Cameron - Created proper victory screen, added icons for all teams, Made player icon show player money if they control a base
### 6/10/2021
- Ivan - Quickly implement sub-sprite variations and tested it with a water edge tile
- Cameron - Created entire main selection menu and graphics, started code for transport units
### 6/12/2021
- Cameron - implemented loading and dropping units 
### 6/13/2021
- Cameron - updated maps to include nicer water and road tiles
### 6/14/2021
- Ivan - Add all port textures, implement all port types and have all units, implement production scrolling, add an airport to Volcano Island