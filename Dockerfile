# --------------------------------------------------
# Extend Official RunPod ComfyUI Base
# --------------------------------------------------
FROM runpod/comfyui-base:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

WORKDIR /workspace/runpod-slim/ComfyUI

# --------------------------------------------------
# Upgrade pip tools
# --------------------------------------------------
RUN pip install --upgrade pip setuptools wheel

# --------------------------------------------------
# FaceID / IPAdapter Plus V2 Dependencies
# --------------------------------------------------
RUN pip install --no-cache-dir \
    insightface==0.7.3 \
    onnxruntime-gpu==1.16.3 \
    onnxruntime \
    opencv-python-headless

# --------------------------------------------------
# (Optional but Recommended) xFormers for SDXL
# --------------------------------------------------
RUN pip install --no-cache-dir xformers --index-url https://download.pytorch.org/whl/cu121

# --------------------------------------------------
# Ensure model directories exist
# --------------------------------------------------
RUN mkdir -p \
    /workspace/runpod-slim/comfy/models/checkpoints \
    /workspace/runpod-slim/comfy/models/ipadapter \
    /workspace/runpod-slim/comfy/models/loras \
    /workspace/runpod-slim/comfy/models/clip_vision \
    /workspace/runpod-slim/comfy/models/controlnet \
    /workspace/runpod-slim/comfy/models/vae

# --------------------------------------------------
# Expose UI Port
# --------------------------------------------------
EXPOSE 8188

# --------------------------------------------------
# Keep RunPod's Original Startup Script
# --------------------------------------------------
CMD ["bash", "/start.sh"]
