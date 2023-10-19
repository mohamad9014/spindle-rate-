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

bottom  figure illustrates   raw data(AD) ,filtered data,start and stop spindle ,and peak spindle 
![3](https://github.com/mohamad9014/spindle-rate-/assets/121359931/b9fd95c1-4368-44d7-a94a-e4a05729a72c)

Then I separated NREM,REM,WAKE and displayed peak spindles for each of them.Representative spatiotemporal distribution of spindles across the vigilance states.  Hypnogram is depicted below.
![1](https://github.com/mohamad9014/spindle-rate-/assets/121359931/ce0ef7c3-e15a-4c4c-a7ea-c4d6f2d07368)








