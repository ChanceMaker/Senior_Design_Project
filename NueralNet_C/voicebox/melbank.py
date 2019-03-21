# Generated with SMOP  0.41
from libsmop import *
# melbank.m

    # MFCC implement with Matlab #
    Fs=8000
# melbank.m:2
    x,Fs=audioread('one.wav',nargout=2)
# melbank.m:3
    bank=melbankm(24,256,8000,0,0.4,'t')
# melbank.m:4
    bank=full(bank)
# melbank.m:5
    
    bank=bank / max(ravel(bank))
# melbank.m:6
    w=1 + dot(6,sin(dot(pi,concat([arange(1,12)])) / 12))
# melbank.m:7
    w=w / max(w)
# melbank.m:8
    xx=double(x)
# melbank.m:9
    xx=filter(concat([1 - 0.9375]),1,xx)
# melbank.m:10
    xx=enframe(xx,256,80)
# melbank.m:11
    for i in arange(1,size(xx,1)).reshape(-1):
        y=xx(i,arange())
# melbank.m:14
        s=multiply(y.T,hamming(256))
# melbank.m:15
        t=abs(fft(s))
# melbank.m:16
        t=t ** 2
# melbank.m:17
        c1=dot(dctcoef(),log(dot(bank,t(arange(1,129)))))
# melbank.m:18
        c2=multiply(c1,w.T)
# melbank.m:19
        m[i,arange()]=c2
# melbank.m:20
    
    #求一阶差分系数
    dtm=zeros(size(m))
# melbank.m:23
    for i in arange(3,size(m,1) - 2).reshape(-1):
        dtm[i,arange()]=dot(- 2,m(i - 2,arange())) - m(i - 1,arange()) + m(i + 1,arange()) + dot(2,m(i + 2,arange()))
# melbank.m:25
    
    dtm=dtm / 3
# melbank.m:27
    dtmm=zeros(size(dtm))
# melbank.m:29
    for i in arange(3,size(dtm,1) - 2).reshape(-1):
        dtmm[i,arange()]=dot(- 2,dtm(i - 2,arange())) - dtm(i - 1,arange()) + dtm(i + 1,arange()) + dot(2,dtm(i + 2,arange()))
# melbank.m:31
    
    dtmm=dtmm / 3
# melbank.m:33
    ccc=concat([m,dtm,dtmm])
# melbank.m:35
    ccc=ccc(arange(3,size(m,1) - 2),arange())
# melbank.m:37
    ccc
    subplot(2,1,1)
    ccc_1=ccc(arange(),1)
# melbank.m:40
    plot(ccc_1)
    title('MFCC')
    ylabel('Amplitude')
    h,w=size(ccc,nargout=2)
# melbank.m:44
    A=size(ccc)
# melbank.m:45
    subplot(2,1,2)
    plot(concat([1,w]),A)
    xlabel('Dimension')
    ylabel('Amplitude')