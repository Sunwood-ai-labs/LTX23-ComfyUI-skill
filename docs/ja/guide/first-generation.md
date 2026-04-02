# 初回生成

## まずは短い検証から

長尺の lip-sync 動画に入る前に、短い verification render を先に回すのがおすすめです。

推奨の初回条件:

- image mode
- 短くてきれいな reference audio
- `960x544` または `480x832`
- `5` 秒
- 固定 seed

## 読み込む workflow

- [LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/LTX_2.3_Image_or_Text_%26_Audio_2_Video_App_V3.json)
- [ComfyUI_LTX2_3_TI2V.ipynb](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)

## 入力チェック

- prompt が入っている
- image が入っている
- audio が入っている
- setup guide に書かれた model が存在する
- `USE ONLY VOCALS` を意図して選んでいる

## 何を見るか

- MP4 が出る
- lip-sync と顔の見え方が破綻していない
- 秒数とアスペクト比がほぼ期待通り
- remote GPU machine が安定している

## 比較 batch のルール

model 比較が目的なら:

- prompt 固定
- image 固定
- audio 固定
- duration 固定
- 一度に変えるのは 1-2 個まで

API 実行だけで回したいときは、commit 済みの API prompt を使う方が安全です。
