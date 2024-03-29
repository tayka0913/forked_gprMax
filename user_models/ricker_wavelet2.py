import numpy as np
import matplotlib.pyplot as plt

def ricker_wavelet(frequency, dt, length):
    t = np.arange(-length/2, length/2, dt)
    y = (1 - 2 * (np.pi ** 2) * (frequency ** 2) * (t ** 2)) * np.exp(-(np.pi ** 2) * (frequency ** 2) * (t ** 2))
    return t, y

def plot_normalized_fft(signal, dt):
    n = len(signal)
    fft_result = np.fft.fft(signal)
    fft_freq = np.fft.fftfreq(n, dt)
    
    # FFT 결과를 정규화
    fft_result /= np.max(np.abs(fft_result))
    
    # 절반만 플로팅 (양방향 스펙트럼)
    plt.plot(fft_freq[:n//2], np.abs(fft_result)[:n//2])
    plt.title('Normalized FFT of Ricker Wavelet')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Amplitude')
    plt.show()

# Ricker Wavelet 생성
frequency = 300E+6  # 주파수 설정
iteration = 5089
length = 60E-9    # 시간 길이
dt = length / iteration      # 샘플링 간격
t, ricker_wavelet_signal = ricker_wavelet(frequency, dt, length)

# 생성된 Ricker Wavelet 시간 영역 플로팅
plt.plot(t, ricker_wavelet_signal)
plt.title('Ricker Wavelet in Time Domain')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.show()

# 정규화된 FFT 플로팅
plot_normalized_fft(ricker_wavelet_signal, dt)
