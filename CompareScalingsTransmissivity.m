function []=CompareScalingsTransmissivity(Atmosphere)
global option
global Dir
path2output                                     =   [Dir.output,'1. AtmosphericCorrectionFunction',filesep];
    
wl                                              =   Atmosphere.L010.RH.wl_m*1e6;
type                                            =   Atmosphere.L010.RH.type;

tau_n_010                                       =   Atmosphere.L010.RH.tau(:,10);
tau_n_100                                       =   Atmosphere.L100.RH.tau(:,10);

Ssim.RH                                         =   1.3;
Iref_L010_RH130   	                            =   Atmosphere.L010.RH.scaling== Ssim.RH;
Iref_L100_RH130                                 =   Atmosphere.L100.RH.scaling== Ssim.RH;

tau_RH130_010                                   =   Atmosphere.L010.RH.tau(:,Iref_L010_RH130);
tau_RH130_100                                   =   Atmosphere.L100.RH.tau(:,Iref_L100_RH130);

tauprime_n_100                                  =   exp(log(tau_n_010)*(100/10));
tauprime_n_010                                  =   exp(log(tau_n_100)*(10/100));

tauprime_RH130_100                              =   exp(log(tau_RH130_010)*(100/10));
tauprime_RH130_010                              =   exp(log(tau_RH130_100)*(10/100));

%% Difference between estimating L010 from L100, or the difference for normal case!
if option.plot==1
    h1                                          =   figure('Position',[50 50 1024 800],'renderer','zbuffer','Visible','off');
    h11                                         =   subplot(2,2,1,'Fontsize',option.Fontsize);
    h111                                        =   plot(wl,tau_n_010,'g',wl,tauprime_n_010,'b--','linewidth',2); %#ok<*NASGU>
    h113                                        =   ylabel('\tau_{n} [-]');
    h115                                        =   legend('\tau_{010}','e^{ln(\tau_{100})*(10/100)}','location','northeast');set(h115,'Fontsize',7)

    h12                                         =   subplot(2,2,2,'Fontsize',option.Fontsize);
    h121                                        =   plot(wl,tau_n_100,'b',wl,tauprime_n_100,'g','linewidth',2);
    h125                                        =   legend('\tau_{100}','exp[ln(\tau_{010})*(100/10)]','location','northeast');set(h125,'Fontsize',7)
    linkaxes([h11,h12],'xy')
    axis([6.785 6.81 0 1.2])

    h13                                         =   subplot(2,2,3,'Fontsize',option.Fontsize);
    h131                                        =   plot(wl,tau_n_010-tauprime_n_010,'r--','linewidth',2);
    h133                                        =   xlabel('wavelength [\mum]');
    h134                                        =   ylabel('\Delta \tau_{n} [-]');
    

    h14                                         =   subplot(2,2,4,'Fontsize',option.Fontsize);
    h141                                        =   plot(wl,tau_n_100-tauprime_n_100,'linewidth',2);
    h143                                        =   xlabel('wavelength [\mum]');
%     h144                                        =   ylabel('\tau_{100} - exp[ln(\tau_{010})*(100/10)]');
    linkaxes([h13,h14],'xy')
    axis([6.785 6.81 -0.5 0.5])
    
    if option.save==1
        saveas(h1,[path2output,'1.2a. Difference in pathlength-scaling for normal case with (',type,' data).png'])
        close(h1)
    elseif option.save==2
        print(h1,[path2output,'1.2a. Difference in pathlength-scaling for normal case with (',type,' data).png'],'-dpng',option.res)
        close(h1)
    else
        set(h1,'Visible','on')
    end
end

%% Difference between estimating L010 from L100, or the difference for RH = 1.48xN
if option.plot==1

    h2                                          =   figure('Position',[50 50 1024 800],'Renderer','zbuffer','Visible','off');
    h21                                         =   subplot(2,2,1,'Fontsize',option.Fontsize);
    h211                                        =   plot(wl,tau_RH130_010,'g',wl,tauprime_RH130_010,'b--','linewidth',2);
    h213                                        =   ylabel('\tau_{RH1.3} [-]');
    h215                                        =   legend('\tau_{010}','exp[ln(\tau_{100})*(10/100)]','location','northeast');set(h215,'Fontsize',7)

    h22                                         =   subplot(2,2,2,'Fontsize',option.Fontsize);
    h221                                        =   plot(wl,tau_RH130_100,'b',wl,tauprime_RH130_100,'g','linewidth',2);
    h225                                        =   legend('\tau_{100}','exp[ln(\tau_{010})*(100/10)]','location','northeast');set(h225,'Fontsize',7)
    linkaxes([h21,h22],'xy')
    axis([6.785 6.81 0 1.2])

    h23                                         =   subplot(2,2,3,'Fontsize',option.Fontsize);
    h231                                        =   plot(wl,tau_RH130_010-tauprime_RH130_010,'--','linewidth',2);
    h233                                        =   xlabel('wavelength [\mum]');
    h234                                        =   ylabel('\Delta \tau_{RH1.3} [-]');
    

    h24                                         =   subplot(2,2,4,'Fontsize',option.Fontsize);
    h241                                        =   plot(wl,tau_RH130_100-tauprime_RH130_100,'linewidth',2);
    h243                                        =   xlabel('wavelength [\mum]');
%     h244                                        =   ylabel('\tau_{RH1.3,100} - exp[ln(\tau_{RH1.3,010})*(100/10)]');    
    linkaxes([h23,h24],'xy')
    axis([6.785 6.81     -0.5 0.5])
    
    if option.save==1
        saveas(h2,[path2output,'1.2b. Difference in pathlength-scaling for RH130 with (',type,' data).png'])
        close (h2)
	elseif option.save==2
        print(h2,[path2output,'1.2b. Difference in pathlength-scaling for RH130 with (',type,' data).png'],'-dpng',option.res)
        close(h2)
    else
        set(h2,'Visible','on')
    end
end