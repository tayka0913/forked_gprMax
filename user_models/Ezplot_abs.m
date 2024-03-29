%% case1 Ez 플로팅
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
iteration = 5089;
Time = 60e-9;
dt = Time/iteration;
time = 0:dt:(iteration-1)*dt;
plot(time,Eztr);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength with Peaks');
grid on;
hold off;
%% case1 Ez abs, peak플로팅 ver1
Ez=h5read('case5_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
Ezabs=abs(Eztr)
iteration = 5089;
Time = 60e-9;
time = linspace(0,Time,iteration)
figure;
plot(time,Ezabs);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Modulus of Electric Field Strength');
grid on;

hold off;
%% case1 Ez abs, peak플로팅 ver2
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
Ezabs=abs(Eztr)
iteration = 5089;
Time = 60e-9;
dt = Time/iteration;
time = 0:dt:(iteration-1)*dt;
figure;
plot(time,Ezabs);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Modulus of Electric Field Strength');
grid on;

[pks,locs] = findpeaks(Ezabs); % 국소 최대값(=pks) 찾기
plot(locs*dt, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시

hold off;
%% case1 Ez abs, peak플로팅 ver3
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
Ezabs=abs(Eztr)
iteration = 5089;
Time = 60e-9;
dt = Time/iteration;
time = 0:dt:(iteration-1)*dt;
figure;
plot(time,Ezabs);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Modulus of Electric Field Strength');
grid on;

[pks,locs] = findpeaks(Ezabs); % 국소 최대값(=pks) 찾기
plot(locs*dt, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시
for i = 1:length(pks)
    text(locs(i)*dt, pks(i), sprintf(' %.2f', pks(i)), 'VerticalAlignment', 'bottom');
end
hold off;
%% case1 Ez abs, peak플로팅 ver4
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
Ezabs=abs(Eztr)
iteration = 5089;
Time = 60e-9;
dt = Time/iteration;
time = 0:dt:(iteration-1)*dt;
figure;
plot(time,Ezabs);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Modulus of Electric Field Strength');
grid on;

[pks,locs] = findpeaks(Ezabs); % 국소 최대값(=pks) 찾기
plot(locs*dt, pks, 'bv'); % 파란색 역삼각형으로 피크값 표시
for i = 1:length(pks)
    text(locs(i)*dt, pks(i), sprintf('(%.2f, %.2f)', locs(i)*dt, pks(i)), 'VerticalAlignment', 'bottom');
end
hold off;