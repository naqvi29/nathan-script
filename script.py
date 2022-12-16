import os
import wave

# folder path
input_dir = 'input_wav_files' 
output_dir = 'output_wav_files'

# list to store all filenames in input directory
res = []

# Iterate directory
for path in os.listdir(input_dir):
    # check if current path is a file
    if os.path.isfile(os.path.join(input_dir, path)):
        res.append(os.path.join(input_dir, path))
print(res)



# infiles = ["wav_files/sil1.wav", "wav_files/sil2.wav"]
infiles = res

data= []
for infile in infiles:
    
    w = wave.open(infile, 'rb')
    data.append( [w.getparams(), w.readframes(w.getnframes())] )
    w.close()
    x = infile.replace("input","output")
    
    output = wave.open(os.path.join(x), 'wb')
    output.setparams(data[0][0])
    for i in range(len(data)):
        output.writeframes(data[i][1])
    output.close()
