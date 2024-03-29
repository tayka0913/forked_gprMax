%% Ez Output Structure Design
% 이론값 생성
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
% 수신1생성
h5disp('case1_2.0.out');
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 수신2 생성
end_index2 = find(time <= 10e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Eztr2= Eztr
Eztr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 30e-9, 1, 'last'); 
Eztr3= Eztr
Eztr3(1:end_index3) = 0;
% 수신4 생성
end_index4 = find(time <= 50e-9, 1, 'last'); 
Eztr4= Eztr
Eztr4(1:end_index4) = 0;

% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(5, 1, 1);
plot(time, ricker_wavelet, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(5, 1, 2);
plot(time, Eztr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez');
subplot(5, 1, 3);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('Ez2');
subplot(5, 1, 4);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('Ez3');
subplot(5, 1, 5);
plot(time, Eztr4, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez4');
title('Ez4');

% 최소값 위치 찾고 출력
% 가정: Eztr1은 신호를 나타냅니다.

% 최소값의 인덱스 찾기
min_index1 = find(Eztr == min(Eztr), 1);
min_index2 = find(Eztr == min(Eztr2), 1);
min_index3 = find(Eztr == min(Eztr3), 1);
min_index4 = find(Eztr == min(Eztr4), 1);

min_time1 = time(min_index1);
min_time2 = time(min_index2);
min_time3 = time(min_index3);
min_time4 = time(min_index4);

time_difference1 = min_time2 - min_time1;
time_difference2 = min_time3 - min_time2;
time_difference3 = min_time4 - min_time3;
% 결과 출력
disp(['Eztr의 최소값 위치 시간: ' num2str(min_time1) ' 초']);
disp(['Eztr2의 최소값 위치 시간: ' num2str(min_time2) ' 초']);
disp(['Eztr3의 최소값 위치 시간: ' num2str(min_time3) ' 초']);
disp(['Eztr4의 최소값 위치 시간: ' num2str(min_time4) ' 초']);
disp(['Eztr2 최소값 위치 시간 - Eztr 최소값 위치 시간: ' num2str(time_difference1) ' 초']);
disp(['Eztr3 최소값 위치 시간 - Eztr2 최소값 위치 시간: ' num2str(time_difference2) ' 초']);
disp(['Eztr4 최소값 위치 시간 - Eztr3 최소값 위치 시간: ' num2str(time_difference3) ' 초']);
%% Hy Output Structure Design
% 이론값 생성
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
% 수신1생성
h5disp('case1_2.0.out');
Hy = h5read('case1_2.0.out', '/rxs/rx1/Hy');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Hytr = Hy.';

% 수신2 생성
end_index2 = find(time <= 10e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Hytr2= Hytr
Hytr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 30e-9, 1, 'last'); 
Hytr3= Hytr
Hytr3(1:end_index3) = 0;
% 수신4 생성
end_index4 = find(time <= 50e-9, 1, 'last'); 
Hytr4= Hytr
Hytr4(1:end_index4) = 0;

% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(5, 1, 1);
plot(time, ricker_wavelet, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(5, 1, 2);
plot(time, Hytr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr');
title('Hytr');
subplot(5, 1, 3);
plot(time, Hytr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr2');
title('Hytr2');
subplot(5, 1, 4);
plot(time, Hytr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr3');
title('Hytr3');
subplot(5, 1, 5);
plot(time, Hytr4, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr4');
title('Hytr4');

% 최소값의 인덱스 찾기
min_index1 = find(Hytr == min(Hytr), 1);
min_index2 = find(Hytr == min(Hytr2), 1);
min_index3 = find(Hytr == min(Hytr3), 1);
min_index4 = find(Hytr == min(Hytr4), 1);

min_time1 = time(min_index1);
min_time2 = time(min_index2);
min_time3 = time(min_index3);
min_time4 = time(min_index4);

time_difference1 = min_time2 - min_time1;
time_difference2 = min_time3 - min_time2;
time_difference3 = min_time4 - min_time3;
% 결과 출력
disp(['Hytr의 최소값 위치 시간: ' num2str(min_time1) ' 초']);
disp(['Hytr2의 최소값 위치 시간: ' num2str(min_time2) ' 초']);
disp(['Hytr3의 최소값 위치 시간: ' num2str(min_time3) ' 초']);
disp(['Hytr4의 최소값 위치 시간: ' num2str(min_time4) ' 초']);
disp(['Hytr2 최소값 위치 시간 - Hytr 최소값 위치 시간: ' num2str(time_difference1) ' 초']);
disp(['Hytr3 최소값 위치 시간 - Hytr2 최소값 위치 시간: ' num2str(time_difference2) ' 초']);
disp(['Hytr4 최소값 위치 시간 - Hytr3 최소값 위치 시간: ' num2str(time_difference3) ' 초']);
%% Hy convolution
% 이론값 생성
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
% 리커파 쓸모있는 부분만 windowing
window_range = [0, 10e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
ricker_windowed = ricker_wavelet(index_range);

% Hy 생성
h5disp('case1_2.0.out');
Hy = h5read('case1_2.0.out', '/rxs/rx1/Hy');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Hytr = Hy.';
% 윈도후한 리커파와 컨벌루션
conv_result = conv(Hytr, ricker_windowed, 'same');

end_index2 = find(time <= 10e-9, 1, 'last'); % 10 ns의 인덱스 찾기
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 30e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;
% 수신4 생성
end_index4 = find(time <= 50e-9, 1, 'last'); 
conv_result4= conv_result
conv_result4(1:end_index4) = 0;
figure;
subplot(5, 1, 1);
plot(ricker_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('windowed이론값');
subplot(5, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr');
title('컨볼루션한 Hytr');
subplot(5, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr2');
title('컨볼루션한 Hytr2');
subplot(5, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hytr3');
title('컨볼루션한 Hytr3');
subplot(5, 1, 5);
plot(time, conv_result4, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('컨볼루션한 Hytr4');
title('Hytr4');
% 최소값의 인덱스 찾기
min_index1 = find(conv_result == min(conv_result), 1);
min_index2 = find(conv_result == min(conv_result2), 1);
min_index3 = find(conv_result == min(conv_result3), 1);
min_index4 = find(conv_result == min(conv_result4), 1);

min_time1 = time(min_index1);
min_time2 = time(min_index2);
min_time3 = time(min_index3);
min_time4 = time(min_index4);

time_difference1 = min_time2 - min_time1;
time_difference2 = min_time3 - min_time2;
time_difference3 = min_time4 - min_time3;
% 결과 출력
disp(['Hytr의 최소값 위치 시간: ' num2str(min_time1) ' 초']);
disp(['Hytr2의 최소값 위치 시간: ' num2str(min_time2) ' 초']);
disp(['Hytr3의 최소값 위치 시간: ' num2str(min_time3) ' 초']);
disp(['Hytr4의 최소값 위치 시간: ' num2str(min_time4) ' 초']);
disp(['Hytr2 최소값 위치 시간 - Hytr 최소값 위치 시간: ' num2str(time_difference1) ' 초']);
disp(['Hytr3 최소값 위치 시간 - Hytr2 최소값 위치 시간: ' num2str(time_difference2) ' 초']);
disp(['Hytr4 최소값 위치 시간 - Hytr3 최소값 위치 시간: ' num2str(time_difference3) ' 초']);