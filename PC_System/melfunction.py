# Generated with SMOP  0.41
import melbankm
# melfunction.m

    
@function
def melfunction(x=None,*args,**kwargs):
    varargin = melfunction.varargin
    nargin = melfunction.nargin

    ##codegen
    bank=melbankm(24,256,8000,0,0.4,'t')
# melfunction.m:3
    bank=full(bank)
# melfunction.m:4
    
    bank=bank / max(ravel(bank))
# melfunction.m:5
    w=1 + dot(6,sin(dot(pi,(arange(1,12))) / 12))
# melfunction.m:7
    w=w / max(w)
# melfunction.m:8
    xx=double(x)
# melfunction.m:9
    xx=filter((1 - 0.9375),1,xx)
# melfunction.m:10
    xx=enframe(xx,256,80)
# melfunction.m:11
    p=zeros(256)
# melfunction.m:12
    m=zeros(197,12)
# melfunction.m:13
    for i in arange(1,size(xx,1)).reshape(-1):
        y=xx(i,arange())
# melfunction.m:17
        s=multiply(y.T,hamming(256))
# melfunction.m:18
        t=abs(fft(s))
# melfunction.m:19
        t=t ** 2
# melfunction.m:20
        p[i,arange()]=t
# melfunction.m:21
        c1=dot(dctcoef,log(dot(bank,t(arange(1,129)))))
# melfunction.m:22
        c2=multiply(c1,w.T)
# melfunction.m:23
        m[i,arange()]=c2
# melfunction.m:24
    
    pp=sum(p)
# melfunction.m:26
    c1=dot(dctcoef,log(dot(bank,pp(arange(1,129)).T)))
# melfunction.m:27
    c2=multiply(c1,w.T)
# melfunction.m:28
    dtm=zeros(size(m))
# melfunction.m:30
    for i in arange(3,size(m,1) - 2).reshape(-1):
        dtm[i,arange()]=dot(- 2,m(i - 2,arange())) - m(i - 1,arange()) + m(i + 1,arange()) + dot(2,m(i + 2,arange()))
# melfunction.m:32
    
    dtm=dtm / 3
# melfunction.m:34
    dtmm=zeros(size(dtm))
# melfunction.m:36
    for i in arange(3,size(dtm,1) - 2).reshape(-1):
        dtmm[i,arange()]=dot(- 2,dtm(i - 2,arange())) - dtm(i - 1,arange()) + dtm(i + 1,arange()) + dot(2,dtm(i + 2,arange()))
# melfunction.m:38
    
    dtmm=dtmm / 3
# melfunction.m:40
    ccc=concat([m,dtm,dtmm])
# melfunction.m:41
    ccc=ccc(arange(3,size(m,1) - 2),arange())
# melfunction.m:42
    __,__=size(ccc,nargout=2)
# melfunction.m:43
    #A=size(ccc);
    
    c=concat([[c1],[c2]])
# melfunction.m:47
    c=c.T
# melfunction.m:48
    return c
    
if __name__ == '__main__':
    pass
    