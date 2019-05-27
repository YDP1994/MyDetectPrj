clear all;

% %%%%%%%%%%%%%%%%%%% %
% creat my chirp signal
% %%%%%%%%%%%%%%%%%%% %
signal.chirpBegin = 1;
signal.chirpEnd = 500;      %500/32 -> 15.625us
% signal codes here
signal.chirpFs=32e6;  %閲囨牱棰戠巼
signal.chirpW=5e6;    %chirp甯﹀
signal.chirpF=1.5e6;  %chirp璧峰棰戠巼
signal.chirpT=signal.chirpEnd/signal.chirpFs;   %鎸佺画鏃堕暱
signal.chirpK=signal.chirpW/signal.chirpT;
signal.chirpt1=signal.chirpBegin/signal.chirpFs:1/signal.chirpFs:signal.chirpT;
chirp=cos(2*pi*signal.chirpF*signal.chirpt1+pi*signal.chirpK*(signal.chirpt1.*signal.chirpt1));   %浜х敓杈撳叆淇″彿
fileChirp = ceil(((1+chirp)/2)*(2^8));

% 探头的系统函数，为预失真做准备
ProbeF = 5e6;   %鎺㈠ご鐨勪腑蹇冮鐜?
impulse_response=sin(2*pi*ProbeF*(0:1/signal.chirpFs:2/ProbeF))/10;
impulse_response=impulse_response.*hanning(max(size(impulse_response)))';

fid1 = fopen('matlab2rom.coe','w');   %写到sin.coe文件，用来初始化sin_rom
fprintf(fid1,'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid1,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:500
    if fileChirp(i)==2^8
        fileChirp(i)=fileChirp(i)-1;
    end
    if fileChirp(i)<2^4
        fprintf(fid1,'0%x',fileChirp(i));
    else
        fprintf(fid1,'%x',fileChirp(i));
    end
    fprintf(fid1,',');
    if i%15==0
        fprintf(fid1,'\n');
    end
end
fclose(fid1);