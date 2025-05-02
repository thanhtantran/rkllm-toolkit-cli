# Use official Python 3.10 slim image
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# Add uv to PATH (from ~/.cargo/bin)
ENV PATH="/root/.local/bin:${PATH}"

# Clone rkllm-toolkit-cli
WORKDIR /app
RUN git clone https://github.com/thanhtantran/rkllm-toolkit-cli.git .

# Create and activate virtual environment using uv
RUN uv venv && \
    . .venv/bin/activate && \
    uv pip install -e .

# Set entrypoint to pass arguments like `model_ids`
ENTRYPOINT ["uv", "run", "--", "rkllm-toolkit"]
CMD ["model_ids"]
