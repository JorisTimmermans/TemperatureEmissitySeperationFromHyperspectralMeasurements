function [Tfit] = ComputeTemperature(wl_m,Msample,startfit,endfit)
%% Compute Temperature
% Determine spectral region that is fitted
msample                                             =   Msample(:,1);                                   % [W sr−1 m−2 nm−1]

% Fit Planck Curve to Radiant Exitance Spectrum
%planckfit is external function?
Tguess_C                                            =   20;
% Tfit                                                =   fminsearch('Planckfit',Tguess_C);
Tfit                                                =   fminsearch(@(T_sample_C) Planckfit(wl_m,msample,T_sample_C,startfit,endfit),Tguess_C);

% % use measurements instead (comment out if not used)
% global T
% Tfit                                              =   T.sample;