%% case 12 송신을 가우스로 바꿔서 해보기 (컨볼루션)

% 이론값 생성
f_peak = 120e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = 1/f_peak;
zeta=2*(pi^2)*(f_peak^2);

% 가우시안 생성
gaussian = exp(-zeta* (t-delayed_time).^2);
% 컨벌루션 세팅 
window_range = [4e-9, 12e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));
gaussian_windowed = gaussian(index_range);
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

% 수신신호
%h5disp('case12_gauss_120MHz.out');
Ez = h5read('case12_gauss_120MHz.out', '/rxs/rx1/Hy');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 윈도우한 리커파와 컨벌루션
conv_result = conv(Eztr, gaussian_windowed, 'same');

end_index2 = find(time <= 15e-9, 1, 'last'); 
conv_result2= conv_result
conv_result2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 30e-9, 1, 'last'); 
conv_result3= conv_result
conv_result3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(gaussian_windowed, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('gaussian');
title('이론값');

subplot(4, 1, 2);
plot(time, conv_result, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hy');
title('Hy');

subplot(4, 1, 3);
plot(time, conv_result2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hy2');
title('Hy2');

subplot(4, 1, 4);
plot(time, conv_result3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Hy3');
title('Hy3');


% 최소값 위치 찾고 출력

% 최소값의 인덱스 찾기
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


%% case12 원본
% 1 
% 이론값 생성
f_peak = 120e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % -60ns~60ns
delayed_time = sqrt(2)/f_peak;

gaussian = exp(-zeta* (t-delayed_time).^2);
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
Ez = h5read('case12_gauss_120MHz.out', '/rxs/rx1/Hy');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 수신2 생성
end_index2 = find(time <= 20e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Eztr2= Eztr;
Eztr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 35e-9, 1, 'last'); 
Eztr3= Eztr;
Eztr3(1:end_index3) = 0;


% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(time, gaussian, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('gauss');
title('이론값');

subplot(4, 1, 2);
plot(time, Eztr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez');

subplot(4, 1, 3);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('Ez2');

subplot(4, 1, 4);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('Ez3');


% 최소값 위치 찾고 출력
% 가정: Eztr1은 신호를 나타냅니다.

% 최소값의 인덱스 찾기
max_index1 = find(Eztr == max(Eztr), 1);
max_index2 = find(Eztr == max(Eztr2), 1);
max_index3 = find(Eztr == max(Eztr3), 1);


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
