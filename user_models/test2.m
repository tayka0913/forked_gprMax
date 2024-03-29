%%  구간 통과 시간 계산
e1= 4.5 % 각 구간 상대유전율 설정
e2= 6
e3= 1
m1= 1 % 각 구간 길이 설정(m)
m2=0.2
m3=0.8
c= 299792458 % 빛의속도(m/s)
v1= c/sqrt(e1) % 각 구간에서의 빛의 속도 계산
v2= c/sqrt(e2)
v3= c/sqrt(e3)
t1= m1/v1 % 각 구간을 통과하는 동안 걸리는 시간 계산
t2= m2/v2
t3= m3/v3 % 전체를 통과하는 동안 걸리는 시간 계산
t1r=t1*2 % 반사되어 돌아오는 시간 계산
t2r=(t1+t2)*2
t3r=(t1+t2+t3)*2

fprintf('첫번째 물질을 통과하는데 걸리는 시간:  %d \n', t1);
fprintf('두번째 물질을 통과하는데 걸리는 시간:  %d \n', t2);
fprintf('세번째 물질을 통과하는데 걸리는 시간:  %d \n', t3);
fprintf('첫번째 구간에서 반사되어 돌아오는 시간:  %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간:  %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간:  %d \n', t3r);

index1 = find(x_data == t1r)
index2 = find(x_data == t2r)
index3 = find(x_data == t3r)

if isempty(index)
    fprintf('주어진 x 값에 해당하는 데이터를 찾을 수 없습니다.\n');
else
    desired_y = y_data(index);
    plot(desired_x, desired_y, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    fprintf('x = %d 일 때, y = %d 입니다.\n', desired_x, desired_y);
end
%% case 1 플로팅
h5disp('case1_2.0.out') % 아웃풋 파일 구성요소 확인
Ez=h5read('case1_2.0.out','/rxs/rx1/Ez') % ez값 추출해서 data에 입력
Eztr=Ez.'
iteration = 5089;
Time = 60e-9;
time = linspace(0,Time,iteration)
plot(time,Eztr);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength with Peaks');
grid on;
hold off;
%%
h5disp('case1_2.0.out'); % 아웃풋 파일 구성요소 확인
Ez = h5read('case1_2.0.out', '/rxs/rx1/Ez'); % ez값 추출해서 data에 입력
Eztr = Ez.';
iteration = 5089;
Time = 60e-9;
time = linspace(0, Time, iteration);

% 각 구간 상대유전율 및 길이 설정
e1 = 4.5;
e2 = 6;
e3 = 1;
m1 = 1;
m2 = 0.2;
m3 = 0.8;
c = 299792458;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
t1r = t1 * 2;
t2r = t2 * 2;
t3r = t3 * 2;
% 기존 데이터 플로팅
figure;
plot(time, Eztr);
hold on;
xlabel('Time (seconds)');
ylabel('Ez,  Field Strength (V/m)');
title('Electric Field Strength');
grid on;

% 각 구간의 시간에 해당하는 위치에 세로선 추가 
line([t1, t1], ylim, 'Color', [0.7, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([t2, t2], ylim, 'Color', [0.2, 0.7, 0.2], 'LineStyle', '-', 'LineWidth', 2);
line([t3, t3], ylim, 'Color', [0.2, 0.2, 0.7], 'LineStyle', '-', 'LineWidth', 2);
line([t1r, t1r], ylim, 'Color', [0.4, 0.1, 0.4], 'LineStyle', '--', 'LineWidth', 2);
line([t2r, t2r], ylim, 'Color', [0.1, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);
line([t3r, t3r], ylim, 'Color', [0.4, 0.4, 0.1], 'LineStyle', '--', 'LineWidth', 2);

% 범례 추가
legend('Ez', 't1', 't2', 't3', 't1r', 't2r', 't3r');
hold off;

fprintf('첫번째 구간을 통과하는데 걸리는 시간: %d \n', t1);
fprintf('두번째 구간을 통과하는데 걸리는 시간: %d \n', t2);
fprintf('세번째 구간을 통과하는데 걸리는 시간: %d \n', t3);
fprintf('첫번째 구간에서 반사되어 돌아오는 시간: %d \n', t1r);
fprintf('두번째 구간에서 반사되어 돌아오는  시간: %d \n', t2r);
fprintf('세번째 구간에서 반사되어 돌아오는  시간: %d \n', t3r);

