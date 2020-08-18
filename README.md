<!-- badges: start -->
[![Travis build status](https://travis-ci.com/adigherman/EEGSpectralAnalysis.svg?branch=master)](https://travis-ci.com/adigherman/EEGSpectralAnalysis)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/adigherman/EEGSpectralAnalysis?branch=master&svg=true)](https://ci.appveyor.com/project/adigherman/EEGSpectralAnalysis)
<!-- badges: end -->

# EEGSpectralAnalysis
EEG Spectral Analysis Tools

## Installing the EEGSpectralAnalysis package

You can install `EEGSpectralAnalysis` from github with:
``` {r}
# install.packages("remotes")
remotes::install_github("adigherman/EEGSpectralAnalysis")
```

## Usage Examples

### Read sigals from an EDF file

To retrieve the content of an EDF file we can use the `read_edf()` function:

``` {r}
edf_content <- read_edf('../EDF-samples/3O9_EEG.edf')
> head(edf_content$P5$signal)
[1] -67.66641 -66.75259 -64.19233 -67.28040 -69.98246 -73.58258
```

### Calculate absolute and power spectrum

To calculate absolute and power spectrum as well as estimated and lowest frequencies for an EEG signal we will use the `fft_eeg()` function. The parameters of the function are:

* `eeg_signal` - EEG signal values;
* `sampling_frequency` the EEG signal sampling frequency (default value is 125);
* `max_frequency` which represents maximum sampling frequency (default value is 32).
* `num_seconds_window` the duration of EEG record used for analysis (in seconds) per window

``` {r}
> eeg_signal <- edf_content$P5$signal
> eeg_params <- fft_eeg(eeg_signal)
> str(eeg_params)
List of 6
 $ absolute_spectrum    : num [1:161, 1:129] 1.01e+09 1.48e+09 8.06e+08 6.01e+08 1.02e+09 ...
 $ power_spectrum       : num [1:161, 1:129] 1.03e+18 2.20e+18 6.49e+17 3.61e+17 1.04e+18 ...
 $ estimated_frequencies: num [1:161] 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 ...
 $ lowest_frequency     : num 0.2
 $ num_seconds_window   : num 5
 $ sampling_frequency   : num 125
```

### Calculate absolute and relative band power

To calculate absolute and and relative band power in a defined frequency band we will use the `power_eeg()` function. The parameters of the function are:

* `power_spectrum` -  matrix containing the square of the Fourier coefficients for an EEG data set (returned by the `fft_eeg()` function. Each column corresponds to a 5 second interval window. Each column corresponds to a frequency. Lowest frequency is 1/num_sec_w, typically 0.2Hz;
* `freq_min` - minimum frequency defining the frequency band of interest;
* `freq_max maximum` - maximum frequency defining the frequency band of interest;
* `num_sec_w` - number of seconds in a time window used to obtain the Fourier coefficients. Typically, this number is 5;
* `aggreg_level` - number of 5 second intervals used to aggregate power. Typically, this number is 6 to ensure a 30 second interval window (standard in EEG analysis).

``` {r}
> eeg_signal <- edf_content$P5$signal
> eeg_params <- fft_eeg(eeg_signal)
> power_eeg_params <- power_eeg(eeg_params$power_spectrum)
> str(power_eeg_params)
List of 4
 $ absolute_band_power : num [1:129] 1.89e+18 1.75e+19 2.83e+18 5.94e+19 9.25e+17 ...
 $ absolute_band_aggreg: num [1:21] 1.39e+19 1.80e+18 1.35e+18 1.42e+18 2.56e+18 ...
 $ relative_band_power : num [1:129] 0.285 0.038 0.446 0.186 0.293 ...
 $ relative_band_aggreg: num [1:21] 0.286 0.547 0.482 0.341 0.441 ...
 ```
 
### Calculate Aggregated Power Levels for EEG bands
 
 To calculate the aggregated power levels for each EEG band (Delta < 4, Theta ≥ 4 and < 8, Alpha ≥ 8 and < 14, Beta ≥ 14 and < 32 and Gamma ≥ 32 and < 50) we will use the `power_eef_bands` function.
``` {r}
 > power_eeg_bands(eeg_signal, sampling_frequency = 500, max_frequency = 50, num_sec_w = 6, aggreg_level = 27)
$Delta
[1] 1.077034e+20

$Theta
[1] 1.169681e+19

$Alpha
[1] 2.241449e+19

$Beta
[1] 3.248094e+18

$Gamma
[1] 1.899383e+18
```