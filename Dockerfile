FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1 \
    libglib2.0-0 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN pip install insightface==0.7.3 onnxruntime-gpu onnxruntime

RUN mkdir -p models/ipadapter models/loras models/clip_vision

EXPOSE 8188

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "8188"]
