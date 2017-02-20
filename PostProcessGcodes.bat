::Post Processor for Flatcam gcode to MPCNC

::Install
::Sed.exe from http://gnuwin32.sourceforge.net/packages/sed.htm

::Either add the sed path to windows PATH (restart) 
::or supply the path in the loop bellow ("C:\Program Files (x86)\GnuWin32\bin\sed.exe")

::Define speeds in XY and Z direction
SET XYspeed=F70
SET FastXYspeed=F1000

SET Zspeed=F20
SET FastZspeed=F100

::Set current directory to subfolder with gcodes: 
cd PostProcess

::Loop through all files in that folder and make the adjustments
for /r %%f in (*) do (
	"C:\Program Files (x86)\GnuWin32\bin\Sed.exe" -e^
       "s/G01 Z/G1 %Zspeed% Z/"^
		-e "s/G00 Z/G1 %FastZspeed% Z/"^
		-e "s/G01/G1 %xyspeed%/"^
		-e "s/G00/G1 %FastXYspeed%/"^
		-e "s/\([0-9]\)Y/\1 Y/g"^
		-e "s/G21/M84 S1800 ;Change Stepper disable timeout to 30 minutes/"^
		-e "s/G90/G90 ;Absolute coordinates/"^
		-e "s/G94/G1 %FastZspeed% Z0.2500 ;Drop Z to near surface (fast)/"^
		-e "s/M03//"^
		-e "s/G4 P1//"^
		-e "s/M05/G1 %FastZspeed% Z30 ;Rise Z to 30mm (fast)/"^
		<%%f>%%f_MPCNC.gcode
		
	move "%%f_MPCNC.gcode" "%~dp0"
)

::pause