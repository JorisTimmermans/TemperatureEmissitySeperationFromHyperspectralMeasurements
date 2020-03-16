% Emissivity Calculation Prototype
% Martin Schlerf, Chris Hecker 2009

% Naming convention for input file: 
% BB_c: cold blackbody 
% BB_h: warm blackbody
% dwr: downwelling radiation
% sample: sample raw data
% wn: wavenumber

%#ok<*NUSED>

clear, close all

%% Load parameters
load constants
global h c k 

%% Load Data
global sample dwr uwr wl_m BB_h BB_c
global emissivity_BB_c emissivity_BB_h emissivity_gold 

[file, path]                                        =   uigetfile('*.mat', 'Select MAT-file');
cd (path);
load (file);

le                                                  =   length(sample);

wl_um                                               =   1./(wn/10000);
wl_m                                                =   wl_um/1000000;

T_BBc_C                                             =   input('Cold blackbody temperature in degree Celsius?')
T_BBh_C                                             =   input('Warm blackbody temperature in degree Celsius?')
T_gold_C                                            =   input('Gold reflector temperature in degree Celsius?')

%% estimate Temperature and hyperspectral emissivity
[Tfit,emissivity_sample,...
 MBB_c, MBB_h, Muwr, Mdwr, Msample, Msample_fit]    = TE_Calculation(DN_BB_c, T_BBc_C, emissivity_BB_c,... 
                                                                            DN_BB_h, T_BBh_C, emissivity_BB_h,...
                                                                            DN_uwr, T_gold_C, emissivity_gold,... 
                                                                            DN_sample);


%% Plot
PlotData