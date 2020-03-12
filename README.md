# EEGSpectralAnalysis
EEG Spectral Analysis Tools

## Installing the EEGSpectralAnalysis package

You can install `EEGSpectralAnalysis` from github with:
``` {r}
# install.packages("remotes")
remotes::install_github("adigherman/EEGSpectralAnalysis")
```

## Usage Examples

### Calculate absolute and power spectrum

To calculate absolute and power spectrum as well as estimated and lowest frequencies for an EEG signal we will use the `fft_eeg()` function. The parameters of the function are:

* `eeg_signal` - EEG signal values;
* `sampling_frequency` the EEG signal sampling frequency (default value is 125);
* `max_frequency` which represents maximum sampling frequency (default value is 32).

``` {r}
> eeg_filepath <- system.file("extdata", "EEG10009_v1.csv.gz", package = "EEGSpectralAnalysis")
> eeg_signal <- read.table(file = eeg_filepath)
> eeg_signal <- eeg_signal$V1
> eeg_params <- fft_eeg(eeg_signal)
> str(eeg_params)
List of 6
 $ absolute_spectrum    : num [1:161, 1:6474] 131 597 763 458 746 ...
 $ power_spectrum       : num [1:161, 1:6474] 17146 356957 582410 209588 557206 ...
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
> eeg_filepath <- system.file("extdata", "EEG10009_v1.csv.gz", package = "EEGSpectralAnalysis")
> eeg_signal <- read.table(file = eeg_filepath)
> eeg_signal <- eeg_signal$V1
> eeg_params <- fft_eeg(eeg_signal)
> power_eeg_params <- power_eeg(eeg_params$power_spectrum)
> str(power_eeg_params)
List of 4
 $ absolute_band_power : num [1:6474] 5443549 23583271 16321002 4640000 8043634 ...
 $ absolute_band_aggreg: num [1:1079] 10640555 8014268 14069995 6132555 11820995 ...
 $ relative_band_power : num [1:6474] 0.408 0.755 0.751 0.328 0.469 ...
 $ relative_band_aggreg: num [1:1079] 0.541 0.483 0.586 0.449 0.553 ...
 ```