#' @title Compute EEG signal power
#' 
#' @description Calculate absolute absolute band
#'   power and band aggregation as well as relative
#'   band power and aggregation
#'   
#' @param power_spectrum matrix containing the square of the Fourier
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
#' @importFrom RcppRoll roll_mean  
#' @importFrom pracma repmat                   
#' @export
power_eeg = function(power_spectrum,
                     freq_min = 0.8,
                     freq_max = 4,
                     num_sec_w = 5,
                     aggreg_level = 6) {
  
  # Define the start and end index of the spectral window
  f1 <- floor(freq_min*num_sec_w) + 1     
  f2 <- floor(freq_max*num_sec_w) + 1
  
  #Find the length of the vectors for the aggregation in larger temporal windows
  length_aggreg=floor(ncol(power_spectrum)/aggreg_level);
  
  #Obtain the absolute power in the particular spectral window
  absolute_power <- power_spectrum[f1:f2, ];
  absolute_band_power <- colSums(absolute_power);
  
  #Obtain absolute power in aggregated windows
  absolute_band_aggreg <- roll_mean(absolute_band_power, n=aggreg_level, by=aggreg_level)
  
  #Obtain the relative power in the particular spectral window
  aa <- colSums(power_spectrum);
  rep_aa <- repmat(aa, nrow(power_spectrum),1)
  normalized_aa <- power_spectrum/rep_aa;
  relative_power <- normalized_aa[f1:f2, ];
  relative_band_power <- colSums(relative_power);
  
  #Obtain absolute power in aggregated windows
  relative_band_aggreg <- roll_mean(relative_band_power, n=aggreg_level, by=aggreg_level)
  
  output <- list(absolute_band_power,absolute_band_aggreg,relative_band_power,relative_band_aggreg)
  names(output) <- c("absolute_band_power","absolute_band_aggreg","relative_band_power","relative_band_aggreg")
  
  return(output)
}