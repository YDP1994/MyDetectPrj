clear all;

% %%%%%%%%%%%%%%%%%%% %
% creat my chirp signal
% %%%%%%%%%%%%%%%%%%% %
signal.chirpBegin = 1;
signal.chirpEnd = 500;      %500/32 -> 15.625us
% signal codes here
signal.chirpFs=32e6;  %采样频率
signal.chirpW=5e6;    %chirp带宽
signal.chirpF=1.5e6;  %chirp起始频率
signal.chirpT=signal.chirpEnd/signal.chirpFs;   %持续时长
signal.chirpK=signal.chirpW/signal.chirpT;
signal.chirpt1=signal.chirpBegin/signal.chirpFs:1/signal.chirpFs:signal.chirpT;
chirp=cos(2*pi*signal.chirpF*signal.chirpt1+pi*signal.chirpK*(signal.chirpt1.*signal.chirpt1));   %产生输入信号
fileChirp = ceil(((1+chirp)/2)*(2^8));

% ̽ͷ��ϵͳ������ΪԤʧ����׼��
ProbeF = 5e6;   %探头的中心频�?
impulse_response=sin(2*pi*ProbeF*(0:1/signal.chirpFs:2/ProbeF))/10;
impulse_response=impulse_response.*hanning(max(size(impulse_response)))';

fid1 = fopen('matlab2rom.coe','w');   %д��sin.coe�ļ���������ʼ��sin_rom
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