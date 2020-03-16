function [Mdwr]=CalculateMdwr(wl_m,Mglr,Pgold,emissivity_gold)
global option
global Dir
path2output                                             =   [Dir.output,'4. CalibratingMeasurements',filesep];

Mdwr(:,1)                                               =   (Mglr(:,1)-emissivity_gold.*Pgold(:,1))./(1-emissivity_gold);            % [W sr−1 m−2 nm−1]
Mdwr(:,2)                                               =   (Mglr(:,2)-emissivity_gold.*Pgold(:,2))./(1-emissivity_gold);            % [W sr−1 m−2 nm−1]

if option.plot==1
    maxv                                                =   max([max(Mglr(:,1)) max(Mdwr(:,1))]);  
    maxv                                                =   max([min(Mglr(wl_m*1e6>8 & wl_m*1e6<12,1))*5 min(Mdwr(wl_m*1e6>8 & wl_m*1e6<12,1))*5]);
    
    h1                                                  =   figure('Position',[50 50 1024 800],'Renderer','zbuffer','visible','off');
    h11                                                 =   subplot(2,1,1,'Fontsize',option.Fontsize); %#ok<*NASGU>
    h111                                                =   plot(wl_m*1e6,Mglr);
    h112                                                =   title('Gold Leaving radiation');
    h115                                                =   legend('Before target measurement','After target measurement');
    h1114                                               =   ylabel('L [W sr−1 m−2 nm−1]');
    
    ylim([0 maxv]);

    h12                                                 =   subplot(2,1,2,'Fontsize',option.Fontsize);
    h121                                                =   plot(wl_m*1e6,Mdwr);
    h122                                                =   title('Downwelling radiation');    
    h123                      	                        =   xlabel('\lambda [\mum]');
    h1114                                               =   ylabel('L [W sr−1 m−2 nm−1]');
    ylim([0 maxv]);
    
    if option.save
        if ~exist(path2output,'dir'), mkdir(path2output), end
        saveas(h1,[path2output ,'4.2 Estimating Downwelling radiation.png'])
        close(h1)
	elseif option.save==2
        if ~exist(path2output,'dir'), mkdir(path2output), end
        print(h1,[path2output ,'4.2 Estimating Downwelling radiation.png'],'-dpng',option.res)
        close(h1) 
    else
        set(h1,'Visible','on')
    end
end