# Source Materials

## Local Archived Files

- [sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb](../sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)
- [sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](../sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json)

## Upstream URLs

- Notebook collection root:
  - <https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main>
- LTX 2.3 ComfyUI subfolder:
  - <https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main/ComfyUI/ComfyUI_LTX2_3>
- LTX 2 official repository:
  - <https://github.com/Lightricks/LTX-2>
- ComfyUI-LTXVideo:
  - <https://github.com/Lightricks/ComfyUI-LTXVideo/>

## Provenance Notes

- The notebook is directly traceable to the upstream `ComfyUI_LTX2_3` folder.
- The archived App JSON in this repo is the user-provided `..._V3.json` variant.
- The currently visible upstream GitHub directory lists `LTX_2.3_Image_or_Text_&_Audio_2_Video_App.json` without the `V3` suffix, so treat the archived file here as the authoritative local reference for this repository.

## What Each Source Contributed

- Notebook
  - environment bootstrap
  - custom node list
  - model download URLs
  - launch modes
  - runtime notes
- App JSON
  - user-facing control labels
  - default values
  - mode switches
  - frame and audio-duration math
  - prompt guidance notes inside the workflow
- LTX 2 official repository
  - confirms the broader LTX 2 family and linked ecosystem
- ComfyUI-LTXVideo
  - canonical upstream node family for the LTX workflow

## Preservation Rule

Keep the archived upstream files immutable inside `sources/upstream/isi-dev/`. If you need to test edits, copy them elsewhere and document the derived file path.
