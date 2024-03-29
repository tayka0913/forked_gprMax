% 이론값 생성
f_peak = 220e6; % 피크 주파수 (단위: Hz)
iteration = 16960;
Time = 200e-9;
dt = Time / iteration; 
time = linspace(0, Time, iteration);
Fs=1/dt ;%샘플링 주파수 
t_max = Time; % 시간의 최대 값 (단위: 초)

%h5disp('case12_220MHz.out');
Ez = h5read('case17_320MHz_multi.out', '/rxs/rx1/Ez');
Eztr = Ez.';

Ez2 = h5read('case17_320MHz_multi.out', '/rxs/rx2/Ez');
Eztr2 = Ez2.';
Ez3 = h5read('case17_320MHz_multi.out', '/rxs/rx3/Ez');
Eztr3 = Ez3.';

% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(3, 1, 1);
plot(time, Eztr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('rx1에서 수신된 신호');

subplot(3, 1, 2);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('rx2에서 수신된 신호');

subplot(3, 1, 3);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('rx3에서 수신된 신호');
hold on;
hold off;
fontsize(14,"points")