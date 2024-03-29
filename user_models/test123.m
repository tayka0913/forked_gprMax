%% case14 mix
% 이론값 생성
f_peak_120 = 120e6; % 피크 주파수 (단위: Hz)
f_peak_320 = 320e6;
dt = 80e-9 / 6785; % 샘플링 간격 (단위: 초)
Fs=1/dt ;%샘플링 주파수   
t_max = 80e-9; % 시간의 최대 값 (단위: 초)

% 시간축 생성
t = dt:dt:t_max; % 0ns~300ns
delayed_time_120 = sqrt(2)/f_peak_120;
delayed_time_320 = sqrt(2)/f_peak_320;
ricker_wavelet_120 = (1 - 2 *( pi * f_peak_120 * (t-delayed_time_120)).^2) .* exp(-(pi * f_peak_120 * (t-delayed_time_120)).^2);
ricker_wavelet_320 = (1 - 2 *( pi * f_peak_320 * (t-delayed_time_320)).^2) .* exp(-(pi * f_peak_320 * (t-delayed_time_320)).^2);
      
% 각 구간 상대유전율 및 길이 설정
e1_120 = 27.23;
e2_120 = 1;
e3_120 = 27.23;
m1_120 = 5;
m2_120 = 3;
m3_120 = 2;

e1_320 = 6.25;
e2_320 = 1;
e3_320 = 6.25;
m1_320 = 5;
m2_320 = 3;
m3_320 = 2;

c = 3e8;

v1_120 = c / sqrt(e1_120);
v2_120 = c / sqrt(e2_120);
v3_120 = c / sqrt(e3_120);
t1_120 = m1_120 / v1_120;
t2_120 = t1_120+(m2_120 / v2_120);
t3_120 = t2_120+(m3_120 / v3_120);
tr1_120 =t1_120*2;
tr2_120 =t2_120*2;
tr3_120 =t3_120*2;

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
Ez_120 = h5read('case15_220MHz.out', '/rxs/rx1/Ez');
Ez_320 = h5read('case15_320MHz.out', '/rxs/rx1/Ez');
iteration = 6785;
Time = 80e-9;
time = linspace(0, Time, iteration);
Eztr_120 = Ez_120.';
Eztr_320 = Ez_320.';

% 구간자르기 1
end_index2_120 = find(time <= 30e-9, 1, 'last'); 
Eztr2_120= Eztr_120;
Eztr2_120(1:end_index2_120) = 0;

end_index2_320 = find(time <= 80e-9, 1, 'last'); 
Eztr2_320= Eztr_320;
Eztr2_320(1:end_index2_320) = 0;

% 구간자르기2
end_index3_120 = find(time <= 197e-9, 1, 'last'); 
Eztr3_120= Eztr_120;
Eztr3_120(1:end_index3_120) = 0;
end_index3_320 = find(time <= 100e-9, 1, 'last'); 
Eztr3_320= Eztr_320;
Eztr3_320(1:end_index3_320) = 0;

% 최대값 찾기
max_index1_120 = find(Eztr_120 == max(Eztr_120), 1);
max_index2_120 = find(Eztr_120 == max(Eztr2_120), 1);
max_index3_120 = find(Eztr_120 == max(Eztr3_120), 1);

max_index1_320 = find(Eztr_320 == max(Eztr_320), 1);
max_index2_320 = find(Eztr_320 == max(Eztr2_320), 1);
max_index3_320 = find(Eztr_320 == max(Eztr3_320), 1);

max_time1_120 = time(max_index1_120);
max_time2_120 = time(max_index2_120);
max_time3_120 = time(max_index3_120);

max_time1_320 = time(max_index1_320);
max_time2_320 = time(max_index2_320);
max_time3_320 = time(max_index3_320);

time_difference1_120 = max_time2_120 - max_time1_120;
time_difference2_120 = max_time3_120 - max_time2_120;

time_difference1_320 = max_time2_320 - max_time1_320;
time_difference2_320 = max_time3_320 - max_time2_320;

t_calculation1_120=max_time1_120+tr1_120; % 예상지연시간1
t_calculation2_120=max_time1_120+tr2_120; % 예상지연시간2
t_calculation3_120=max_time1_120+tr3_120; % 예상지연시간3
t_experiment1_120=time_difference1_120/2; % 실험 지연시간1
t_experiment2_120=time_difference2_120/2; % 실험 지연시간2

t_calculation1_320=max_time1_320+tr1_320; % 예상지연시간1
t_calculation2_320=max_time1_320+tr2_320; % 예상지연시간2
t_calculation3_320=max_time1_320+tr3_320; % 예상지연시간3
t_experiment1_320=time_difference1_320/2; % 실험 지연시간1
t_experiment2_320=time_difference2_320/2; % 실험 지연시간2

%정규화
max_abs_value1_120 = max(abs(Eztr_120));
Eztr_norm1_120 = Eztr_120 / max_abs_value1_120;
max_abs_value2_120 = max(abs(Eztr2_120));
Eztr_norm2_120 = Eztr2_120 / max_abs_value2_120;
max_abs_value3_120 = max(abs(Eztr3_120));
Eztr_norm3_120 = Eztr3_120 / max_abs_value3_120;

max_abs_value1_320 = max(abs(Eztr_320));
Eztr_norm1_320 = Eztr_320 / max_abs_value1_320;
max_abs_value2_320 = max(abs(Eztr2_320));
Eztr_norm2_320 = Eztr2_320 / max_abs_value2_320;
max_abs_value3_320 = max(abs(Eztr3_320));
Eztr_norm3_320 = Eztr3_320 / max_abs_value3_320;

% 정규화 합치기 전 구간 뒷부분 0으로 만들기
end_index2_120 = find(time <= 30e-9, 1, 'last'); 
Eztr_norm1_120(end_index2_120:end) = 0;
% end_index3_120 = find(time <= 197e-9, 1, 'last'); 
% Eztr_norm2_120(end_index3_120:end) = 0;

end_index2_320 = find(time <= 80e-9, 1, 'last'); 
Eztr_norm1_320(end_index2_320:end) = 0;
% end_index3_320 = find(time <= 100e-9, 1, 'last'); 
% Eztr_norm2_320(end_index3_320:end) = 0;

%정규화 합치고 이론지연시간에서의 y값 가져오기
full_norm_120=Eztr_norm1_120+Eztr_norm2_120+Eztr_norm3_120;
y_t_calculation1_120 = interp1(time, full_norm_120, t_calculation1_120, 'nearest');
y_t_calculation2_120 = interp1(time, full_norm_120, t_calculation2_120, 'nearest');
y_t_calculation3_120 = interp1(time, full_norm_120, t_calculation3_120, 'nearest');

full_norm_320=Eztr_norm1_320+Eztr_norm2_320+Eztr_norm3_320;
y_t_calculation1_320 = interp1(time, full_norm_320, t_calculation1_320, 'nearest');
y_t_calculation2_320 = interp1(time, full_norm_320, t_calculation2_320, 'nearest');
y_t_calculation3_320 = interp1(time, full_norm_320, t_calculation3_320, 'nearest');


%120MHz Ez
subplot(4, 1, 1);
plot(time, Eztr_120, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez 220MHz');
fontsize(16,"points")
%320MHz Ez
subplot(4, 1, 2);
plot(time, Eztr_320, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez 320MHz');
fontsize(16,"points")
% 정규화한 120MHz Ez와 이론값표시
subplot(4, 1, 3);
plot(time, full_norm_120, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez normalized 120MHz');
hold on;
scatter(max_time1_120,full_norm_120(time==max_time1_120),100,"black","filled")
scatter(t_calculation1_120,y_t_calculation1_120,100,[0 0.4470 0.7410],"filled")%파란색
scatter(t_calculation2_120,y_t_calculation2_120,100,[0.8500 0.3250 0.0980],"filled")%황토색
% scatter(t_calculation3_120,y_t_calculation3_120,100,[0.4940 0.1840 0.5560],"filled")%보라색
hold off;

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
% scatter(t_calculation3_320,y_t_calculation3_320,100,[0.4940 0.1840 0.5560],"filled")%보라색
hold off;

