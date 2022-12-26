function []=plot_withnoise(Hyx,Gsxx,gamma2xy,SNR,f,l,color)
    %% plot four values    
    ref=1;
    f_block=f(1:l/2+1);
    % x = linspace(0,10,50);
    % y1 = sin(x);
    % y2 = rand(50,1);

    % Top two plots
    tiledlayout(2,2) % Requires R2019b or later
    nexttile
    %figure('name','H1');
    semilogx(f_block,20*log10(abs(Hyx/ref)),color);
    title('(a)');
    xlabel('Frequency in Hz');
    ylabel('H1-estimator');
    grid on


    nexttile
    %figure('name','Spectrum'); 
    %plot(Gsxx) as amplitude;
    plot(f_block,10*log10(abs(Gsxx)),color);
    title('(b)');
    xlabel('Frequency in Hz');
    ylabel('Magnitude spectrum in dB');


    % Plot nextline
    nexttile
    %figure('name','Coherence');
    semilogx(f_block,gamma2xy,color);
    title('(c)');
    xlabel('Frequency in Hz');
    ylabel('cohenrence');
    grid on


    nexttile
    semilogx(f_block,20*log10(SNR),color);
    title('(d)');
    xlabel('Frequency in Hz');
    ylabel('SNR in dB');
    grid on

end