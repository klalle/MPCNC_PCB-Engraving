# Marlin_RC7_LCD_Customization for MPCNC-router
This is a customization of the LCD-menu that's in the Marlin version that's configured to work with an MPCNC from [vicious1.com](http://www.vicious1.com/)<br>
The project version used is the: "RC7_MPCNC_LCD_9916" downloaded from the [Firmware-page](http://www.vicious1.com/marlin-firmware/)<br><br>
[Direct link to project file](http://www.vicious1.com/wp-content/uploads/2015/12/RC7_MPCNC_LCD_9916.zip)

I was going crazy when trying to access the menu objects I needed through the LCD, so I came up with a couple of improvements that customized the menu for me.

####This is what I aimed for:<br>
* Get rid of all junk I don’t use (I’m only using the machine as a CNC-router)
* Reorder the menu to put the mostly used commands on top
* Confirm run function
  * The pot-knob is a bit flaky => I dont want to accedently start to run the wrong file 
* Access the z-probe offset from the LCD-menu
  * The height of the piece of metal I let the tool go down against to probe for z (connected to GND and z-min)
* Make a temporary Z-offset-menu item
  * Useful if e.g. an engraving ends up too shallow – just make a temporary z-offset of -0.5 mm and run the same file again (make sure to not lose X and Y!!)
  * So that you don’t have to alter the z-probe offset all the time (the probe is most likely the same one...!)
* “Go to home” command in menu
* Set current position to home (without offset) menu item
* Make the 2nd option on a submenu pre-selected
  * If I e.g. enter the submenu “Move Axis” from the “Prep-menu”– most likely my next action won’t be to go back to the prep-menu, but to press the first real option (2nd option) 

####And this is my custom menu that I ended up with: <br>
* Startscreen
  * Back
  * Move Axis
    * 0.1mm 
      * Z,X,Y
    * 1mm 
      * Z,X,Y
    * 10mm 
      * X,Y
  * Probe for Z0
    * Zero only Z
    * Zero All
  * Print from SD
    * bla bla bla 
    * Confirmation before it starts to run a file!
  * Go To Home
    * All/X/Y/Z
  * Disable steppers
  * Temp Z offset
  * Speed [%]
  * Z Homing offset 
  * Make this home
  * Store to EEPROM
  * LOAD from EEPROM
  * Control
    * acceleration, jerk, speeds.....

###Read the "README.md"-file in the folder "Files to modify" for explanation on how to try it out yourselves!

<b>Update 19/1-17:</b>
* Added function to set coordinates first - then execute to go to set position
 * Is a bit buggy to wait while the machine moves while turning the knob if I know were I'm heading this is better!
* Move Z or XY first dependent on if Z is bellow or above 0 
 * Affects "homing" and "set coordinates"
* Reset speed to 100% when file is finnished!
 * If I increased the speed during a file print, there was no way of going back to 100% before I start the next print...
* Added Mount/UnMount function to the SD-card 
 * so I dont have to restart when changing the SD-card
* Made the gcode return to X0 and Y0 after finnished file in post-processor 
 * if something fuckes up during e.g. SD-card swap it's good to know we're at X0Y0 -just probe for Z again! 
 
<b> Update 22/1 </b>
* Implimented a confirmation step before a file is started (the pot-knob is a bit flaky..)
