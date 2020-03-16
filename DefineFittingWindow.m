function [startfit, endfit]=DefineFittingWindow(wl_m,MBB_h,MBB_c,Msample,method)
switch method
    case 'maxTbright'
        %% Using max (BrightnessTemperatures)

%         global msample
         % 5.1 
        Tguess_C                                            =   20;
        msample                                             =   Msample(:,1);

        Tfittry                        	                    =   zeros(size(wl_m))*NaN;       
        nwindow                                             =   300; 
        filterwindow                                        =   ones(nwindow,1); 
        I                                                   =   msample>MBB_c(:,1) & msample<MBB_h(:,1);
        Ntrueobs                                            =	conv(double(I),double(filterwindow),'same');
        Ifiltered                                           = 	Ntrueobs==nwindow;

        iwindow                                             =   50;
        samplingsteps                                       =   10;
        for i=(1+iwindow/2):samplingsteps:(length(MBB_h)-iwindow/2)
            startfit                                        =   i;
            endfit                  	                    =   startfit+iwindow;

            if (wl_m(i)>6e-6 && wl_m(i)<12e-6) && Ifiltered(i)>0
                Tfittry(i)                                  =   fminsearch(@(T_sample_C) Planckfit(wl_m,msample,T_sample_C,startfit,endfit),Tguess_C);
            else
                Tfittry(i)                                  =   NaN;
            end
        end

        [~,centerfit]                                       =   nanmax(Tfittry);
        startfit                                            =   centerfit;
        endfit                                              =   startfit;
        
    case 'static'
        %% set Static Window for Tfit computation
        Msample(Msample==inf)                             =   0;
        [~,Imaxpos]                                       =   max(Msample);
        imaxpos                                           =   find(Imaxpos);
        
        startfit                                          =   imaxpos-50;
        endfit                                            =   imaxpos+100;

end