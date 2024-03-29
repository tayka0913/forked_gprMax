%gprMax 8th (120MHz)
% 목표: 1.입력신호 만들고, case11 120Mhz의 Ez값 가져오기 (나중에 Hy도)
% 2. 예상 왕복시간 계산하여 플롯하기
% 3. 윈도윙한 리커파와 컨벌루션한 결과 단계별로 출력하기
% 4. 단계별 맥시멈 지점 기억해서 맥시멈간 시간차이 확인하기
% 위 과정을 똑같이 320MHz에 적용시켜서 두개 비교하기

% 1 
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
Ez = h5read('case11_120MHz.out', '/rxs/rx1/Ez');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 수신2 생성
end_index2 = find(time <= 20e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Eztr2= Eztr;
Eztr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 40e-9, 1, 'last'); 
Eztr3= Eztr;
Eztr3(1:end_index3) = 0;
% 수신4 생성
%end_index4 = find(time <= 55e-9, 1, 'last'); 
%Eztr4= Eztr
%Eztr4(1:end_index4) = 0;

% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(4, 1, 1);
plot(time, ricker_wavelet, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ricker Wavelet');
title('이론값');

subplot(4, 1, 2);
plot(time, Eztr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
subplot(4, 1, 3);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('Ez2');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
subplot(4, 1, 4);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('Ez3');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
%subplot(5, 2, 9);
%plot(time, Eztr4, 'r', 'LineWidth', 2);
%xlabel('Time (s)');
%ylabel('Ez4');
%title('Ez4');

% 최소값 위치 찾고 출력
% 가정: Eztr1은 신호를 나타냅니다.

% 최소값의 인덱스 찾기
min_index1 = find(Eztr == min(Eztr), 1);
min_index2 = find(Eztr == min(Eztr2), 1);
min_index3 = find(Eztr == min(Eztr3), 1);
%min_index4 = find(Eztr == min(Eztr4), 1);

min_time1 = time(min_index1);
min_time2 = time(min_index2);
min_time3 = time(min_index3);
%min_time4 = time(min_index4);

time_difference1 = min_time2 - min_time1;
time_difference2 = min_time3 - min_time2;
%time_difference3 = min_time4 - min_time3;
% 4. 결과 출력
disp(['Eztr의 최소값 위치 시간: ' num2str(min_time1) ' 초']);
disp(['Eztr2의 최소값 위치 시간: ' num2str(min_time2) ' 초']);
disp(['Eztr3의 최소값 위치 시간: ' num2str(min_time3) ' 초']);
%disp(['Eztr4의 최소값 위치 시간: ' num2str(min_time4) ' 초']);
disp(['Eztr2 최소값 위치 시간 - Eztr 최소값 위치 시간: ' num2str(time_difference1) ' 초']);
disp(['Eztr3 최소값 위치 시간 - Eztr2 최소값 위치 시간: ' num2str(time_difference2) ' 초']);
%disp(['Eztr4 최소값 위치 시간 - Eztr3 최소값 위치 시간: ' num2str(time_difference3) ' 초']);

%% 320MHz
% 1 
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
Ez = h5read('case11_320MHz.out', '/rxs/rx1/Ez');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';

% 수신2 생성
end_index2 = find(time <= 10e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Eztr2= Eztr;
Eztr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 30e-9, 1, 'last'); 
Eztr3= Eztr;
Eztr3(1:end_index3) = 0;
% 수신4 생성
end_index4 = find(time <= 50e-9, 1, 'last'); 
Eztr4= Eztr;
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
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
subplot(5, 1, 3);
plot(time, Eztr2, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez2');
title('Ez2');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
subplot(5, 1, 4);
plot(time, Eztr3, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez3');
title('Ez3');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
subplot(5, 1, 5);
plot(time, Eztr4, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez4');
title('Ez4');
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
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
% 4. 결과 출력
disp(['Eztr의 최소값 위치 시간: ' num2str(min_time1) ' 초']);
disp(['Eztr2의 최소값 위치 시간: ' num2str(min_time2) ' 초']);
disp(['Eztr3의 최소값 위치 시간: ' num2str(min_time3) ' 초']);
disp(['Eztr4의 최소값 위치 시간: ' num2str(min_time4) ' 초']);
disp(['Eztr2 최소값 위치 시간 - Eztr 최소값 위치 시간: ' num2str(time_difference1) ' 초']);
disp(['Eztr3 최소값 위치 시간 - Eztr2 최소값 위치 시간: ' num2str(time_difference2) ' 초']);
disp(['Eztr4 최소값 위치 시간 - Eztr3 최소값 위치 시간: ' num2str(time_difference3) ' 초']);
