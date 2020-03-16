if option.plot==1
    h1                                              =   figure('Position',[20 20 1024 800]','Visible','off');
    subplot(2,1,1,'Fontsize',option.Fontsize)
    semilogy(Tfit_,smoothness, Tfit_(i),smoothness(i),'ro','linewidth',2)
    ylabel('std (\epsilon - < {\epsilon} >) [-]')
    xlabel('Tfit [^oC]')
    
    subplot(2,1,2,'Fontsize',option.Fontsize)
    plot(wl_m*1e6,emissivity_sample,wl_m*1e6,emissivity_sample2,'linewidth',2) 
    ylabel('\epsilon [-]')
    legend('original','smoothed')
    axis([minV 13 0.8 1.2])

     
    path2output                                         =   [Dir.output,'6. Smoothed',filesep];
    if option.save==1
        if ~exist(path2output,'dir'), mkdir(path2output), end
        saveas(h1,[path2output,'Smoothed.png']);
        close(h1)
    elseif option.save==2
        if ~exist(path2output,'dir'), mkdir(path2output), end
        print(h1,[path2output,'Smoothed.png'],'-dpng',option.res)
        close(h1)
    else 
        set(h1,'Visible','on')
    end
end