# CanAm2021
My work as a research assistant for the CanAm research project in 2021 & 2022. These scripts resulted in a 15% increase in usable data for the study.

### Script Descriptions:

**lowpassCanAm.m** Takes corrupted ultrasound audio files and applies a custom lowpass filter to remove regularly stated anomalies in the signal.

**segmentedLowpass.m** Custom lowpass filter that identifies peak anomalies in signal data, creates an interval around them, and applies en extremely intense lowpass filter to those intervals. Results in smoothed out audio data that doesn't have regular audio peaks.

**mp4AviConverterCanAm.py** Takes mp4 files and converts them to avi with an extrememlike high bitrate of 9.216Mhz. Ensures lossless audio conversion, with little regard for video quality.
