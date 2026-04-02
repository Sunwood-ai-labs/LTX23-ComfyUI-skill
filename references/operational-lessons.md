# Operational Lessons

These notes capture the issues we actually hit while preparing the remote GPU machine and running real generations.

## Setup lessons

### 1. GPU files can exist while CUDA is still invisible

The remote machine exposed `/dev/nvidia*`, but `torch.cuda.is_available()` still returned `False` until:

```bash
export LD_LIBRARY_PATH=/usr/lib64-nvidia:${LD_LIBRARY_PATH:-}
```

Rule:

- Always verify CUDA visibility after setup and again before a long render.

### 2. Host-wide pip config can break normal-user installs

The remote host forced `log=/var/log/pip.log`, which caused permission errors under SSH.

Rule:

- Always neutralize remote pip config with `PIP_CONFIG_FILE=/dev/null`.

### 3. `/content/ComfyUI` can be stale even if it already exists

We hit empty, partial, and root-owned directories that blocked clone or update steps.

Rule:

- Never assume `/content/ComfyUI` is healthy just because the path exists.
- Treat stale non-git or root-owned directories as a known recovery path, not an exception.

## API execution lessons

### 4. Keep one committed API-format prompt

We initially needed a UI-side conversion path to turn the archived workflow JSON into API format.

Rule:

- Prefer the committed API prompt in [../sources/api/ltx23-ti2v-audio-api-prompt.json](../sources/api/ltx23-ti2v-audio-api-prompt.json) for `/prompt` runs.
- Regenerate it only when the upstream workflow changes materially.

### 5. Fixed-input batches must stay actually fixed

The whole comparison gets noisy if prompt, image, audio, or duration drift between runs.

Rule:

- For comparison batches, record fixed inputs once at the top level and vary only the intended knobs.

## Output retrieval lessons

### 6. Local downloads can fail partially

We saw interrupted transfers and local files that existed but were too small.

Rule:

- After downloading outputs, compare the local file size with the recorded remote size before trusting the file.

## GPU capacity lessons

### 7. Peak VRAM needs a margin

A run can fit while still leaving too little headroom for fragmentation or background allocations.

Rule:

- Record `peak_memory_used_mib`, `headroom_mib`, and a practical `recommended_vram_gib`.

### 8. 20-second fixed-input runs already gave a model ordering

On the L4, the 20-second `960x544` fixed-input batch ranked:

1. `Q4_1` as the lightest
2. `Q4_K_M` in the middle
3. `Q5_K_M` as the heaviest

Rule:

- If margin matters, try `Q4_1` first, then `Q4_K_M`, then `Q5_K_M`.

## Operator checklist

1. Confirm `torch.cuda.is_available()` is true.
2. Confirm ComfyUI is responding before queueing a long batch.
3. Use the committed API prompt when the workflow has not changed.
4. Record fixed inputs once and variable parameters per run.
5. Record generation time, peak VRAM, headroom, and output paths.
6. Verify local file size after pulling outputs back from the remote machine.
