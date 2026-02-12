FROM runpod/pytorch:2.1.2-py3.10-cuda12.1.1-devel

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1 \
    libglib2.0-0 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Upgrade pip
RUN pip install --upgrade pip

# Install ComfyUI requirements
RUN pip install -r requirements.txt

# Install FaceID dependencies
RUN pip install insightface==0.7.3 onnxruntime-gpu onnxruntime

# Pre-create model directories
RUN mkdir -p models/ipadapter models/loras models/clip_vision

EXPOSE 8188

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "8188"]
