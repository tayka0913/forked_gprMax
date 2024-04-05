% 이론값 생성
f_peak = 220e6; % 피크 주파수 (단위: Hz)
iteration = 8481;
Time = 100e-9;
dt = Time / iteration; 
time = linspace(0, Time, iteration);
Fs=1/dt ;%샘플링 주파수 
t_max = Time; % 시간의 최대 값 (단위: 초)

%h5disp('case12_220MHz.out');
Ez = h5read('case18_220MHz_A.out', '/rxs/rx1/Ez');
Eztr = Ez.';

Ez2 = h5read('case18_220MHz_B.out', '/rxs/rx1/Ez');
Eztr2 = Ez2.';
Ez3 = h5read('case18_220MHz_C_20cm.out', '/rxs/rx1/Ez');
Eztr3 = Ez3.';
Ez4 = h5read('case18_220MHz_C_50cm.out', '/rxs/rx1/Ez');
Eztr4 = Ez4.';
Ez5 = h5read('case18_220MHz_D_20cm.out', '/rxs/rx1/Ez');
Eztr5 = Ez5.';
Ez6 = h5read('case18_220MHz_D_50cm.out', '/rxs/rx1/Ez');
Eztr6 = Ez6.';

%figure
figure;
subplot(6, 1, 1);
plot(time, Eztr ,'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx1에서 수신된 신호');

subplot(6, 1, 2);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx2에서 수신된 신호');

subplot(6, 1, 3);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx3에서 수신된 신호');
hold on;
hold off;
subplot(6, 1, 4);
plot(time, Eztr4, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx3에서 수신된 신호');
hold on;
hold off;
subplot(6, 1, 5);
plot(time, Eztr5, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx3에서 수신된 신호');
hold on;
hold off;
subplot(6, 1, 6);
plot(time, Eztr6, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
% title('rx3에서 수신된 신호');
hold on;
hold off;
% fontsize(14,"points")