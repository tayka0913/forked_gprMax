%% case1 Ez 플로팅
subplot(3, 1, 1)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 Ez에 입력
Eztr=Ez.' %Ez를 전치시켜 Eztr에 저장
plot(Eztr);
hold on;
xlabel('Time (1e-11)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength with Peaks');
grid on;
hold off;
%% case1 Hx 플로팅
subplot(3, 1, 2)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Hx=h5read('case1_2.0.out','/rxs/rx1/Hx') % hx값 추출해서 Hx에 입력
Hxtr=Hx.'
plot(Hxtr);
hold on;
xlabel('Time (1e-11)');
ylabel('Hx,  Field Strength (A/m)');
title('Magnetic Field Strength with Peaks');
grid on;
hold off;
%% case1 Hy 플로팅
subplot(3, 1, 3)
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Hy=h5read('case1_2.0.out','/rxs/rx1/Hy') % hy값 추출해서 Hy에 입력
Hytr=Hy.'
plot(Hytr);
hold on;

xlabel('Time (1e-11)');
ylabel('Hy,  Field Strength (A/m)');
title('Magnetic Field Strength with Peaks');
grid on;
hold off;