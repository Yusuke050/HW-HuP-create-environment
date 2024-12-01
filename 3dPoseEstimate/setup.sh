#!/bin/bash

# GPUの確認
echo "Activating smplify2 environment..."
echo "Checking for GPU availability..."
source /opt/conda/bin/activate smplify2
python3 -c "import torch; print('CUDA available:', torch.cuda.is_available()); print('Device count:', torch.cuda.device_count()); print('Device name:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'No CUDA device')"

# 仮想スクリーンの設定 
apt-get update && apt-get install -y xvfb
# 初回実行時は以下のコメントアウトを外して実行
wget https://github.com/mmatl/travis_debs/raw/master/xenial/mesa_18.3.3-0.deb
apt-get -f -y install
dpkg -i ./mesa_18.3.3-0.deb || true
apt-get install -f -y
# 明示的に仮想ディスプレイを起動、おそらく以下のコマンドは不要
# echo "Starting Xvfb..."
# Xvfb :0 -screen 0 1024x768x24 &
# export DISPLAY=:0

# 3D Pose Estimationの実行
# source /mnt/3dPoseEstimate/HW-HuP/scripts/3dpw_eval.sbatch
