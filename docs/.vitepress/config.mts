import { defineConfig } from "vitepress";

export default defineConfig({
  title: "LTX2.3 ComfyUI Skill Repo",
  description: "Remote GPU automation and workflow docs for LTX 2.3 Text or Image plus Audio to Video with ComfyUI.",
  base: "/LTX23-ComfyUI-skill/",
  lastUpdated: true,
  cleanUrls: true,
  head: [["link", { rel: "icon", href: "/logo.svg" }]],
  themeConfig: {
    logo: "/logo.svg",
    socialLinks: [
      { icon: "github", link: "https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill" }
    ],
    footer: {
      message: "Released under the MIT License.",
      copyright: "Copyright 2026 Sunwood-ai-labs"
    }
  },
  locales: {
    root: {
      label: "English",
      lang: "en-US",
      themeConfig: {
        nav: [
          { text: "Guide", link: "/guide/remote-gpu-setup" },
          { text: "Reference", link: "/guide/workflow-reference" },
          { text: "GitHub", link: "https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill" }
        ],
        sidebar: {
          "/guide/": [
            { text: "Remote GPU Setup", link: "/guide/remote-gpu-setup" },
            { text: "First Generation", link: "/guide/first-generation" },
            { text: "Workflow Reference", link: "/guide/workflow-reference" }
          ]
        },
        outlineTitle: "On this page"
      }
    },
    ja: {
      label: "日本語",
      lang: "ja-JP",
      link: "/ja/",
      themeConfig: {
        nav: [
          { text: "ガイド", link: "/ja/guide/remote-gpu-setup" },
          { text: "リファレンス", link: "/ja/guide/workflow-reference" },
          { text: "GitHub", link: "https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill" }
        ],
        sidebar: {
          "/ja/guide/": [
            { text: "Remote GPU セットアップ", link: "/ja/guide/remote-gpu-setup" },
            { text: "初回生成", link: "/ja/guide/first-generation" },
            { text: "Workflow リファレンス", link: "/ja/guide/workflow-reference" }
          ]
        },
        outlineTitle: "このページ"
      }
    }
  }
});
