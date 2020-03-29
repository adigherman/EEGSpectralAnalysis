#' @title Get power values for EEG bands
#' 
#' @description Calculate power values for 
#' each of the EEG bands:
#'     Delta	< 4
#'     Theta	≥ 4 and < 8
#'     Alpha	≥ 8 and < 14
#'     Beta	  ≥ 14 and < 32
#'     Gamma  ≥ 32 and < 50
#'     
#' @param eeg_signal EEG signal expressed in micro-Volts
#' @param num_sec_w number of seconds in a time window used to 
#'    obtain the Fourier coefficients. Typically, this number is 5
#' @param aggreg_level number of 5 second intervals used to aggregate
#'    power. Typically, this number is 6 to ensure a 30 second 
#'    interval window (standard in EEG analysis)   
#' @export
#' 
#' @return List containing the aggregated power values for each EEG band
power_eeg_bands = function(eeg_signal,
                           sampling_frequency = 125,
                           max_frequency = 32,
                           num_sec_w = 5,
                           aggreg_level = 6) {
  
  eeg_params <- fft_eeg(eeg_signal,sampling_frequency,max_frequency,num_sec_w)
  
  #Delta band
  delta_band <- power_eeg(eeg_params$power_spectrum,freq_min = 0.8,freq_max = 3.9,num_sec_w,aggreg_level)
  delta_band <- delta_band$absolute_band_aggreg
  
  #Theta band
  theta_band <- power_eeg(eeg_params$power_spectrum,freq_min = 4,freq_max = 7.9,num_sec_w,aggreg_level)
  theta_band <- theta_band$absolute_band_aggreg
  
  #Alpha band
  alpha_band <- power_eeg(eeg_params$power_spectrum,freq_min = 8,freq_max = 14.9,num_sec_w,aggreg_level)
  alpha_band <- alpha_band$absolute_band_aggreg
  
  #Beta band
  beta_band <- power_eeg(eeg_params$power_spectrum,freq_min = 15,freq_max = 31.9,num_sec_w,aggreg_level)
  beta_band <- beta_band$absolute_band_aggreg
  
  #Gamma band
  gamma_band <- power_eeg(eeg_params$power_spectrum,freq_min = 32,freq_max = 49.9,num_sec_w,aggreg_level)
  gamma_band <- gamma_band$absolute_band_aggreg
  
  output <- list(delta_band,theta_band,alpha_band,beta_band,gamma_band)
  names(output) <- c("Delta","Theta","Alpha","Beta","Gamma")
  
  
  return(output)
}