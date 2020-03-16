function [emissivity_sample,Msample_fit, smoothness] = ComputeEmissivity(wl_m,Msample,Mdwr,Tfit)
Msample_fit                                        	=   PlanckCurve(wl_m,Tfit);                         % [W sr−1 m−2 nm−1]

% Msample_fit                                      	=   2*pi*h*c^2./wl_m.^5./(exp(h*c./(wl_m*k*Tfit))-1)/10^6;

% Compute Emissivity
emissivity_sample      	                            =   (Msample(:,1)-Mdwr(:,1))./(Msample_fit-Mdwr(:,1));      % []

%% estimate smoothness of emissivity spectra (added by Joris)
emissivity_sample1                              =   [emissivity_sample(1:end-2); NaN; NaN];
emissivity_sample2                              =   [NaN; emissivity_sample(2:end-1); NaN];
emissivity_sample3                              =   [NaN; NaN; emissivity_sample(3:end-0)];
smoothness                                      =	nanstd(emissivity_sample2 - (emissivity_sample1+emissivity_sample2+emissivity_sample3)/3);