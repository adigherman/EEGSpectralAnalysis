#' @title Compute EEG signal parameters
#' 
#' @description Calculate absolute and power spectrum as well as estimated and 
#'   lowest frequencies for an EEG signal
#'
#' @param eeg_signal CSV file contining the the EEG signal expressed in micro-Volts
#' @param sampling_frequency Sampling frequency of the EEG signal. This is 
#'   typycally equal to 125Hz. Default value is 125.
#' @param max_frequency The maximum frequency for which the spectrum is being 
#'   calculated. Default value is 32.
#'   
#' @return Vector containing the values:
#'   - absolute_spectrum:    A matrix with every row corresponding to
#'                           a frequency between 'lowest_frequency' and
#'                           'max_frequency'. Every column corresponds
#'                           to a 5 second interval. Every entry is the
#'                           absolute value of the Fourier coefficient
#'
#'   - power_spectrum:       Same structure as 'absolute_spectrum', but
#'                           contains the square of the absolute value
#'                           of the Fourier coefficient
#'
#'   - estimated_frequencies: Vector of estimated frequencies
#'                            corresponding to each row in the spectrum
#'                            matrices
#'
#'   - lowest_frequency:     The smallest estimable frequency. This is
#'                           also the first entry of 'estimated_frequencies'
#'                
#' @export
fft_eeg = function(eeg_signal,
                   sampling_frequency = 125,
                   max_frequency = 32) {
  
  e <- read.csv(file = eeg_signal, header=FALSE)
  e <- e * 1000000
  length_record <- nrow(e)
  
  # This is the duration of EEG record used for analysis (in seconds) per window
  num_seconds_window <- 5;
  
  #This is the number of datapoints in each 'window' which will be used for the FFT
  window_length <- num_seconds_window*sampling_frequency;
  
  #Lowest frequency that can be estimated based on the num_seconds_window
  lowest_frequency <- 1/num_seconds_window;   
  
  
  #Number of windows (that are in length = recdur) for which the FFT will be calculated;             
  num_windows <- floor(length_record/window_length);
  
  e <- matrix(e$V1,window_length, num_windows)
  
  #Perform the fft on the data after hanning windowing
  e <- scale(e,scale=FALSE)
  hanning_matrix <- hanning(window_length+2)
  hanning_matrix <- hanning_matrix[1:window_length+1]
  hanning_matrix <- hanning_matrix * matrix(1,window_length,num_windows)
  
  e <- e * hanning_matrix
  e <- apply(e, 2, function(x) fft(as.numeric(x)))
  
  #Calculate the absolute 
  #This is the calculation of power of the spectrum 
  
  end_frequency <- floor(max_frequency*num_seconds_window) + 1
  absolute_spectrum <- abs(e[1:end_frequency,])
  power_spectrum <- absolute_spectrum^2
  estimated_frequencies <- seq(1,end_frequency,1)/num_seconds_window
  
  output <- list(absolute_spectrum,power_spectrum,estimated_frequencies,lowest_frequency,num_seconds_window,sampling_frequency)
  names(output) <- c("absolute_spectrum","power_spectrum","estimated_frequencies","lowest_frequency","num_seconds_window","sampling_frequency")
  
  return(output)
}