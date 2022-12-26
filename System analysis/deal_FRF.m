function [Hyx,Gsxx,gamma2xy,SNR,f]=deal_FRF(N,l,file, noise)
    %N is the number of blocks, l is the length of one block.
    %file should include the input statical equal signal, the output signal
    %and sample frequncy
    
    load(file);
    %% More noise
    x=x+noise*randn(1,length(x))'; 
    y=y+noise*randn(1,length(x))'; 
    %%
    % %load signal and prepare for the parameter
    Nf=l; %number of samples
    dt=1/fs;
    t=(0:Nf-1)*dt;%time vector with Nf consequtive samples 
    df=fs/Nf;
    f=(0:Nf-1)*df;% frequency vector
    w=2*pi*f;

    block=zeros(N*2,l); wblock=zeros(N*2,l); fwblock=zeros(N*2,l);
    X=zeros(N,l); Y=zeros(N,l);
    Sxx=zeros(N,l); Syx=zeros(N,l); Syy=zeros(N,l);

    for i=1:l:N*l
    n=(i+l-1)/l;%block number
    hw=sqrt(sum(hanning(l).^2)/l);
    %hw=1;
    %input signal
    block(n,:)=x(i:i+l-1);
    wblock(n,:)=block(n,:).*hanning(l)'/hw;
    %fwblock(i,:)=fft(wblock(i,:));
    X(n,:)=fft(wblock(n,:))/l;
    %output signal
    block(n+N,:)=y(i:i+l-1);
    wblock(n+N,:)=block(n+N,:).*hanning(l)'/hw;
    %fwblock(i+n,:)=fft(wblock(i+n,:));
    Y(n,:)=fft(wblock(n+N,:))/l;
    %acceleration
    Y(n,:)=Y(n,:).*(-w.^2);


    Sxx(n,:)=X(n,:).*conj(X(n,:));
    Syx(n,:)=Y(n,:).*conj(X(n,:));
    Syy(n,:)=Y(n,:).*conj(Y(n,:)); 
    end
    %% average double-side
    Gdxx=sum(Sxx,1)/N;
    Gdyx=sum(Syx,1)/N;
    Gdyy=sum(Syy,1)/N;
    
    %single-side
    Gsxx(1)=Gdxx(1);
    Gsxx(2:l/2)=Gdxx(2:l/2)*2;
    Gsxx(l/2+1)=Gdxx(l/2+1);

    Gsyx(1)=Gdyx(1);
    Gsyx(2:l/2)=Gdyx(2:l/2)*2;
    Gsyx(l/2+1)=Gdyx(l/2+1);

    Gsyy(1)=Gdyy(1);
    Gsyy(2:l/2)=Gdyy(2:l/2)*2;
    Gsyy(l/2+1)=Gdyy(l/2+1);
    %% Frequency Respond Function
    Hyx=Gsyx./Gsxx;
    
    %% Coherence
    %indicates the consistent linear relationship between two signals
    %during the averaging
    gamma2xy=abs(Gsyx).^2./Gsxx./Gsyy;
    SNR=gamma2xy./(1-gamma2xy);
end
