#' @title Compute EEG signal power
#' 
#' @description Calculate absolute absolute band
#'   power and band aggregation as well as relative
#'   band power and aggregation
#'   
#' @param power_spect matrix containing the square of the Fourier
#'   coefficients for an EEG data set. Each column corresponds to 
#'   a 5 second interval window. Each column corresponds to a 
#'   frequency. Lowest frequency is 1/num_sec_w, typically 0.2Hz
#' @param freq_min minimum frequency defining the frequency 
#'    band of interest
#' @param freq_max maximum frequency defining the frequency 
#'    band of interest
#' @param num_sec_w number of seconds in a time window used to 
#'    obtain the Fourier coefficients. Typically, this number is 5
#' @param aggreg_level number of 5 second intervals used to aggregate
#'    power. Typically, this number is 6 to ensure a 30 second 
#'    interval window (standard in EEG analysis)
#'
#' @return List containing the elements:
#'   - absolute_band_power:  Vector containing the absolute power in the
#'                           frequency band defined by freq_min, freq_max.
#'                           Each entry corresponds to a time window of
#'                           length num_sec_w in seconds in the original EEG
#'                           signal
#'
#'   - absolute_band_aggreg: Vector containing the absolute power in the
#'                           frequency band defined by freq_min, freq_max.
#'                           The difference from absolute_band_power is that
#'                           this aggregates power in a number of
#'                           aggreg_level adjacent intervals of length
#'                           num_sec_w
#'
#'   - relative_band_power:  Vector containing the relative power in the
#'                           frequency band defined by freq_min, freq_max.
#'                           The difference from absolute_band_power is that
#'                           this is expressed as a fraction of the total
#'                           power in all frequencies
#'
#'   - relative_band_aggreg: Vector containing the relative power in the
#'                           frequency band defined by freq_min, freq_max.
#'                           The difference from relative_band_power is that
#'                           this aggregates power in a number of
#'                           aggreg_level adjacent intervals of length
#'                           num_sec_w
#'                           
#' @export
power_eeg = function(power_spect,
                     freq_min = 0.8,
                     freq_max = 4,
                     num_sec_w = 5,
                     aggreg_level = 6) {
  
}