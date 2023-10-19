# sleep-spindle-rate-
Determination of spindles rate  during N2W(NREM before WAKE) and N2R(NREM before REM)
# sleep spindle detection : 
firstly , Anterodorsal (AD) signal was first band pass filtered in the spindle frequency range (9-16) Hz for both slow and fast spindles using finite-impulse-response (FIR) 
filters from the EEGLAB toolbox and in more detail with eegfilt  ( FIR band-pass filter, filter order corresponds to 3 cycles of the low frequency cut off). 
Hilbert transform was used to compute instantaneous amplitude which was then smoothened using a 300 ms Gaussian window.
Then we use FMA toolbox to detect the spindle which detects 4 factors for each spindle :
a) start time
b)peak spindle
c) stop time
d) z-score
And we consider the time peak as the spindle
Periods  with amplitude larger than 3 SD(standard division ) for a duration greater than 0.5 s and lower than 3 s were selected as spindle events. Two nearby events were merged if they were closer than 0.5 s. 
Important point : We separated the data related to NREM And gave them to the filter input




