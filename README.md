```console
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
