clear;

reData=textread('chirp512_lanczos.txt','%s')';
reSignal=hex2dec(reData)';
reSignal=((reSignal-128)/128);

signal.chirpBegin = 1;
signal.chirpEnd = 1562;      %15.625us * 100 -> 1562.5  ����ԭ�򣺸�����ͬ�ĳ���ʱ�䣬���㲻ͬ�ĵ�����
% signal codes here
signal.chirpFs=100e6;  %采样频率
signal.chirpW=5e6;    %chirp带宽
signal.chirpF=1.5e6;  %chirp起始频率
signal.chirpT=signal.chirpEnd/signal.chirpFs;   %持续时长
signal.chirpK=signal.chirpW/signal.chirpT;
signal.chirpt1=signal.chirpBegin/signal.chirpFs:1/signal.chirpFs:signal.chirpT;
chirp=cos(2*pi*signal.chirpF*signal.chirpt1+pi*signal.chirpK*(signal.chirpt1.*signal.chirpt1));   %产生输入信号

%δ����ʧ���˲���
S=conj(fft(chirp));  
H=S.*exp(-1i*2*pi*signal.chirpF*signal.chirpt1*2.7);  %求得匹配滤波�?
h=ifft(H);               %对匹配滤波器做反傅氏变换
result1=abs(conv(h,reSignal));

%����ʧ���˲���
chebw = chebwin(length(h),50)';
chebh = chebw.*h;		
result2 = abs(conv(chebh,reSignal));



