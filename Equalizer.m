%get path of audio
[file,path]=uigetfile;
[y,Fs]=audioread(file);
%--------------------%
type=input('Welcome to the program!\nPlease choose the type of filter you want to use\n1-FIR\n2-IIR');
g1=input('enter the gain for the 1st band :');
g2=input('enter the gain for the 2nd band :');
g3=input('enter the gain for the 3rd band :');
g4=input('enter the gain for the 4th band :');
g5=input('enter the gain for the 5th band :');
g6=input('enter the gain for the 6th band :');
g7=input('enter the gain for the 7th band :');
g8=input('enter the gain for the 8th band :');
g9=input('enter the gain for the 9th band :');
Fsnew=input('select the rate of the sound for ex:if you want it to be in normal speed 1.00X enter 1');
Fout=Fsnew*Fs;
%----------------------------------%
%---------------FIR---------------%
switch(type)
    case(1)
        cut_off = 170/16000;
        order = 8;
        a= fir1(order,cut_off,'low');
        y1= g1*filter(a,1,y);
        %
        f1 = 171/16000;
        f2 = 310/16000;
        b1 = fir1(order,[f1 f2],'bandpass');
        y2=g2*filter(b1,1,y);
        %
        f3 = 311/16000;
        f4 = 600/16000;
        b2=fir1(order,[f3 f4],'bandpass');
        y3=g3*filter(b2,1,y);
        %
        f4 = 601/16000;
        f5 = 1000/16000;
        b3 = fir1(order,[f4 f5],'bandpass');
        y4 = g4*filter(b3,1,y);
        %
        f5 = 1001/16000;
        f6 = 3000/16000;
        b4 = fir1(order,[f5 f6],'bandpass');
        y5 = g5*filter(b4,1,y);
        %
        f7 = 3001/16000;
        f8 = 6000/16000;
        b5 = fir1(order,[f7 f8],'bandpass');
        y6 = g6*filter(b5,1,y);
        %
        f9 = 6001/16000;
        f10 = 12000/16000;
        b6 = fir1(order,[f9 f10],'bandpass');
        y7 = g7*filter(b6,1,y);
        %
        f11 = 12001/16000;
        f12 = 14000/16000;
        b7 = fir1(order,[f11 f12],'bandpass');
        y8 = g8*filter(b7,1,y);
        %
        f13 = 14001/16000;
        f14 = 15999/16000;
        b8 = fir1(order,[f13 f14],'bandpass');
        y9 = g8*filter(b7,1,y);
    case(2)
        cut_off = 170/16000;
        order=8;
        a=butter(order,cut_off,'low');
        y1=g1*filter(a,1,y);
        %
        f1=171/16000;
        f2=310/16000;
        b1=butter(order,[f1 f2],'bandpass');
        y2=g2*filter(b1,1,y);
        %
        f3=311/16000;
        f4=600/16000;
        b2=butter(order,[f3 f4],'bandpass');
        y3=g3*filter(b2,1,y);
        %
        f4=601/16000;
        f5=1000/16000;
        b3=butter(order,[f4 f5],'bandpass');
        y4=g4*filter(b3,1,y);
        %
        f5=1001/16000;
        f6=3000/16000;
        b4=butter(order,[f5 f6],'bandpass');
        y5=g5*filter(b4,1,y);
        %
        f7=3001/16000;
        f8=6000/16000;
        b5=butter(order,[f7 f8],'bandpass');
        y6=g6*filter(b5,1,y);
        %
        f9=6001/16000;
        f10=12000/16000;
        b6=butter(order,[f9 f10],'bandpass');
        y7=g7*filter(b6,1,y);
        %
        f11=12001/16000;
        f12=14000/16000;
        b7=butter(order,[f11 f12],'bandpass');
        y8=g8*filter(b7,1,y);
        %
        f13=14001/16000;
        f14=15999/16000;
        b8=butter(order,[f13 f14],'bandpass');
        y9=g8*filter(b7,1,y);
    otherwise
        fprintf("Please enter a valid choice");
        type=input('Please choose the type of filter you want to use\n1-FIR\n2-IIR');

end
%---------------------------%new file
out=y1+y2+y3+y4+y5+y6+y7+y8+y9;
audiowrite('edited.wav',out,Fout);
sound(out,Fout);
%----------------------------%plots
%Original signal
s1=y(:,1);%only get the first colum because the audio used it a stereo audio
t=1/Fs;
timeAxis=0:t:(length(s1)*t)-t;%no of seconds(duration) can be calculated as follow (making every second have Fs samples
figure
subplot(2,1,1)
plot(timeAxis,s1);xlabel('Time (seconds)');ylabel('Amplitude');
title('Original signal');
%Output Signal
s2=out(:,1);%only get the first colum because the audio used it a stereo audio
t=1/Fout;
timeAxisOut=0:t:(length(s2)*t)-t;%no of seconds(duration) can be calculated as follow (making every second have Fs samples
subplot(2,1,2)
plot(timeAxisOut,s1);xlabel('Time (seconds)');ylabel('Amplitude');
title('Output signal');
%-------------------------%
%Frequency donmain analysis
%Original signal
[sizey,o]=size(y);
duration=sizey/Fs;
Fvec=linspace(-Fs/2,Fs/2,duration*Fs);
yfreq=fftshift(fft(y));
figure
subplot(2,1,1)
magY=abs(yfreq);
magY=magY(:,1);
plot(Fvec,magY);
title('Original signal(magnituide)');
%-----------------------------%
%Output signal
[sizeyO,o]=size(out);
durationO=sizeyO/Fout;
FvecO=linspace(-Fout/2,Fout/2,durationO*Fout);
yfreqO=fftshift(fft(out));
subplot(2,1,2)
magYO=abs(yfreqO);
magYO=magYO(:,1);
plot(FvecO,abs(yfreqO));
title('Output signal(magnituide)');