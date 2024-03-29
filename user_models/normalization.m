%% Ez의 흔들리는 부분을 정규화
h5disp('case1_2.0.out');
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';


% 구간별로 데이터 추출 및 정규화
interval1_start = 0;
interval1_end = 8.2e-9;
interval1_indices = find(time >= interval1_start & time <= interval1_end);
Ez_interval1 = normalize(Eztr(interval1_indices), "range", [-1 1]);

interval2_start = 17e-9;
interval2_end = 25e-9;
interval2_indices = find(time >= interval2_start & time <= interval2_end);
Ez_interval2 = normalize(Eztr(interval2_indices), "range", [-1 1]);

interval3_start = 36e-9;
interval3_end = 41e-9;
interval3_indices = find(time >= interval3_start & time <= interval3_end);
Ez_interval3 = normalize(Eztr(interval3_indices), "range", [-1 1]);

% 0으로 이루어진 배경에 구간별로 정규화된 데이터를 덮어쓰기
combined_normalized_data = zeros(size(Eztr));
combined_normalized_data(interval1_indices) = Ez_interval1;
combined_normalized_data(interval2_indices) = Ez_interval2;
combined_normalized_data(interval3_indices) = Ez_interval3;

% 전체 Ez 데이터와 합쳐진 데이터를 서브플롯 2개로 분리하여 플로팅
figure;
subplot(2, 1, 1);
plot(time, Eztr, 'b', 'LineWidth', 2);
line([interval1_start, interval1_start], ylim, 'Color', [0.7, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([interval1_end, interval1_end], ylim, 'Color', [0.7, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([interval2_start, interval2_start], ylim, 'Color', [0.2, 0.2, 0.7], 'LineStyle', '-', 'LineWidth', 2);
line([interval2_end, interval2_end], ylim, 'Color', [0.2, 0.2, 0.7], 'LineStyle', '-', 'LineWidth', 2);
line([interval3_start, interval3_start], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '-', 'LineWidth', 2);
line([interval3_end, interval3_end], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('Ez');

subplot(2, 1, 2);
plot(time, combined_normalized_data, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Combined Normalized Ez');
title('구간별로 정규화된 Ez 합침');

%% 리커파와 컨볼루션 시킨걸 정규화
h5disp('case1_2.0.out');
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez');
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);
Eztr = Ez.';
% 피크주파수 300MHz인 리커파 생성
f_peak = 300e6; % 피크 주파수 (단위: Hz)
dt = 60e-9 / 5089; % 샘플링 간격 (단위: 초)
Fs=1/dt %샘플링 주파수 
t_max = 60e-9; % 시간의 최대 값 (단위: 초)

t = -t_max:dt:t_max; % -60ns~60ns

ricker_wavelet = (1 - 2 * (pi * f_peak * t).^2) .* exp(-(pi * f_peak * t).^2);

% 리커파 쓸모있는 부분만 windowing
window_range = [-4e-9, 4e-9]; % 원하는 시간 구간 설정
index_range = find(t >= window_range(1) & t <= window_range(2));

ricker_windowed = ricker_wavelet(index_range);

% Ez와 windowed 리커파를 컨볼루션
conv_result = conv(Eztr, ricker_windowed, 'same');


% 구간별로 데이터 추출 및 정규화 후 합치기
interval1_start = 0;
interval1_end = 10e-9;
interval1_indices = find(time >= interval1_start & time <= interval1_end);
Ez_interval1 = normalize(conv_result(interval1_indices), "range", [-1 1]);

interval2_start = 16e-9;
interval2_end = 26e-9;
interval2_indices = find(time >= interval2_start & time <= interval2_end);
Ez_interval2 = normalize(conv_result(interval2_indices), "range", [-1 1]);

interval3_start = 36e-9;
interval3_end = 43e-9;
interval3_indices = find(time >= interval3_start & time <= interval3_end);
Ez_interval3 = normalize(conv_result(interval3_indices), "range", [-1 1]);

% 구간별로 정규화된 데이터를 합치기
combined_normalized_data = zeros(size(conv_result));
combined_normalized_data(interval1_indices) = Ez_interval1;
combined_normalized_data(interval2_indices) = Ez_interval2;
combined_normalized_data(interval3_indices) = Ez_interval3;

% 전체 Ez 데이터와 합쳐진 데이터를 서브플롯 2개로 분리하여 플로팅
figure;
subplot(2, 1, 1);
plot(time, conv_result, 'b', 'LineWidth', 2);
line([interval1_start, interval1_start], ylim, 'Color', [0.7, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([interval1_end, interval1_end], ylim, 'Color', [0.7, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([interval2_start, interval2_start], ylim, 'Color', [0.2, 0.2, 0.7], 'LineStyle', '-', 'LineWidth', 2);
line([interval2_end, interval2_end], ylim, 'Color', [0.2, 0.2, 0.7], 'LineStyle', '-', 'LineWidth', 2);
line([interval3_start, interval3_start], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '-', 'LineWidth', 2);
line([interval3_end, interval3_end], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Ez');
title('리커파와 컨벌루션한 Ez');
subplot(2, 1, 2);
plot(time, combined_normalized_data, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Combined Normalized Ez');
title('구간별로 정규화된 Ez 합침');