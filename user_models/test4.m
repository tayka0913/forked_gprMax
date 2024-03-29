%% 벡터 자르기

h5disp('case1_2.0.out'); % 아웃풋 파일 구성요소 확인
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez'); % ez값 추출해서 data에 입력
iteration = 5089;
Time = 60e-9;
time = linspace(0,Time,iteration) 
Eztr = Ez.';
N= 2^12 % N의 크기를 2^12로 지정

Eztr_cut = Eztr(1:N); 
time_cut=time(1:N); %data와 time의 크기를 N으로 맞춤

plot(time_cut,Eztr_cut);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength with Peaks');
grid on;
hold off;

%% 리커파 FFT 플롯
f = 300e6; % Frequency (Hz)
iteration = 5089;
Time = 60e-9;
dt=Time/iteration
t = linspace(-Time,Time,iteration)

Fs= 1/dt

N=2^12
%t_cut=t(1:N)
% Generate Ricker wavelet
%w = (1 - 2*(pi*f*t_cut).^2) .* exp(-(pi*f*t_cut).^2);
w = (1 - 2*(pi*f*t).^2) .* exp(-(pi*f*t).^2);
% FFT 수행
fft_result = fft(w,N);
%plot(t, w);
% 주파수 계산
frequencies = (0:1:length(fft_result)-1) * Fs/length(fft_result);
fshift=(-N/2:N/2-1)*(Fs/N)

plot(fshift, abs(fft_result));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('FFT of Ricker Wavelet')
%% 
Time= 60e-9
iteration= 5089
dt=Time/iteration
df=1/dt
fprintf('샘플링주파수: %d \n', df);
%% 리커파 FFT 플롯
f = 1; % Frequency (Hz)
iteration = 5089;
Time = 60e-9;
dt=Time/iteration
t = linspace(-Time,Time,iteration)
Fs= 1/dt
N=2^12
w = (1 - 2*(pi*f*t).^2) .* exp(-(pi*f*t).^2);
% FFT 수행
fft_result = fft(w,N);
%plot(t, w);
% 주파수 계산
frequencies = (0:1:length(fft_result)-1) * Fs/length(fft_result);
fshift=(-N/2:N/2-1)*(Fs/N)

plot(fshift, abs(fft_result));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('FFT of Ricker Wavelet')
%%
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

t = -t_max:dt:t_max; % -60ns~60ns

ricker_wavelet = (1 - 2 * (pi * f_peak * t).^2) .* exp(-(pi * f_peak * t).^2);