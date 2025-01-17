### Preparing *_PyRate.py input file ###

# Load utilities
setwd("C:\\Users\\SimoesLabAdmin\\Documents\\BDNN_Arielli")
source("../PyRate/pyrate_utilities.r")

# Parse raw data and generate PyRate input files
extract.ages(file="data/reptilia_processed_data/reptilia_pyrate.txt", replicates=10)
extract.ages(file="data/synapsida_processed_data/synapsida_pyrate.txt", replicates=10)
extract.ages(file="data/temnospondyli_processed_data/temnospondyli_pyrate.txt", replicates=10)
# Outputs: *_PyRate.py (input for later models), *_TaxonList.txt


### Terminal Commands ###

# ## Check for species name spelling
system(python ../PyRate/PyRate.py -check_names data/reptilia_processed_data/reptilia_pyrate_TaxonList.txt)
#     # Output: *_TaxonList_scores.txt


# ## Model Likelihood Test
# system(python ../PyRate/PyRate.py data/*_PyRate.py -qShift data/Time_bins_ByStages.txt -PPmodeltest)

# ## Basic RJMCMC PyRate (no trait file)
python ..\PyRate\PyRate.py .\data\reptilia_processed_data\reptilia_pyrate_PyRate.py -A 4 -qShift .\data\Time_bins_ByStages.txt -mG -n 200000000 -s 20000 -p 2000 -wd .\reptilia\ -j 

python ..\PyRate\PyRate.py .\data\synapsida_processed_data\synapsida_pyrate_PyRate.py -A 4 -qShift .\data\Time_bins_ByStages.txt -mG -n 200000000 -s 20000 -p 2000 -wd .\synapsida\ -j 

python ..\PyRate\PyRate.py .\data\temnospondyli_processed_data\temnospondyli_pyrate_PyRate.py -A 4 -qShift data/Time_bins_ByStages.txt -mG -n 200000000 -s 20000 -p 2000 -wd .\temnospondyli\  -j 

# Subsequent runs need to specify different -j values
# # Outputs: *_sum.txt, *_mcmc.log, *_sp_rates.log, *_ex_rates.log

# # RJMCMC BD Model Sampling Frequencies
# system(python ../PyRate/PyRate.py -mProb pyrate/*_mcmc.log -b numb | tee pyrate/*_BD_Sampling_Freq.txt)
# # Outputs: *_BD_Sampling_Freq.txt

# # RJMCMC RTT Plots, per replicate
# system(python ../PyRate/PyRate.py -plotRJ pyrate/pyrate_mcmc_logs/  -b numb)

# # RJMCMC Combining Replicates
# system(python ../PyRate/PyRate.py -combLogRJ pyrate/pyrate_mcmc_logs -b numb -tag filename)
# system(python ../PyRate/PyRate.py -plotRJ pyrate/pyrate_mcmc_logs/ -tag  -b numb)

# # RJMCMC Q Rate Plots Through Time (TPP)
# system(python ../PyRate/PyRate.py -plotQ pyrate/pyrate_mcmc_logs -qShift data/Time_bins_ByStages.txt -b numb)
