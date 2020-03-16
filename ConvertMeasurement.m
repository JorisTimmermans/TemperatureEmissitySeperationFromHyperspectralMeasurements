function [MBB_c,MBB_h,Muwr, Msample,gain,offset]=ConvertMeasurement(PBB_c,PBB_h,...                  
                                               DN_BB_h,DN_BB_c,DN_uwr, DN_sample)
                                           
% PBB_c         =   Theoretical Planck curve (based on Temperature measurement of BB)  
% PBB_h         =   Theoretical Planck curve (based on Temperature measurement of BB)  
%
% DN_BB_c       =   Measurement (in DN values) of BBc in DN values
% DN_BB_h       =   Measurement (in DN values) of BBc in DN values
% DN_uwr        =   Measurement (in DN values) of upwelling radiation from gold plate 
% DN_sample     =   Measurement (in DN values) of upwelling radiation from sample 

%%  Convert measurements (in DN) to real units 
% Calculate Radiometric Calibration Coefficients

gain                    =   (PBB_h-PBB_c)./(DN_BB_h-DN_BB_c);
offset                  =   PBB_c - gain.*(DN_BB_c);

% Convert measurements (in DN) to real units 
MBB_c                   =   offset + gain .*(DN_BB_c);
MBB_h                   =   offset + gain .*(DN_BB_h);
Muwr                    =   offset + gain .*(DN_uwr);
Msample                 =   offset + gain .*(DN_sample);


% global wl_m,
% subplot(2,1,1),plot(wl_m,DN_BB_h,...
%                     wl_m,DN_BB_c,...
%                     wl_m,DN_sample),title('DN'),legend('hot','cold','sample')
% subplot(2,1,2),plot(wl_m,PBB_h,...
%                     wl_m,PBB_c,...
%                     wl_m,Msample),title('Units'),legend('hot','cold','sample')
% ylim([0 100])
