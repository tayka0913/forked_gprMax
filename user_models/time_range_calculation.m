e1 = 6.25;
e2 = 1;
e3 = 27.23;
m1 = 5;
m2 = 0;
m3 = 0;
c = 3e8;
v1 = c / sqrt(e1);
v2 = c / sqrt(e2);
v3 = c / sqrt(e3);
t1 = m1 / v1;
t2 = t1+(m2 / v2);
t3 = t2+(m3 / v3);
tr1 =t1*2;
tr2 =t2*2;
tr3 =t3*2

%% 파장계산
c= 3E+8;
f = 320E+6;
lambda = f/c;
lambda_half= lambda/2;
fprintf('파장: %d \n', lambda);
fprintf('반파장: %d \n', lambda_half);