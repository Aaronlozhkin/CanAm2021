#Developed and Utilized by Aaron Lozhkin 01/09/22 - Python 3.7.3
#Scrapes the CanAm 2021 CON folders and converts the trimmed artery videos from .mp4 to .avi with attention to audio (9216 kbit/s)
#Notice you must have ffmpeg installed and declared as an environmental variables in path for propoer functionality
#ffmpeg download: https://www.ffmpeg.org/download.html

import os, glob
import shutil

#Configuration Variables:
temp_Path = "C:/Users/Aaron/Documents/IHPL/temp"      #temporary local folder where the files will be stored and converted
source_Path = '//nwnjmsfs01.core.umdnj.edu/NJMS/Pharm/Serrador_Lab/STUDIES/STUDY Concussion/CanAm 2021'
#Specify the range here for specific CON folders using start & end
start = 267
end = 299


def convert(source_Path, temp_Path):
    os.chdir(source_Path)
    for file in glob.glob("*.mp4"):
                name = os.path.splitext(str(file))[0]
                shutil.copyfile(source_Path + '/' + str(file), temp_Path + '/' + str(file))
                os.chdir(temp_Path)
                os.system('ffmpeg -i ' + str(file) + ' -b:a 9216k ' + name + '_Conv.avi')
                shutil.copyfile(temp_Path + '/' + name + '_Conv.avi', source_Path + '/' + name + '_Conv.avi')
                os.remove(str(file))
                os.remove(name + '_Conv.avi')

for it in os.scandir(source_Path):
    if it.is_dir() and ('CON' in it.name):
        name = it.name
        if int(name[3:6]) >= start and int(name[3:6]) <= end:
            for j in os.scandir(it.path):
                if (j.is_dir()):
                    if ('Seated CCA' in j.name):
                        s = str(it.path) + '/Seated CCA'
                        convert(s, temp_Path)
                    if ('Seated ICA' in j.name):
                        s = str(it.path) + '/Seated ICA'
                        convert(s, temp_Path)
                    if ('Supine CCA' in j.name):
                        s = str(it.path) + '/Supine CCA'
                        convert(s, temp_Path)
                    if ('Supine ICA' in j.name):
                        s = str(it.path) + '/Supine ICA'
                        convert(s, temp_Path)