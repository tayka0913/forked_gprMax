%% Ez FFT 플로팅 
h5disp('case10.out'); % 아웃풋 파일 구성요소 확인
Ez = h5read('case10.out', '/rxs/rx1/Ez'); % ez값 추출해서 data에 입력
Hx = h5read('case10.out', '/rxs/rx1/Hx')
Hy = h5read('case10.out', '/rxs/rx1/Hy')
iteration = 5089;
Time = 60e-9;
time = linspace(0,Time,iteration) 
Eztr = Ez.';
Hxtr = Hx.';
Hytr = Hy.';

dt=Time/iteration
Fs=1/dt

% FFT를 위한 주파수축 생성
N = 2^nextpow2(length(Eztr)); % 전체 신호 개수 다음으로 큰 2의 거듭제곱의 지수를 곱해서 N값을 설정함
frequencies = linspace(-Fs/2, Fs/2, N); % -Fs/2 ~ -Fs/2로 주파수 축을 생성함

% FFT 수행
Ez_spectrum = abs(fftshift(fft(Eztr, N))); % N포인트FFT를 실행하고 FFTshift를 이용해 0주파수 성분을 스펙트럼 가운데로 이동시킴
Hx_spectrum = abs(fftshift(fft(Hxtr, N)));
Hy_spectrum = abs(fftshift(fft(Hytr, N)));
% Ez (시간축)
figure;
subplot(2,3,1);
plot(time, Eztr, 'LineWidth', 2);
title('Ez - 시간축');
xlabel('시간 (초)');
ylabel('신호 강도');
xlim([0, Time]);
grid on;

% Ez (주파수축)
subplot(2,3,4);
plot(frequencies, Ez_spectrum, 'LineWidth', 2);
title('Ez - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');
xlim([-1/(2*dt), 1/(2*dt)]);
grid on;
% Hx (시간축)
subplot(2,3,2);
plot(time, Hxtr, 'LineWidth', 2);
title('Hx - 시간축');
xlabel('시간 (초)');
ylabel('신호 강도');
xlim([0, Time]);
grid on;

% Hx (주파수축)
subplot(2,3,5);
plot(frequencies, Hx_spectrum, 'LineWidth', 2);
title('Hx - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');
xlim([-1/(2*dt), 1/(2*dt)]);
grid on;
% Hy (시간축)
subplot(2,3,3);
plot(time, Hytr, 'LineWidth', 2);
title('Hy - 시간축');
xlabel('시간 (초)');
ylabel('신호 강도');
xlim([0, Time]);
grid on;

% Hy (주파수축)
subplot(2,3,6);
plot(frequencies, Hy_spectrum, 'LineWidth', 2);
title('Hy - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');
xlim([-1/(2*dt), 1/(2*dt)]);
grid on;


% notice
fprintf('샘플링주파수: %d \n', Fs);
fprintf('N값 : %d \n', N);
%% FFT만 나오게 
h5disp('case1_2.0.out'); % 아웃풋 파일 구성요소 확인
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez'); % ez값 추출해서 data에 입력
iteration = 5089;
Time = 60e-9;
time = linspace(0,Time,iteration) 
Eztr = Ez.';

dt=Time/iteration;
Fs=1/dt;

% FFT를 위한 주파수축 생성
N = 2^nextpow2(length(Eztr)); % 전체 신호 개수 다음으로 큰 2의 거듭제곱의 지수를 곱해서 N값을 설정함
frequencies = linspace(-Fs/2, Fs/2, N); % -Fs/2 ~ -Fs/2로 주파수 축을 생성함

% FFT 수행
Ez_spectrum = abs(fftshift(fft(Eztr, N))); % N포인트FFT를 실행하고 FFTshift를 이용해 0주파수 성분을 스펙트럼 가운데로 이동시킴

plot(frequencies, Ez_spectrum, 'LineWidth', 2);
xlim([-Fs/2, Fs/2]);
title('Ez - 주파수축');
xlabel('주파수 (Hz)');
ylabel('주파수 스펙트럼');