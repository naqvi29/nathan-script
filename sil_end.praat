# Praat script Insert silence
# author Daniel Hirst daniel.hirst@...>
# Modified by Zhenghan Qi
# 
# Modified by Danielle Daidone 11/12/17 to add silence at the end of each sound file in a folder
# Files are saved to the directory specified by the user with their original names
################################################################################################

form Insert silence
comment Specify duration of silence (in milliseconds) to be added to end of sound files
positive duration_of_silence 500
comment Specify directory of sound files (don't forget final slash)
sentence inputDir /Users/nathanjyoung/Dropbox/_FA/Lmod/daDK/corp/DP/labprep2/
comment Specify directory where you want to save the finished files (don't forget final slash)
sentence saveDir /Users/nathanjyoung/Dropbox/_FA/Lmod/daDK/corp/DP/lab/

endform

duration_of_silence = duration_of_silence/1000 

Create Strings as file list... list 'inputDir$'*.wav
numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list

   #open sound file	
   fileName$ = Get string... ifile
   Read from file... 'inputDir$''fileName$'
   mySound = selected("Sound")

   #get sampling frequency of sound and create silence based on that
   sampling_frequency = Get sampling frequency
   nb_channels = Get number of channels
   mySilence = Create Sound from formula... silence nb_channels 0 duration_of_silence sampling_frequency 0
   
   #concatenate sound file and silence
   select mySound
   plus mySilence
   myNewSound = Concatenate

   # save concatenated sound to save directory
   select myNewSound
   Write to WAV file... 'saveDir$''fileName$'
   select all
   minus Strings list
   Remove
endfor

select all
Remove

writeInfoLine: "Files successfully created!"