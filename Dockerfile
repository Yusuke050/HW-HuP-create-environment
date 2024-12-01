# CUDA 9.0 と Ubuntu 16.04 を基にしたイメージを使用
FROM nvcr.io/nvidia/cuda:9.0-cudnn7.1-devel-ubuntu16.04

# 基本的なライブラリとツールをインストール
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    gcc-5 \
    && apt-get clean

# gcc 5をデフォルトに設定
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 50

# Anacondaのインストール
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O /tmp/anaconda.sh && \
    bash /tmp/anaconda.sh -b -p /opt/conda && \
    rm /tmp/anaconda.sh

ENV PATH="/opt/conda/bin:$PATH"

# Python環境を作成し、torchを最初にインストール
RUN conda create -n smplify2 python=3.7 -y && \
    /opt/conda/envs/smplify2/bin/pip install --upgrade pip && \
    /opt/conda/envs/smplify2/bin/pip install torch==1.1.0

# requirements.txtをコピーして残りの依存パッケージをインストール
RUN /opt/conda/envs/smplify2/bin/pip install opencv-python==4.5.3.56
COPY requirements.txt /src/requirements.txt
RUN /opt/conda/envs/smplify2/bin/pip install --no-deps -r /src/requirements.txt
# 作業ディレクトリの設定
WORKDIR /src/3dPoseEstimate


