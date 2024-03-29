%% case18 320MHz 
% 이론값 생성
f_peak = 220e6; % 피크 주파수 (단위: Hz)
iteration = 8481;
Time = 100e-9;
dt = Time / iteration; 
time = linspace(0, Time, iteration);
Fs=1/dt ;%샘플링 주파수 
t_max = Time; % 시간의 최대 값 (단위: 초)

%h5disp('case12_220MHz.out');
Ez = h5read('case18_220MHz_C_20cm.out', '/rxs/rx1/Ez');
Eztr = Ez.';

% 시간축 생성
t = dt:dt:t_max; 
delayed_time = sqrt(2)/f_peak;
ricker_wavelet = (1 - 2 *( pi * f_peak * (t-delayed_time)).^2) .* exp(-(pi * f_peak * (t-delayed_time)).^2);
    
% 각 구간 상대유전율 및 길이 설정
e1 = 8.14; e2 = 11; e3 = 8.14; e4 = 1; e5 = 8.14;
m1 = 2.8; m2 = 0.2; m3 = 0; m4 = 1; m5 = 1;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
v4 = c / sqrt(e4);
v5 = c / sqrt(e5);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t4 = t3+(m4 / v4);
t5 = t4+(m5 / v5);
tr1 =t1*2;
tr2 =t2*2;
tr3 =t3*2;
tr4 =t4*2;
tr5 =t5*2;


% 수신2 생성
end_index2 = find(time <= 11.4e-9, 1, 'last'); % 10 ns의 인덱스 찾기
Eztr2= Eztr;
Eztr2(1:end_index2) = 0;
% 수신3 생성
end_index3 = find(time <= 38e-9, 1, 'last'); 
Eztr3= Eztr;
Eztr3(1:end_index3) = 0;

max_index1 = find(Eztr == max(Eztr), 1);
max_index2 = find(Eztr == max(Eztr2), 1);
max_index3 = find(Eztr == max(Eztr3), 1);

max_time1 = time(max_index1);
max_time2 = time(max_index2);
max_time3 = time(max_index3);

time_difference1 = max_time2 - max_time1;
% time_difference2 = max_time3 - max_time2;

t_calculation1=max_time1+tr1; % 예상지연시간1
t_calculation2=max_time1+tr2; % 예상지연시간2
t_calculation3=max_time1+tr3; % 예상지연시간3
t_calculation4=max_time1+tr4; % 예상지연시간3
t_calculation5=max_time1+tr5; % 예상지연시간3
% t_experiment1=time_difference1/2; % 실험 지연시간1
% t_experiment2=time_difference2/2; % 실험 지연시간2
%정규화
max_abs_value1 = max(abs(Eztr));
Eztr_norm1 = Eztr / max_abs_value1;
max_abs_value2 = max(abs(Eztr2));
Eztr_norm2 = Eztr2 / max_abs_value2;
max_abs_value3 = max(abs(Eztr3));
Eztr_norm3 = Eztr3 / max_abs_value3;

end_index2 = find(time <= 11.4e-9, 1, 'last'); 
Eztr_norm1(end_index2:end) = 0;
end_index3 = find(time <= 38e-9, 1, 'last'); 
Eztr_norm2(end_index3:end) = 0;

full_norm=Eztr_norm1+Eztr_norm2+Eztr_norm3;
y_t_calculation1 = interp1(time, full_norm, t_calculation1, 'nearest');
y_t_calculation2 = interp1(time, full_norm, t_calculation2, 'nearest');
y_t_calculation3 = interp1(time, full_norm, t_calculation3, 'nearest');
y_t_calculation4 = interp1(time, full_norm, t_calculation4, 'nearest');
y_t_calculation5 = interp1(time, full_norm, t_calculation5, 'nearest');
% figure
figure;

subplot(2, 1, 1);
plot(time, Eztr, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez');

subplot(2, 1, 2);
plot(time, full_norm, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez normalized');
hold on;
scatter(max_time1,full_norm(time==max_time1),50,"black","filled")
scatter(t_calculation1,y_t_calculation1,50,[0 0.4470 0.7410],"filled")%파란색
scatter(t_calculation2,y_t_calculation2,50,[0.8500 0.3250 0.0980],"filled")%황토색
scatter(t_calculation3,y_t_calculation3,50,[0.8500 0.3250 0.0980],"filled")%주황
scatter(t_calculation4,y_t_calculation4,50,[0.4940 0.1840 0.5560],"filled")%보라
% scatter(t_calculation5,y_t_calculation5,100,[0.4940 0.1840 0.5560],"filled")
hold off;
fontsize(16,"points")

