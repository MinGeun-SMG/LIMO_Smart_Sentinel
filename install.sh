#!/bin/bash
set -e  # 에러 발생 시 즉시 중단

echo "🚀 LIMO Smart Sentinel 설치를 시작합니다..."

# 1. 워크스페이스 준비
echo "📂 워크스페이스 생성 중 (wego_ws)..."
mkdir -p ~/wego_ws/src
cd ~/wego_ws

# 2. 패키지 다운로드 (limo.repos 기반)
echo "📥 패키지 다운로드 중..."
vcs import src < ~/LIMO_Smart_Sentinel/limo.repos

# 3. 의존성 설치 (Rosdep)
echo "📦 필수 라이브러리 설치 중..."
sudo apt update
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# 4. 빌드 (Colcon Build)
echo "🔨 전체 빌드 시작 (시간이 좀 걸립니다)..."
colcon build --symlink-install

# 5. 환경 설정 추가
echo "✅ 빌드 완료! 환경 변수를 설정합니다."
if ! grep -q "source ~/wego_ws/install/setup.bash" ~/.bashrc; then
    echo "source ~/wego_ws/install/setup.bash" >> ~/.bashrc
    echo "bashrc에 설정이 추가되었습니다."
else
    echo "이미 bashrc에 설정되어 있습니다."
fi

echo "🎉 모든 설치가 완료되었습니다! 터미널을 재시작하거나 'source ~/.bashrc'를 입력하세요."
