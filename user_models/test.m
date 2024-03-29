%% 리커파 생성
f = 300E+6; % Frequency (Hz)
iteration = 5089;
Time = 60e-9;
t = linspace(0,Time,iteration)
w = (1 - 2*(pi*f*(t)).^2) .* exp(-(pi*f*(t)).^2);
% Plot Ricker wavelet
plot(t, w);
xlabel('Time (s)');
ylabel('Amplitude');
title('Ricker Wavelet');
%% 리커파 FFT
f = 1; % Frequency (Hz)
iteration = 5089;
Time = 2;
dt=Time/iteration
t = linspace(0,Time,iteration)

% Generate Ricker wavelet
w = (1 - 2*(pi*f*(t-1)).^2) .* exp(-(pi*f*(t-1)).^2);
N = length(w)
frequencies = fftshift(fftfreq(N, dt))
ricker_fft = fftshift(fft(w))
freq_range = frequencies >= 0 & frequencies <= 3;
frequencies_filtered = frequencies(freq_range);
ricker_fft_filtered = ricker_fft(freq_range);

plot(frequencies_filtered, abs(ricker_fft_filtered))
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('FFT of Ricker Wavelet')
%% 리커파 컨볼루션
% Generate Ricker wavelet
f = 300E+6; % Frequency (Hz)
iteration = 5089;
Time = 60e-9;
t = linspace(0,Time,iteration)
ricker_wavelet = (1 - 2*(pi*f*t).^2) .* exp(-(pi*f*t).^2);

% Generate synthetic seismic data (example)
t = linspace(0,Time,iteration); % Time vector for data (s)
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
% Perform convolution
conv_result = conv(Eztr, ricker_wavelet, 'same');
conv_result_abs= abs(conv_result)

% Plot original data and convolved result
figure;
subplot(2,1,1);
plot(t, Eztr);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Data');

subplot(2,1,2);
plot(t, conv_result);
xlabel('Time (s)');
ylabel('Amplitude');
title('Convolved Result with Ricker Wavelet');


