% frequency resolution for each length
function [fb]=f_blockk(l)
    Nf=l; %number of samples
    fs=10000;
    dt=1/fs;
    t=(0:Nf-1)*dt;%time vector with Nf consequtive samples 
    df=fs./Nf;
    f=(0:Nf-1).*df;% frequency vector
    fb=f(1,1:l/2+1);
end