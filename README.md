This is the toolkit to convert model from Hugging Face to RKLLM format in order to run on Rockchip NPU device, like Orange Pi 5 with RK3588. Please note that this code should be run on a powerful X86 machine, with graphic card to convert the model, not on Orange Pi.

Tested on Xeon E5 dual CPU, 64GB RAM and RTX 3060 12GB machine, running Ubuntu 22.04 / Python 3.10. 

## Run natively on Ubuntu 22.04 / Python 3.10 (note that Python 3.10 only)

Install UV
```bash
curl -Ls https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
```

Clone the repo
```bash
git clone https://github.com/thanhtantran/rkllm-toolkit-cli.git
cd rkllm-toolkit-cli
```

Start the app
```bash
uv venv
source .venv/bin/activate
uv pip install -e .
```

Then start to convert with command
```bash
rkllm-toolkit [OPTIONS] MODEL_IDS...

╭─ Arguments ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    model_ids      MODEL_IDS...  HuggingFace model IDs [default: None] [required]                        │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --qtypes                                     TEXT             Quantization types [default: w8a8]          │
│ --hybrid-rates                               FLOAT            Hybrid rates [default: 0.0]                 │
│ --optimization          --no-optimization                     Optimization level [default: optimization]  │
│ --platform                                   [rk3588|rk3576]  Target platform [default: rk3588]           │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## Run on higher OS (Ubuntu 24.04) and other Python (3.12) by using Docker (you should have docker already installed)

Build the image
```bash
git clone https://github.com/datakurre/rkllm-toolkit-cli.git
cd rkllm-toolkit-cli
docker build -t rkllm-toolkit-cli .
```

Store your Hugging Face token to pass it into container
```
mkdir -p ~/.cache/huggingface
echo "hf_your_token_here" > ~/.cache/huggingface/token
```

Run container with command
```
sudo docker run --rm --privileged \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  rkllm-toolkit-cli MODEL_IDS
```
Or alternative you can run immediately on the image i have prebuilt
```
sudo docker run --rm --privileged \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  thanhtantran/rkllm-toolkit-cli:latest MODEL_IDS
```

## Run on NixOS
```console
$ nix run github:thanhtantran/rkllm-toolkit-cli

 Usage: rkllm-toolkit [OPTIONS] MODEL_IDS...

╭─ Arguments ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    model_ids      MODEL_IDS...  HuggingFace model IDs [default: None] [required]                        │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --qtypes                                     TEXT             Quantization types [default: w8a8]          │
│ --hybrid-rates                               FLOAT            Hybrid rates [default: 0.0]                 │
│ --optimization          --no-optimization                     Optimization level [default: optimization]  │
│ --platform                                   [rk3588|rk3576]  Target platform [default: rk3588]           │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

Based on https://github.com/datakurre/rkllm-toolkit-cli
