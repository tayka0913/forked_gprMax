% plot_Bscan.m
% gprMax B-스캔에서 EM 필드를 플로팅하기 위한 스크립트
%
% Craig Warren

clear all, clc;  % 모든 변수를 지우고, 커맨드 윈도우를 클리어합니다.

% 사용자에게 파일 선택을 요청하고 선택된 파일의 경로와 파일 이름을 가져옵니다.
[filename, pathname] = uigetfile('*.out', 'Select gprMax output file to plot B-scan', 'MultiSelect', 'on');
filename = fullfile(pathname, filename);  % 전체 파일 경로를 생성합니다.

% 파일이 선택되었는지 확인합니다.
if filename ~= 0
    iterations = double(h5readatt(filename, '/', 'Iterations'));  % 반복 횟수를 읽습니다.
    dt = h5readatt(filename, '/', 'dt');  % 시간 간격을 읽습니다.

    % Ez 필드 데이터를 직접 선택합니다.
    fieldpath = '/rxs/rx1/Ez';  % Ez 필드의 경로를 설정합니다.
    field = h5read(filename, fieldpath)';  % Ez 필드 데이터를 읽고 전치합니다.
    time = linspace(0, (iterations - 1) * dt, iterations)';  % 시간 배열을 생성합니다.
    traces = 0:size(field, 2);  % 트레이스 번호를 생성합니다.

    fh1 = figure('Name', filename);  % 새로운 그림을 생성하고 이름을 설정합니다.
    clims = [-40 40];  % 컬러맵의 한계를 설정합니다.
    im = imagesc(traces, time, field, clims);  % 이미지를 플로팅합니다.

    xlabel('Trace number');  % x축 레이블을 설정합니다.
    ylabel('Time [s]');  % y축 레이블을 설정합니다.
    c = colorbar;  % 컬러바를 추가합니다.
    c.Label.String = 'Field strength [V/m]';  % 컬러바 레이블을 설정합니다.
    ax = gca;  % 현재 축을 가져옵니다.
    ax.FontSize = 16;  % 축의 글꼴 크기를 설정합니다.
    xlim([0 traces(end)]);  % x축의 한계를 설정합니다.

    % 컬러맵 조정: -값은 파랑, 0은 하양, +값은 빨강으로 나타내지만, clims 한계는 유지
    blueToWhite = [linspace(0, 1, 128)' linspace(0, 1, 128)' ones(128, 1)];
    whiteToRed = [ones(128, 1) linspace(1, 0, 128)' linspace(1, 0, 128)'];
    customCMap = [blueToWhite; whiteToRed];
    colormap(ax, customCMap);
    
    % 그림 설정 조정
    set(fh1,'Color','white','Menubar','none');
    setFigureSize(fh1, 60, 30);

    % 파일 이름에서 확장자를 제거하고 PNG 확장자를 추가하여 파일을 저장합니다.
    outputFilename = [filename(1:end-4), '_Bscan.png'];  % .out 확장자를 가정하고 제거
    saveas(fh1, outputFilename);  % 현재 그림을 PNG 파일로 저장합니다.
end

function setFigureSize(fh, X, Y)
    % 페이지 및 그림 크기 설정을 위한 함수
    xMargin = 0; yMargin = 0;
    xSize = X - 2*xMargin;
    ySize = Y - 2*yMargin;
    set(fh, 'Units','centimeters', 'Position', [0 0 xSize ySize]);
    movegui(fh, 'center');
    set(fh,'PaperUnits', 'centimeters');
    set(fh,'PaperSize', [X Y]);
    set(fh,'PaperPosition', [xMargin yMargin xSize ySize]);
    set(fh,'PaperOrientation', 'portrait');
end
