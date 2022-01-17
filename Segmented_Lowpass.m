% Developed by Aaron Lozhkin 01/16/22
% Executes a lowpass over a 50 index window forward and backwards from every detected peak. 
% Must be 1 channel (either left or right) audio. 
% Use in conjunction with 'Lowpass_CanAm2021.m' for best results.
function [f] = Segmented_Lowpass(y, Fs, fpass)

[pks, index] = findpeaks(y, 'MinPeakHeight', 0.06, 'MinPeakDistance', 0.0037 * length(y)); 

y_filtered = y;
margin = 50;

for n = 1 : length(pks)
    
    temp = y(index(n)-margin:index(n)+margin);
    
    temp_filtered = lowpass(temp, fpass, Fs);
    
    y_filtered(index(n)-margin:index(n)+margin) = temp_filtered;
end

f = y_filtered;
end
