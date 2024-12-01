## HW-HuPモデルの環境構築用
三次元骨格推定モデル<br>
以下のモデルで動作する環境が詳しくまとめられていなかったため、実際に動作した環境を共有　<br>
https://github.com/ostadabbas/HW-HuP
## 動作環境
os:windows11 <br>
cuda12.5
## ディレクトリ構成
```
.
└── README.md
├── Dockerfile
├── docker-compose.yml
└── 3dPoseEstimate
    └── setup.sh
```

## 使用方法
1. ./3dPoseEstimateの中で`https://github.com/ostadabbas/HW-HuP`をclone
2. `docker-compose up --build`実行
3. 作成されたコンテナ内のbashで./3dPoseEstimate/HW-HuP内に入り、setup.shを実行
4. `source /opt/conda/bin/activate smplify2`で仮想環境にはいる
<br>
※データセットのダウンロードやsmplify環境の構築などは行っていないため、HW-HuP内のREADMEとdataset/preprocess内のREADMEを参照し構築する必要がある

## 各ファイルの説明
### Dockerfile
以下の部分についてpyrenderのバージョンとpyopenGLのバージョンなどによってそれぞれ発生するエラーがあるため、それらを回避するために依存関係を無視した状態でインストールしている。
よって、仮想環境で新たにpipでインストールするとそれらの依存関係が壊れる可能性があるため注意
```
RUN /opt/conda/envs/smplify2/bin/pip install opencv-python==4.5.3.56
COPY requirements.txt /src/requirements.txt
RUN /opt/conda/envs/smplify2/bin/pip install --no-deps -r /src/requirements.txt
```

### setup.sh
画像を生成する際にディスプレイが必要だが、仮想環境上でディスプレイを開くことができないため、仮想ディスプレイを設定する
以下を参照
https://pyrender.readthedocs.io/en/latest/install/index.html#installing-osmesa


