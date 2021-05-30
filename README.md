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
<h3> 5/26/2021 </h3>
- Cameron - Wrote cursor class, wrote render method for map, wrote displayRange method, wrote move method, wrote loadMap method
<h3> 5/27/2021 </h3>
- Ivan - Introduce map scrolling and aligned cursor with it <br>
- Cameron - Aligned units to scrolling, implemented better displayRange() method with actual checks, wrote menuOption() and menuCursor() classes, imported some more graphics, improved displayRange() to also support attack range checks (not fully done yet).
<h3> 5/28/2021 </h3>
- Cameron - finished displayRange(), implemented methods to allow you to attack, added unit damage chart/table, added damage formula for calcPower() method.
<h3> 5/29/2021 </h3>
- Ivan - Hopefully created final fixes to map scrolling, created an animated battle preview, expanded the testing map, added the Advance Wars font and imported textures for city, horizontal and vertical roads
- Cameron - finally got displayRange() to display the right info, added better movement penalities for different types of units, started work on Captureable class
