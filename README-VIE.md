
## 🇻🇳 Bộ công cụ chuyển đổi mô hình từ Hugging Face sang định dạng RKLLM

Đây là bộ công cụ để chuyển đổi mô hình từ Hugging Face sang định dạng RKLLM để chạy trên thiết bị NPU của Rockchip, ví dụ như Orange Pi 5 với RK3588. 
**Lưu ý:** đoạn mã này cần được chạy trên máy X86 mạnh mẽ có card đồ họa để thực hiện chuyển đổi mô hình, **không nên chạy trên Orange Pi.**

Đã được thử nghiệm trên máy có CPU Xeon E5 kép, RAM 64GB và card RTX 3060 12GB, chạy Ubuntu 22.04 / Python 3.10.

## Chạy trực tiếp trên Ubuntu 22.04 / Python 3.10 (lưu ý chỉ hỗ trợ Python 3.10)

Cài đặt UV:
```bash
curl -Ls https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
```

Clone repo:
```bash
git clone https://github.com/thanhtantran/rkllm-toolkit-cli.git
cd rkllm-toolkit-cli
```

Khởi chạy ứng dụng:
```bash
uv venv
source .venv/bin/activate
uv pip install -e .
```

Sau đó bắt đầu chuyển đổi với lệnh:
```bash
rkllm-toolkit [OPTIONS] MODEL_IDS...

╭─ Tham số ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    model_ids      MODEL_IDS...  ID mô hình trên HuggingFace [bắt buộc]                                │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Tùy chọn ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ --qtypes                                     TEXT             Loại lượng tử hóa [mặc định: w8a8]         │
│ --hybrid-rates                               FLOAT            Tỷ lệ hybrid [mặc định: 0.0]               │
│ --optimization          --no-optimization                     Mức độ tối ưu [mặc định: optimization]     │
│ --platform                                   [rk3588|rk3576]  Nền tảng mục tiêu [mặc định: rk3588]       │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## Chạy trên hệ điều hành mới hơn (Ubuntu 24.04) hoặc Python mới (3.12) bằng Docker (yêu cầu đã cài Docker)

Build image:
```bash
git clone https://github.com/thanhtantran/rkllm-toolkit-cli.git
cd rkllm-toolkit-cli
docker build -t rkllm-toolkit-cli .
```

Lưu token Hugging Face để truyền vào container:
```
mkdir -p ~/.cache/huggingface
echo "hf_your_token_here" > ~/.cache/huggingface/token
```

Chạy container bằng lệnh:
```
sudo docker run --rm --privileged   -v ~/.cache/huggingface:/root/.cache/huggingface   rkllm-toolkit-cli MODEL_IDS
```
Hoặc chạy trực tiếp từ image đã build sẵn:
```
sudo docker run --rm --privileged   -v ~/.cache/huggingface:/root/.cache/huggingface   thanhtantran/rkllm-toolkit-cli:latest MODEL_IDS
```

## Chạy trên NixOS
```console
$ nix run github:thanhtantran/rkllm-toolkit-cli

 Usage: rkllm-toolkit [OPTIONS] MODEL_IDS...

╭─ Tham số ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    model_ids      MODEL_IDS...  ID mô hình trên HuggingFace [bắt buộc]                                │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Tùy chọn ───────────────────────────────────────────────────────────────────────────────────────────────╮
│ --qtypes                                     TEXT             Loại lượng tử hóa [mặc định: w8a8]         │
│ --hybrid-rates                               FLOAT            Tỷ lệ hybrid [mặc định: 0.0]               │
│ --optimization          --no-optimization                     Mức độ tối ưu [mặc định: optimization]     │
│ --platform                                   [rk3588|rk3576]  Nền tảng mục tiêu [mặc định: rk3588]       │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

Dựa trên:
- https://github.com/datakurre/rkllm-toolkit-cli
- https://github.com/c0zaut/ez-er-rkllm-toolkit
