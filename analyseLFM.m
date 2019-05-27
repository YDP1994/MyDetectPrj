clear;

reData=textread('chirp512_lanczos.txt','%s')';
reSignal=hex2dec(reData)';
reSignal=((reSignal-128)/128);

signal.chirpBegin = 1;
signal.chirpEnd = 1562;      %15.625us * 100 -> 1562.5  根本原则：根据相同的持续时间，计算不同的点数。
% signal codes here
signal.chirpFs=100e6;  %閲囨牱棰戠巼
signal.chirpW=5e6;    %chirp甯﹀
signal.chirpF=1.5e6;  %chirp璧峰棰戠巼
signal.chirpT=signal.chirpEnd/signal.chirpFs;   %鎸佺画鏃堕暱
signal.chirpK=signal.chirpW/signal.chirpT;
signal.chirpt1=signal.chirpBegin/signal.chirpFs:1/signal.chirpFs:signal.chirpT;
chirp=cos(2*pi*signal.chirpF*signal.chirpt1+pi*signal.chirpK*(signal.chirpt1.*signal.chirpt1));   %浜х敓杈撳叆淇″彿

%未经过失配滤波器
S=conj(fft(chirp));  
H=S.*exp(-1i*2*pi*signal.chirpF*signal.chirpt1*2.7);  %姹傚緱鍖归厤婊ゆ尝鍣?
h=ifft(H);               %瀵瑰尮閰嶆护娉㈠櫒鍋氬弽鍌呮皬鍙樻崲
result1=abs(conv(h,reSignal));

%经过失配滤波器
chebw = chebwin(length(h),50)';
chebh = chebw.*h;		
result2 = abs(conv(chebh,reSignal));



