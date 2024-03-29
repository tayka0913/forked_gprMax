from paraview.simple import *

# GPRMax 출력 파일 경로
filename = 'your_output_file.vtk'  # GPRMax 출력 파일명으로 변경하세요.

# 파일 불러오기
gprMaxOutput = LegacyVTKReader(FileNames=[filename])

# 시각화 설정 (예: E-field 데이터 선택)
SetActiveSource(gprMaxOutput)
eField = Calculator(Input=gprMaxOutput)
eField.ResultArrayName = 'E-field'
eField.Function = 'E'  # 'E'는 GPRMax 출력에서 E-field를 나타내는 변수명이어야 합니다.

# 렌더러, 렌더 윈도우, 및 인터랙터 생성
renderView = GetActiveViewOrCreate('RenderView')
eFieldDisplay = Show(eField, renderView)

# E-field 시각화를 위한 색상 맵 및 기타 속성 설정
ColorBy(eFieldDisplay, ('POINTS', 'E-field'))
eFieldDisplay.RescaleTransferFunctionToDataRange(True, False)
eFieldDisplay.SetScalarBarVisibility(renderView, True)

# 스냅샷 캡처 및 파일로 저장
SaveScreenshot('eFieldSnapshot.png', renderView,
               ImageResolution=[1920, 1080])

# ParaView GUI에서 스크립트 실행 시 주석 처리 해제
# interact()
