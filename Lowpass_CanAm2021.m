%Developed and Created by Aaron Lozhkin 01/16/2022
%This script is designed to read in video/audio data and execute a segmented lowpass
%filter based on false peaks in the data. The file you would like to filter must be in the matlab path
%above. The script will save the file in the same path appending '_Low' to
%the end.

clear;
close all;

[FileName, FilePath] = uigetfile('*.mp4;*.mp3;*.avi;*.wav;*.wma');
[y, Fs] = audioread(FileName);

y_left = y(:,1);
y_right = y(:,2);

% Execute Segmented Lowpass
y_filtered = [Segmented_Lowpass(y_left, Fs, 100) Segmented_Lowpass(y_right, Fs, 100)];

% Repeat the same for the negative
y_filtered_negative = -y_filtered;
y_filtered2_negative = [Segmented_Lowpass(y_filtered_negative(:,1), Fs, 100) Segmented_Lowpass(y_filtered_negative(:,2), Fs, 100)];

% Store Filtered data in new variable
y_final = -y_filtered2_negative;

set(0,'units','pixels')  ;
pix = get(0,'screensize');
screen_Width = pix(3);
screen_Height = pix(4);

f = figure;
f.Position = [100 100 (0.35 * screen_Width) (0.65*screen_Height)];
subplot(3,1,1);
plot(y);
title('Original');

subplot(3,1,2);
plot(y_final);
title('Filtered');

subplot(3,1,3);
plot(y_final - y);
title('Subtracted');

dlgTitle    = 'Lowpass';
dlgQuestion = 'Do you wish to write this filtered data?';
choice = questdlg(dlgQuestion,dlgTitle,'Yes','No', 'No');

if strcmpi(choice, 'Yes')
    [pathstr,name,ext] = fileparts(FileName);
    audiowrite(strcat(name, '_Low', ext), y_final, Fs)
end