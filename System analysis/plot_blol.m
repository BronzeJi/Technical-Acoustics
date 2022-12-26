%plot different block length
function []=plot_blol(gamma2xy,gamma2xy2,gamma2xy3,f,label)
    
     figure('name','block length');
    tiledlayout(1,2)
    nexttile
    f_block1=f_blockk(label(1));
    semilogx(f_block1,gamma2xy,'k--','LineWidth',1);
    grid on
    hold on
    f_block2=f_blockk(label(2));
    semilogx(f_block2,gamma2xy2,'g','LineWidth',2);
    f_block3=f_blockk(label(3));
    semilogx(f_block3,gamma2xy3,'b','LineWidth',0.5);
    ylabel('Coherence')
    xlabel('Frequency in Hz')
    legend(['length: ',num2str(label(1))],['length: ',num2str(label(2))],['length: ',num2str(label(3))],'location','southwest');
%     semilogx(f_block,gamma2xy4,'b--','LineWidth',2);
%     semilogx(f_block,gamma2xy5,'g','LineWidth',1);
    title('(a)');

    nexttile
    semilogx(f_block1,20*log10(gamma2xy./(1-gamma2xy)),'k--','LineWidth',1);
    grid on
    hold on
    SNR2=gamma2xy2./(1-gamma2xy2);
    semilogx(f_block2,20*log10(SNR2),'g','LineWidth',2);

    SNR3=gamma2xy3./(1-gamma2xy3);
    semilogx(f_block3,20*log10(SNR3),'b','LineWidth',0.5);
    
    legend(['length: ',num2str(label(1))],['length: ',num2str(label(2))],['length: ',num2str(label(3))],'location','southwest');
    xlabel('Frequency in Hz');
    ylabel('SNR in dB');
     title('(b)');    
end