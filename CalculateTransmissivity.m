function [taux, tauprime]       =   CalculateTransmissivity(tau_n,tau_inf,a, b, c, s)

dk                              =   a.*s.^2 + b.*s + c;

%% saturation of water vapor
% If Water vapor is above maximum allowed value,  MODTRAN 
% sets the water column to the maximum allowed value. Consequently S 
% does have no effect anymore on dk
% dk_inf                        =   -log(tau_inf./tau_n);
% dk                            =   min(dk_inf,dk);

% calculate taux
tauprime                        =   exp(-dk);
tau                             =   tauprime.*tau_n;

tau                          	=   nanmax(tau,tau_inf);
tauprime                        =   tau./tau_n;

taux                            =   tau;
