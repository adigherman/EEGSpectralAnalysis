#' @title Read EEG signal from an EDF file
#' 
#' @param edf_file EDF file
#' 
#' @importFrom edfReader readEdfHeader readEdfSignals
#'  
#' @export
#' @return List containing the EDF file items

read_edf = function(edf_file){
  edf_header <- readEdfHeader(edf_file)
  edf_signals <- readEdfSignals(edf_header)
  
  return(edf_signals)
}