%plot different block number
function []=plot_blon(gamma2xy,gamma2xy2,gamma2xy3,f_block,label)
    
    figure('name','block number');
    tiledlayout(1,2)
    nexttile
    semilogx(f_block,gamma2xy,'k--','LineWidth',1);
    grid on
    hold on
    semilogx(f_block,gamma2xy2,'g','LineWidth',2);
    semilogx(f_block,gamma2xy3,'b','LineWidth',0.5);
    ylabel('Coherence')
    xlabel('Frequency in Hz')
    legend([num2str(label(1)),' blocks'],[num2str(label(2)),' blocks'],[num2str(label(3)),' blocks'],'location','southwest');
    title('(a)');

    nexttile
    semilogx(f_block,20*log10(gamma2xy./(1-gamma2xy)),'k--','LineWidth',1);
    grid on
    hold on
    SNR2=gamma2xy2./(1-gamma2xy2);
    semilogx(f_block,20*log10(SNR2),'g','LineWidth',2);
    SNR3=gamma2xy3./(1-gamma2xy3);
    semilogx(f_block,20*log10(SNR3),'b','LineWidth',0.5);
    legend([num2str(label(1)),' blocks'],[num2str(label(2)),' blocks'],[num2str(label(3)),' blocks'],'location','southwest');
    xlabel('Frequency in Hz');
    ylabel('SNR in dB');
%     semilogx(f_block,gamma2xy4,'b--','LineWidth',2);
%     semilogx(f_block,gamma2xy5,'g','LineWidth',1);
     title('(b)');
end



