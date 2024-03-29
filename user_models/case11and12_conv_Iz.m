%% case 11 120
% 이론값 생성
f_peak = 120e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak;

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
window_range = [3e-9, 18e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
ricker_windowed = ricker_wavelet(index_range);

% 2
% 각 구간 상대유전율 및 길이 설정
e1 = 27.23;
e2 = 1;
e3 = 27.23;
m1 = 0.5;
m2 = 0.5;
m3 = 1;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t1r = t1 * 2;
t2r = t2 * 2;
t3r = t3 * 2;

fprintf('첫번째 구간에서 반사되어 돌아오는 시간: %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간: %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간: %d \n', t3r);

% 3
% 수신1생성
h5disp('case11_120MHz.out');
Ez = h5read('case11_120MHz.out', '/rxs/rx1/Iz');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 윈도후한 리커파와 컨벌루션
conv_result = conv(Eztr, ricker_windowed, 'same');

end_index2 = find(time <= 25e-9, 1, 'last'); 
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 40e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(ricker_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(4, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('convolved Ez');

subplot(4, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('convolved Ez2');

subplot(4, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('convolved Ez3');


% 최대값의 인덱스 찾기
max_index1 = find(conv_result == max(conv_result), 1);
max_index2 = find(conv_result == max(conv_result2), 1);
max_index3 = find(conv_result == max(conv_result3), 1);


max_time1 = time(max_index1);
max_time2 = time(max_index2);
max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
time_difference2 = max_time3 - max_time2;

% 4. 결과 출력
disp(['Eztr의 최대값 위치 시간: ' num2str(max_time1) ' 초']);
disp(['Eztr2의 최대값 위치 시간: ' num2str(max_time2) ' 초']);
disp(['Eztr3의 최대값 위치 시간: ' num2str(max_time3) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(이론): ' num2str(t1) '초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(이론): ' num2str(t2-t1) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference1/2) ' 초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference2/2) ' 초']);
%% case 11 320
% 이론값 생성
f_peak = 320e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak;

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
window_range = [0, 10e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
ricker_windowed = ricker_wavelet(index_range);

% 2
% 각 구간 상대유전율 및 길이 설정
e1 = 6.25;
e2 = 1;
e3 = 6.25;
m1 = 0.5;
m2 = 0.5;
m3 = 1;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t1r = t1 * 2;
t2r = t2 * 2;
t3r = t3 * 2;

fprintf('첫번째 구간에서 반사되어 돌아오는 시간: %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간: %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간: %d \n', t3r);

% 3
% 수신1생성
h5disp('case11_320MHz.out');
Ez = h5read('case11_320MHz.out', '/rxs/rx1/Iz');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 윈도후한 리커파와 컨벌루션
conv_result = conv(Eztr, ricker_windowed, 'same');

end_index2 = find(time <= 8e-9, 1, 'last'); 
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 18e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(ricker_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(4, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('convolved Ez');

subplot(4, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('convolved Ez2');

subplot(4, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('convolved Ez3');


% 최대값의 인덱스 찾기
max_index1 = find(conv_result == max(conv_result), 1);
max_index2 = find(conv_result == max(conv_result2), 1);
max_index3 = find(conv_result == max(conv_result3), 1);


max_time1 = time(max_index1);
max_time2 = time(max_index2);
max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
time_difference2 = max_time3 - max_time2;

% 4. 결과 출력
disp(['Eztr의 최대값 위치 시간: ' num2str(max_time1) ' 초']);
disp(['Eztr2의 최대값 위치 시간: ' num2str(max_time2) ' 초']);
disp(['Eztr3의 최대값 위치 시간: ' num2str(max_time3) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(이론): ' num2str(t1) '초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(이론): ' num2str(t2-t1) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference1/2) ' 초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference2/2) ' 초']);
%% case 12 120
% 이론값 생성
f_peak = 120e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak;

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
window_range = [3e-9, 18e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
ricker_windowed = ricker_wavelet(index_range);

% 2
% 각 구간 상대유전율 및 길이 설정
e1 = 27.23;
e2 = 1;
e3 = 27.23;
m1 = 0.5;
m2 = 1;
m3 = 0.5;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t1r = t1 * 2;
t2r = t2 * 2;
t3r = t3 * 2;

fprintf('첫번째 구간에서 반사되어 돌아오는 시간: %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간: %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간: %d \n', t3r);

% 3
% 수신1생성
h5disp('case12_120MHz.out');
Ez = h5read('case12_120MHz.out', '/rxs/rx1/Iz');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 윈도우한 리커파와 컨벌루션
conv_result = conv(Eztr, ricker_windowed, 'same');

end_index2 = find(time <= 22e-9, 1, 'last'); 
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 38e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(ricker_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(4, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('convolved Ez');

subplot(4, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('convolved Ez2');

subplot(4, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('convolved Ez3');


% 최대값의 인덱스 찾기
max_index1 = find(conv_result == max(conv_result), 1);
max_index2 = find(conv_result == max(conv_result2), 1);
max_index3 = find(conv_result == max(conv_result3), 1);


max_time1 = time(max_index1);
max_time2 = time(max_index2);
max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
time_difference2 = max_time3 - max_time2;

% 4. 결과 출력
disp(['Eztr의 최대값 위치 시간: ' num2str(max_time1) ' 초']);
disp(['Eztr2의 최대값 위치 시간: ' num2str(max_time2) ' 초']);
disp(['Eztr3의 최대값 위치 시간: ' num2str(max_time3) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(이론): ' num2str(t1) '초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(이론): ' num2str(t2-t1) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference1/2) ' 초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference2/2) ' 초']);
%% case 12 320
% 이론값 생성
f_peak = 320e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak;

% Ricker Wavelet 생성
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
window_range = [0, 10e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
ricker_windowed = ricker_wavelet(index_range);

% 2
% 각 구간 상대유전율 및 길이 설정
e1 = 6.25;
e2 = 1;
e3 = 6.25;
m1 = 0.5;
m2 = 1;
m3 = 0.5;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t1r = t1 * 2;
t2r = t2 * 2;
t3r = t3 * 2;

fprintf('첫번째 구간에서 반사되어 돌아오는 시간: %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간: %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간: %d \n', t3r);

% 3
% 수신1생성
h5disp('case12_320MHz.out');
Ez = h5read('case12_320MHz.out', '/rxs/rx1/Iz');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 윈도후한 리커파와 컨벌루션
conv_result = conv(Eztr, ricker_windowed, 'same');

end_index2 = find(time <= 12e-9, 1, 'last'); 
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 25e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(ricker_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(4, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('convolved Ez');

subplot(4, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('convolved Ez2');

subplot(4, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('convolved Ez3');


% 최대값의 인덱스 찾기
max_index1 = find(conv_result == max(conv_result), 1);
max_index2 = find(conv_result == max(conv_result2), 1);
max_index3 = find(conv_result == max(conv_result3), 1);


max_time1 = time(max_index1);
max_time2 = time(max_index2);
max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
time_difference2 = max_time3 - max_time2;

% 4. 결과 출력
disp(['Eztr의 최대값 위치 시간: ' num2str(max_time1) ' 초']);
disp(['Eztr2의 최대값 위치 시간: ' num2str(max_time2) ' 초']);
disp(['Eztr3의 최대값 위치 시간: ' num2str(max_time3) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(이론): ' num2str(t1) '초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(이론): ' num2str(t2-t1) ' 초']);
disp(['첫 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference1/2) ' 초']);
disp(['첫 지점에서 두번째 지점까지 가는데 걸리는 시간(실험): ' num2str(time_difference2/2) ' 초']);
