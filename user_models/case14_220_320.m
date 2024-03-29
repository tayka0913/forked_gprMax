%% case14 mix
% 이론값 생성
f_peak_220= 220e6; % 피크 주파수 (단위: Hz)
f_peak_320 = 320e6;
dt = 300e-9 / 25440; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수   
t_max = 300e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % 0ns~300ns
delayed_time_220 = sqrt(2)/f_peak_220;
delayed_time_320 = sqrt(2)/f_peak_320;
ricker_wavelet_220 = (1 - 2 *( pi * f_peak_220 * (t-delayed_time_220)).^2) .* exp(-(pi * f_peak_220 * (t-delayed_time_220)).^2);
ricker_wavelet_320 = (1 - 2 *( pi * f_peak_320 * (t-delayed_time_320)).^2) .* exp(-(pi * f_peak_320 * (t-delayed_time_320)).^2);
      
% 각 구간 상대유전율 및 길이 설정
e1_220 = 8.14;
e2_220 = 1;
e3_220 = 8.14;
m1_220 = 5;
m2_220 = 3;
m3_220 = 2;

e1_320 = 6.25;
e2_320 = 1;
e3_320 = 6.25;
m1_320 = 5;
m2_320 = 3;
m3_320 = 2;

c = 3e8;

v1_220 = c / sqrt(e1_220);
v2_220 = c / sqrt(e2_220);
v3_220 = c / sqrt(e3_220);
t1_220 = m1_220 / v1_220;
t2_220 = t1_220+(m2_220 / v2_220);
t3_220 = t2_220+(m3_220 / v3_220);
tr1_220 =t1_220*2;
tr2_220 =t2_220*2;
tr3_220 =t3_220*2;

v1_320 = c / sqrt(e1_320);
v2_320 = c / sqrt(e2_320);
v3_320 = c / sqrt(e3_320);
t1_320 = m1_320 / v1_320;
t2_320 = t1_320+(m2_320 / v2_320);
t3_320 = t2_320+(m3_320 / v3_320);
tr1_320 =t1_320*2;
tr2_320 =t2_320*2;
tr3_320 =t3_320*2;

% Ez 받아오기
Ez_220 = h5read('case14_220MHz.out', '/rxs/rx1/Ez');
Ez_320 = h5read('case14_320MHz.out', '/rxs/rx1/Ez');
iteration = 25440;
Time = 300e-9;
time = linspace(0, Time, iteration);
Eztr_220 = Ez_220.';
Eztr_320 = Ez_320.';

% 구간자르기 1
end_index2_220 = find(time <= 94e-9, 1, 'last'); 
Eztr2_220= Eztr_220;
Eztr2_220(1:end_index2_220) = 0;

end_index2_320 = find(time <= 80e-9, 1, 'last'); 
Eztr2_320= Eztr_320;
Eztr2_320(1:end_index2_320) = 0;

% 구간자르기2
end_index3_220 = find(time <= 116e-9, 1, 'last'); 
Eztr3_220= Eztr_220;
Eztr3_220(1:end_index3_220) = 0;
end_index3_320 = find(time <= 100e-9, 1, 'last'); 
Eztr3_320= Eztr_320;
Eztr3_320(1:end_index3_320) = 0;

% 최대값 찾기
max_index1_220 = find(Eztr_220 == max(Eztr_220), 1);
max_index2_220 = find(Eztr_220 == max(Eztr2_220), 1);
max_index3_220 = find(Eztr_220 == max(Eztr3_220), 1);

max_index1_320 = find(Eztr_320 == max(Eztr_320), 1);
max_index2_320 = find(Eztr_320 == max(Eztr2_320), 1);
max_index3_320 = find(Eztr_320 == max(Eztr3_320), 1);

max_time1_220 = time(max_index1_220);
max_time2_220 = time(max_index2_220);
max_time3_220 = time(max_index3_220);

max_time1_320 = time(max_index1_320);
max_time2_320 = time(max_index2_320);
max_time3_320 = time(max_index3_320);

time_difference1_220 = max_time2_220 - max_time1_220;
time_difference2_220 = max_time3_220 - max_time2_220;

time_difference1_320 = max_time2_320 - max_time1_320;
time_difference2_320 = max_time3_320 - max_time2_320;

t_calculation1_220=max_time1_220+tr1_220; % 예상지연시간1
t_calculation2_220=max_time1_220+tr2_220; % 예상지연시간2
t_calculation3_220=max_time1_220+tr3_220; % 예상지연시간3
t_experiment1_220=time_difference1_220/2; % 실험 지연시간1
t_experiment2_220=time_difference2_220/2; % 실험 지연시간2

t_calculation1_320=max_time1_320+tr1_320; % 예상지연시간1
t_calculation2_320=max_time1_320+tr2_320; % 예상지연시간2
t_calculation3_320=max_time1_320+tr3_320; % 예상지연시간3
t_experiment1_320=time_difference1_320/2; % 실험 지연시간1
t_experiment2_320=time_difference2_320/2; % 실험 지연시간2

%정규화
max_abs_value1_220 = max(abs(Eztr_220));
Eztr_norm1_220 = Eztr_220 / max_abs_value1_220;
max_abs_value2_220 = max(abs(Eztr2_220));
Eztr_norm2_220 = Eztr2_220 / max_abs_value2_220;
max_abs_value3_220 = max(abs(Eztr3_220));
Eztr_norm3_220 = Eztr3_220 / max_abs_value3_220;

max_abs_value1_320 = max(abs(Eztr_320));
Eztr_norm1_320 = Eztr_320 / max_abs_value1_320;
max_abs_value2_320 = max(abs(Eztr2_320));
Eztr_norm2_320 = Eztr2_320 / max_abs_value2_320;
max_abs_value3_320 = max(abs(Eztr3_320));
Eztr_norm3_320 = Eztr3_320 / max_abs_value3_320;

% 정규화 합치기 전 구간 뒷부분 0으로 만들기
end_index2_220 = find(time <= 94e-9, 1, 'last'); 
Eztr_norm1_220(end_index2_220:end) = 0;
end_index3_220 = find(time <= 116e-9, 1, 'last'); 
Eztr_norm2_220(end_index3_220:end) = 0;

end_index2_320 = find(time <= 80e-9, 1, 'last'); 
Eztr_norm1_320(end_index2_320:end) = 0;
end_index3_320 = find(time <= 100e-9, 1, 'last'); 
Eztr_norm2_320(end_index3_320:end) = 0;

%정규화 합치고 이론지연시간에서의 y값 가져오기
full_norm_220=Eztr_norm1_220+Eztr_norm2_220+Eztr_norm3_220;
y_t_calculation1_220 = interp1(time, full_norm_220, t_calculation1_220, 'nearest');
y_t_calculation2_220 = interp1(time, full_norm_220, t_calculation2_220, 'nearest');
y_t_calculation3_220 = interp1(time, full_norm_220, t_calculation3_220, 'nearest');

full_norm_320=Eztr_norm1_320+Eztr_norm2_320+Eztr_norm3_320;
y_t_calculation1_320 = interp1(time, full_norm_320, t_calculation1_320, 'nearest');
y_t_calculation2_320 = interp1(time, full_norm_320, t_calculation2_320, 'nearest');
y_t_calculation3_320 = interp1(time, full_norm_320, t_calculation3_320, 'nearest');

% %플로팅
% figure;
% %120MHz 리커파
% subplot(6, 1, 1);
% plot(time, ricker_wavelet_120, 'b', 'LineWidth', 2);
% xlabel('Time (s)');
% ylabel('ricker');
% title('ricker wavelet 120MHz');
% 
% %320Hz 리커파
% subplot(6, 1, 2);
% plot(time, ricker_wavelet_320, 'b', 'LineWidth', 2);
% xlabel('Time (s)');
% ylabel('ricker');
% title('ricker wavelet 320MHz');

%120MHz Ez
subplot(4, 1, 1);
plot(time, Eztr_220, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez 220MHz');

%320MHz Ez
subplot(4, 1, 2);
plot(time, Eztr_320, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez 320MHz');

% 정규화한 120MHz Ez와 이론값표시
subplot(4, 1, 3);
plot(time, full_norm_220, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez normalized 220MHz');
hold on;
scatter(max_time1_220,full_norm_220(time==max_time1_220),100,"black","filled")
scatter(t_calculation1_220,y_t_calculation1_220,100,[0 0.4470 0.7410],"filled")%파란색
scatter(t_calculation2_220,y_t_calculation2_220,100,[0.8500 0.3250 0.0980],"filled")%황토색
% scatter(max_time2_220, full_norm_220(time == max_time2_220), 50, "green", "filled", "^") % 초록색 역삼각형
% scatter(max_time3_220, full_norm_220(time == max_time3_220), 50, "magenta", "filled", "^") % 자주색 역삼각형
hold off;
fontsize(16,"points")

% 정규화한 120MHz Ez와 이론값표시
subplot(4, 1, 4);
plot(time, full_norm_320, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez normalized 320MHz');
hold on;
scatter(max_time1_320,full_norm_320(time==max_time1_320),100,"black","filled")
scatter(t_calculation1_320,y_t_calculation1_320,100,[0 0.4470 0.7410],"filled")%파란색
scatter(t_calculation2_320,y_t_calculation2_320,100,[0.8500 0.3250 0.0980],"filled")%황토색
% scatter(max_time2_320, full_norm_320(time == max_time2_320), 50, "green", "filled", "^") % 초록색 역삼각형
% scatter(max_time3_320, full_norm_320(time == max_time3_320), 50, "magenta", "filled", "^") % 자주색 역삼각형
hold off;
fontsize(16,"points")

