# MPCNC-PCB Milling

I finally tied to mill a custom PCB with my MPCNC, and my CNC did not let me down this time either! =)

I have never routed a PCB before, so this was a first, and I had no idéa of what programs to use, but this is how I did it: 

##Schematics in Eagle 
1. Since this is an one sided copper clad board, I placed all the thrue-hole compoents on the front layer, and the surface mounted ESP-03 on the back layer (mirrored)
2. All the routes where done on the Backside-layer and I used the Auto-routing and dide some touchup manually...
  * Before auto routing I altered the net class: Edit/Net classes... Width: 1 mm, Drill: 1 mm, clearance: 0.5 mm
3. I made a polyline-area that defined the board cut-out on layer 249 (Edge)
4. Exported three files
	*Routes and Cutout with Device: "GERBER_RS274X"
	*Drills/Holes with "EXCELON_24" 
	
##Created gcode with FlatCAM
1. Typed: "set_sys excellon_zeros T" in command-line (white area, bottom of window) to be able to import Eagle-files correctly (done only once)
2. Imported the two gerber-files and the Excelon-file and made sure they lined up
  * Be aware: No foreign letters in path! (all the way from C:/)
3. Followed [this](https://www.inventables.com/projects/how-to-mill-a-through-hole-pcb) guidet to export gcodes
  * Not strictly... 
4. Followed [this](http://caram.cl/software/flatcam/board-cutout-with-flatcam/) guide to make custom board cutout with tabs
5. Exported the files without file-ending (without ".gcode") to the folder called "PostProcess"

##Post Procesor
1. I made a custom post-procesor to match the gcode that the post processor for F360 puts out.
	* It's a bat-script and needs "Sed" to be installed download Sed.exe for windows [here](from http://gnuwin32.sourceforge.net/packages/sed.htm)
	* Just put the bat-file next to the folder "PostProcess" and dubble click the file, it will generate gcode-files of all the files in the folder

##Routing
1. Put the three gcode files on an SD-card and plugged it in to MPCNC
2. Used my custom functions to probe for Z with zero probe offset, used the copper clad as GND instead of probe metal piece...
3. Used a 45 deg V-bit for the engraving (really need to get a new sharp one), 1mm end mill for holes and 1.5mm end mill for cut out

I was really happy that my [custom LCD-menu](https://github.com/klalle/Marlin_RC7_LCD_Customization) did it's job and I made use of a lot of my custom functions! 
