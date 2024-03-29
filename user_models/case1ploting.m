%% case1 Ez 최대, 최소플로팅
subplot(3, 1, 1)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
plot(Eztr);
hold on;
[pks,locs] = findpeaks(Eztr); % 국소 최대값(=pks) 찾기
plot(locs, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시

x= 1:length(data);
isMinima = islocalmin(Eztr); % 국소 최소값(=minima) 찾기
minima_locations = x(isMinima);
minima = Eztr(isMinima);
plot(minima_locations, minima, 'r*'); % 빨간별로 미니마 표시
xlabel('Time (1e-11)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength with Peaks');
grid on;
hold off;
%% case1 Hx 최대, 최소플로팅
subplot(3, 1, 2)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Hx=h5read('case1_2.0.out','/rxs/rx1/Hx') % hx값 추출해서 data에 입력
Hxtr=Hx.'
plot(Hxtr);
hold on;
[pks,locs] = findpeaks(Hxtr); % 국소 최대값(=pks) 찾기
plot(locs, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시

x= 1:length(data);
isMinima = islocalmin(Hxtr); % 국소 최소값(=minima) 찾기
minima_locations = x(isMinima);
minima = Hxtr(isMinima);
plot(minima_locations, minima, 'r*'); % 빨간별로 미니마 표시
xlabel('Time (1e-11)');
ylabel('Hx,  Field Strength (V/m)');
title('Magnetic Field Strength with Peaks');
grid on;
hold off;
%% case1 Hy 최대, 최소플로팅
subplot(3, 1, 3)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Hy=h5read('case1_2.0.out','/rxs/rx1/Hy') % hy값 추출해서 data에 입력
Hytr=Hy.'
plot(Hytr);
hold on;
[pks,locs] = findpeaks(Hytr); % 국소 최대값(=pks) 찾기
plot(locs, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시

x= 1:length(data);
isMinima = islocalmin(Hytr); % 국소 최소값(=minima) 찾기
minima_locations = x(isMinima);
minima = Hytr(isMinima);
plot(minima_locations, minima, 'r*'); % 빨간별로 미니마 표시
xlabel('Time (1e-11)');
ylabel('Hy,  Field Strength (V/m)');
title('Magnetic Field Strength with Peaks');
grid on;
hold off;