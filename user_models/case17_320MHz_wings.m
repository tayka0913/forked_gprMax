%% case15 220MHz
% 이론값 생성
f_peak = 220e6; % 피크 주파수 (단위: Hz)
iteration = 16960;
Time = 200e-9;
dt = Time / iteration; 
time = linspace(0, Time, iteration);
Fs=1/dt ;%샘플링 주파수 
t_max = Time; % 시간의 최대 값 (단위: 초)

%h5disp('case12_220MHz.out');
Ez = h5read('case17_320MHz.out', '/rxs/rx1/Ez');
Eztr = Ez.';

Ez_Lside = h5read('case17_320MHz_Lside.out', '/rxs/rx1/Ez');
Eztr_Lside = Ez_Lside.';
Ez_Rside = h5read('case17_320MHz_Rside.out', '/rxs/rx1/Ez');
Eztr_Rside = Ez_Rside.';
% 시간축 생성
t = dt:dt:t_max; 
delayed_time = sqrt(2)/f_peak;
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
    
% 각 구간 상대유전율 및 길이 설정
e1 = 6.25;
e2 = 1;
e3 = 6.25;
m1 = 5;
m2 = 3;
m3 = 2;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
tr1 =t1*2;
tr2 =t2*2;
tr3 =t3*2;


end_index2 = find(time <= 75e-9, 1, 'last');
Eztr2= Eztr;
Eztr2(1:end_index2) = 0;
Eztr2_Lside= Eztr_Lside;
Eztr2_Lside(1:end_index2) = 0;
Eztr2_Rside= Eztr_Rside;
Eztr2_Rside(1:end_index2) = 0;
% % 수신3 생성
% end_index3 = find(time <= 60e-9, 1, 'last'); 
% Eztr3= Eztr;
% Eztr3(1:end_index3) = 0;

max_index1 = find(Eztr == max(Eztr), 1);
max_index2 = find(Eztr == max(Eztr2), 1);
% max_index3 = find(Eztr == max(Eztr3), 1);

max_time1 = time(max_index1);
max_time2 = time(max_index2);
% max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
% time_difference2 = max_time3 - max_time2;

t_calculation1=max_time1+tr1; % 예상지연시간1
t_calculation2=max_time1+tr2; % 예상지연시간2
t_calculation3=max_time1+tr3; % 예상지연시간3
% t_experiment1=time_difference1/2; % 실험 지연시간1
% t_experiment2=time_difference2/2; % 실험 지연시간2
%정규화
max_abs_value1 = max(abs(Eztr));
Eztr_norm1 = Eztr / max_abs_value1;
max_abs_value1_Lside = max(abs(Eztr_Lside));
Eztr_norm1_Lside = Eztr_Lside / max_abs_value1_Lside;
max_abs_value1_Rside = max(abs(Eztr_Rside));
Eztr_norm1_Rside = Eztr_Rside / max_abs_value1_Rside;

max_abs_value2 = max(abs(Eztr2));
Eztr_norm2 = Eztr2 / max_abs_value2;
max_abs_value2_Lside = max(abs(Eztr2_Lside));
Eztr_norm2_Lside = Eztr2_Lside / max_abs_value2_Lside;
max_abs_value2_Rside = max(abs(Eztr2_Rside));
Eztr_norm2_Rside = Eztr2_Rside / max_abs_value2_Rside;
% max_abs_value3 = max(abs(Eztr3));
% Eztr_norm3 = Eztr3 / max_abs_value3;

end_index2 = find(time <= 75e-9, 1, 'last'); 
Eztr_norm1(end_index2:end) = 0;
Eztr_norm1_Lside(end_index2:end) = 0;
Eztr_norm1_Lside(end_index2:end) = 0;
% end_index3 = find(time <= 56e-9, 1, 'last'); 
% Eztr_norm2(end_index3:end) = 0;

full_norm=Eztr_norm1+Eztr_norm2;
full_norm_Lside=Eztr_norm1_Lside+Eztr_norm2_Lside;
full_norm_Rside=Eztr_norm1_Lside+Eztr_norm2_Lside;
y_t_calculation1 = interp1(time, full_norm, t_calculation1, 'nearest');
y_t_calculation2 = interp1(time, full_norm, t_calculation2, 'nearest');
y_t_calculation3 = interp1(time, full_norm, t_calculation3, 'nearest');

% 이론 / 수신1/ 앞자른 수신2/ 앞2개자른 수신3 / 수신4
figure;
subplot(3, 1, 1);
plot(time, full_norm, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('정규화된 main에서 수신된 신호');

subplot(3, 1, 2);
plot(time, full_norm_Lside, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('정규화된 Lside에서 수신된 신호');

subplot(3, 1, 3);
plot(time, full_norm_Rside, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('정규화된 Rside에서 수신된 신호');
hold on;
hold off;
fontsize(14,"points")