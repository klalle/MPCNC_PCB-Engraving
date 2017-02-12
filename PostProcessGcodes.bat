::Post Processor for Flatcam gcode to MPCNC

::Install
::Sed.exe from http://gnuwin32.sourceforge.net/packages/sed.htm

::Either add the sed path to windows PATH (restart) 
::or supply the path in the loop bellow ("C:\Program Files (x86)\GnuWin32\bin\sed.exe")

::Change to subfolder: 
cd PostProcess

::Loop through all files in that folder and make the adjustments
for /r %%f in (*) do (
	"C:\Program Files (x86)\GnuWin32\bin\Sed.exe" -e "s/G01 Z/G1 F60 Z/"^
		-e "s/G01/G1 F450/"^
		-e "s/G00 Z/G1 F50 Z/"^
		-e "s/G00/G1 F1000/"^
		-e "s/\([0-9]\)Y/\1 Y/g"^
		-e "s/G21/M84 S1800 ;Change Stepper disable timeout to 30 minutes/"^
		-e "s/G90/G90 ;Absolute coordinates/"^
		-e "s/G94/G1 F200 Z0.2500/"^
		-e "s/M03//"^
		-e "s/G4 P1//"^
		-e "s/M05/G1 F200 Z30 ;Z to 30mm/"^
		<%%f>%%f_MPCNC.gcode
		
	move "%%f_MPCNC.gcode" "%~dp0"
)
:: G01 Z... => G1 F60 Z... 
:: G01 ...  => G1 F600 ... G1 F200 Z0.5000
:: G00 Z... => G1 F60 Z...
:: G00 ...	=> G1 F2000 ...
:: Space before "Y"
:: Remove G21, M03, G4 P1, M05, F17.50, G94
:: Add comment on G90 and M84- absolut coordinates and disable timeout to 30min!

::pause