# EEGSpectralAnalysis
EEG Spectral Analysis Tools

## Installing the EEGSpectralAnalysis package

You can install `EEGSpectralAnalysis` from github with:
``` {r}
# install.packages("remotes")
remotes::install_github("adigherman/EEGSpectralAnalysis")
```

## Usage

To calculate absolute and power spectrum as well as estimated and lowest frequencies for an EEG signal we will use the `fft_eeg()` function. The parameters of the function are:

* `eeg_signal` - a csv text file with the EEG signal values (can read gzippped files, recommended);
* `sampling_frequency` the EEG signal sampling frequency (default value is 125);
* `max_frequency` which represents maximum sampling frequency (default value is 32).

``` {r}
> eeg_filepath <- system.file("extdata", "EEG10009_v1.csv.gz", package = "EEGSpectralAnalysis")
> eeg_params <- fft_eeg(eeg_filepath)
> str(eeg_params)
List of 6
 $ absolute_spectrum    : num [1:161, 1:6474] 131 597 763 458 746 ...
 $ power_spectrum       : num [1:161, 1:6474] 17146 356957 582410 209588 557206 ...
 $ estimated_frequencies: num [1:161] 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 ...
 $ lowest_frequency     : num 0.2
 $ num_seconds_window   : num 5
 $ sampling_frequency   : num 125
```
 