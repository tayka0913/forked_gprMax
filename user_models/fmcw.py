import numpy as np
import matplotlib.pyplot as plt

def generate_up_chirp_fmcw_waveform(duration, sampling_rate, start_freq, frequency_bandwidth, modulation_period):
    t = np.linspace(0, duration, int(sampling_rate * duration), endpoint=False)
    modulation_signal = 2 * (t / modulation_period - np.floor(0.5 + t / modulation_period))
    chirp = np.linspace(start_freq, start_freq + frequency_bandwidth, len(t))
    phase = 2 * np.pi * chirp * t * modulation_signal
    waveform = np.cos(phase)
    return t, waveform

# 파형 생성 파라미터 설정
total_time = 60e-8  # 초단위
sampling_rate = 5089 / total_time
start_freq = 300e5  # 초기 주파수 (Hz)
frequency_bandwidth = 10e5  # 변조 폭 (Hz)
modulation_period = 20e-8  # sawtooth 모양의 주기 (s)

# Up Chirp FMCW 파형 생성
time_up, waveform_up = generate_up_chirp_fmcw_waveform(total_time, sampling_rate, start_freq, frequency_bandwidth, modulation_period)

# 결과를 그래프로 표시
plt.figure(figsize=(8, 4))
plt.plot(time_up, waveform_up)
plt.title('Up Chirp: FMCW Waveform  (Start Frequency: 30MHz, chirp range: 1MHz)')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.show()
