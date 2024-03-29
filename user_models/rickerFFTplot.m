%% 리커파 FFT 플로팅 (-max to max)
% 파형 생성을 위한 매개변수 설정
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = -t_max:dt:t_max; % -60ns~60ns

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 * (pi * f_peak * t).^2) .* exp(-(pi * f_peak * t).^2);

% FFT를 위한 주파수축 생성
N = 2^nextpow2(length(t)); % 전체 신호 개수 다음으로 큰 2의 거듭제곱의 지수를 곱해서 N값을 설정함
frequencies = linspace(-Fs/2, Fs/2, N); % -Fs/2 ~ -Fs/2로 주파수 축을 생성함

% FFT 수행
ricker_spectrum = abs(fftshift(fft(ricker_wavelet, N))); % N포인트FFT를 실행하고 FFTshift를 이용해 0주파수 성분을 스펙트럼 가운데로 이동시킴

% 파형 시각화 (시간축)
figure;
subplot(2,1,1);
plot(t, ricker_wavelet, 'LineWidth', 2);
title('Ricker Wavelet - 시간축');
xlabel('시간 (초)');
ylabel('신호 강도');

% 파형 시각화 (주파수축)
subplot(2,1,2);
plot(frequencies, ricker_spectrum, 'LineWidth', 2);
title('Ricker Wavelet - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');

% 그래픽 요소 조정
subplot(2,1,1);
xlim([-t_max, t_max]);
grid on;

subplot(2,1,2);
xlim([-1/(2*dt), 1/(2*dt)]);
grid on;

% notice
fprintf('샘플링주파수: %d \n', Fs);
fprintf('N값 : %d \n', N);
%% 리커파에서 원하는 구간만 잘라내기
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs = 1 / dt; % 샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = -t_max:dt:t_max; % -60ns ~ 60ns

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 * (pi * f_peak * t).^2) .* exp(-(pi * f_peak * t).^2);

% 원하는 구간만 선택하여 저장
window_range = [-4e-9, 4e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));

ricker_windowed = ricker_wavelet(index_range);

plot(t(index_range), ricker_windowed, 'LineWidth', 2);
%% 리커파 FFT 플로팅 (0 to max)
% 파형 생성을 위한 매개변수 설정
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)
time_delay= 10e-9

% 시간축 생성
t =0:dt:t_max; % -60ns~60ns

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 * (pi * f_peak * (t)).^2).* exp(-(pi * f_peak * (t)).^2);

% FFT를 위한 주파수축 생성
N = 2^nextpow2(length(t)); % 전체 신호 개수 다음으로 큰 2의 거듭제곱의 지수를 곱해서 N값을 설정함
frequencies = linspace(-Fs/2, Fs/2, N); % -Fs/2 ~ -Fs/2로 주파수 축을 생성함

% FFT 수행
ricker_spectrum = abs(fftshift(fft(ricker_wavelet, N))); % N포인트FFT를 실행하고 FFTshift를 이용해 0주파수 성분을 스펙트럼 가운데로 이동시킴

% 파형 시각화 (시간축)
figure;
subplot(2,1,1);
plot(t, ricker_wavelet, 'LineWidth', 2);
title('Ricker Wavelet - 시간축');
xlabel('시간 (초)');
ylabel('신호 강도');

% 파형 시각화 (주파수축)
subplot(2,1,2);
plot(frequencies, ricker_spectrum, 'LineWidth', 2);
title('Ricker Wavelet - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');

% 그래픽 요소 조정
subplot(2,1,1);
xlim([-t_max, t_max]);
grid on;

subplot(2,1,2);
xlim([-1/(2*dt), 1/(2*dt)]);
grid on;

% notice
fprintf('샘플링주파수: %d \n', Fs);
fprintf('N값 : %d \n', N);