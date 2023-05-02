# EmuLatest

Searches through directories for known emulator executable files, lets you customize the results and update all found emulators to the latest version.  It supports over 300 emulators.

![Screenshot](screenshot.png)

## How it works

* Emulators information comes from [detain/scoop-emulators](https://github.com/detain/scoop-emulators), which utilizes GitHub Actions to periodically check a set of urls using simple regexes and scripts to determine latest version and url information.
* PowerShell script using Windows.Forms for UI elements.
  * UI Designed in Visual Studio 2022 using the visual designer for a C# Form
  * PowerShell Module Convert-Form used to covnert the C# form to a PowerShell script
  * PS2EXE used to convert the PowerShell into an .Exe/Installer

## TODO

* [x] Design UI in VS C#
* [x] Convert to PS Form
* [x] Download and Extract Emulator data archive
* [x] Load emulator data
* [x] Get Directories from UI/User
* [x] Render emulators in UI
* [x] Scan Dirs for Matches
* [x] Get Bins
* [x] Display Matches
* [x] remove repo on close
* [x] fix database group element distribution/sizing
* [ ] fix logo display / scaling
* [ ] add check all button to discovered emulators
* [x] fix width on disco emulators sections
* [x] add saving/loading discovered/emulators and such
* [ ] change code around to avoid globals
* [ ] Ensure all bins are returned
* [ ] use caching so you dont reaload the data every time you click an emulator
* [x] better extractDir handling
* [ ] Upgrade Emulators
* [x] Auto-Resize Elements to match window size
* [ ] progress bar/status while scanning
* [ ] Auto Update
* [ ] GitHub Action setup
* [ ] Documentation
* [ ] Website

## Dev Links

* [AlbanCrepel/compiiile: The most convenient way to render a folder containing markdown files. Previewing and searching markdown files has never been that easy.](https://github.com/AlbanCrepel/compiiile)
* [ArcherGu/fast-vite-electron: Vite + Electron with esbuild, so fast! ⚡](https://github.com/ArcherGu/fast-vite-electron)
* [ArcherGu/fast-vite-nestjs-electron: Vite + Electron + Nestjs with esbuild, crazy fast! ⚡](https://github.com/ArcherGu/fast-vite-nestjs-electron)
* [Awesome Vite (vitejs/awesome-vite) Overview - Track Awesome List](https://www.trackawesomelist.com/vitejs/awesome-vite/readme/)
* [BroJenuel/vue-3-vite-electron-typescript: This is a template to be used when developing an electron](https://github.com/BroJenuel/vue-3-vite-electron-typescript)
* [Common Configuration - electron-builder](https://www.electron.build/configuration/configuration.html)
* [Configuring Vite | Vite](https://v2.vitejs.dev/config/#resolve-alias)
* [Deluze/electron-vue-template: Simple Vue3 + Electron starter template in TypeScript, including ViteJS and Electron Builder](https://github.com/Deluze/electron-vue-template)
* [Dunqing/vite-plugin-dynamic-import-module: A vite plugin to support variables in dynamic imports module in Vite](https://github.com/Dunqing/vite-plugin-dynamic-import-module)
* [Examples | Awesome Vue.js](https://awesome-vue.js.org/resources/examples.html)
* [Functions | VueUse](https://vueuse.org/functions.html)
* [Geocld/vite-plugin-importus: Modularly import plugin, compatible with antd, lodash, material-ui and so on.](https://github.com/Geocld/vite-plugin-importus)
* [Getting Started - Electron Forge](https://www.electronforge.io/)
* [Getting Started | Vite](https://vitejs.dev/guide/)
* [IndexXuan/vue-cli-plugin-vite: Use vite today, with vue-cli.](https://github.com/IndexXuan/vue-cli-plugin-vite)
* [KesionX/vite-plugin-head: Modify, add, delete Metadata in the head element.](https://github.com/KesionX/vite-plugin-head)
* [Next Generation Electron Build Tooling | electron-vite](https://evite.netlify.app/)
* [Plugin API | Vite](https://vitejs.dev/guide/api-plugin.html#vite-specific-hooks)
* [Plugin API | Vite](https://vitejs.dev/guide/api-plugin.html)
* [PowerShell Multithreading: A Deep Dive](https://adamtheautomator.com/powershell-multithreading/#Runspaces_Kinda_Like_Jobs_but_Faster)
* [Sample scripts for system administration - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/samples/sample-scripts-for-administration?view=powershell-7.2)
* [Scaffold | Awesome Vue.js](https://awesome-vue.js.org/components-and-libraries/scaffold.html)
* [VeeValidate: Painless Vue.js forms](https://vee-validate.logaretm.com/v4)
* [Vite Plugin - Electron Forge](https://www.electronforge.io/config/plugins/vite)
* [Vue 3 + Vite + TypeScript + ELECTRON (My Full Setup) - DEV Community](https://dev.to/brojenuel/vue-3-vite-typescript-electron-my-full-setup-kgm)
* [Vue-cli3+adminlte quickly builds a background management template..._adminlte vue_Chasing ぢ's Blog-CSDN Blog](https://blog.csdn.net/weixin_43330752/article/details/88073837)
* [WarrenJones/vite-plugin-require-transform: A plugin for vite that convert from require syntax to import](https://github.com/WarrenJones/vite-plugin-require-transform)
* [XiSenao/vite-plugin-externals-extension: External links plugin which supports ESM and UMD for vite.](https://github.com/XiSenao/vite-plugin-externals-extension)
* [alex8088/electron-vite: Next generation Electron build tooling based on Vite 新一代 Electron 开发构建工具，支持源代码保护](https://github.com/alex8088/electron-vite)
* [alex8088/vite-plugin-electron-config: Electron plugin for Vite](https://github.com/alex8088/vite-plugin-electron-config)
* [antfu/unplugin-auto-import: Auto import APIs on-demand for Vite, Webpack and Rollup](https://github.com/antfu/unplugin-auto-import)
* [antfu/unplugin-vue-components: 📲 On-demand components auto importing for Vue](https://github.com/antfu/unplugin-vue-components)
* [antfu/vite-plugin-inspect: Inspect the intermediate state of Vite plugins](https://github.com/antfu/vite-plugin-inspect)
* [bundle-tools/CHANGELOG.md at main · intlify/bundle-tools · GitHub](https://github.com/intlify/bundle-tools/blob/main/packages/vite-plugin-vue-i18n/CHANGELOG.md)
* [bundle-tools/packages/unplugin-vue-i18n at main · intlify/bundle-tools · GitHub](https://github.com/intlify/bundle-tools/tree/main/packages/unplugin-vue-i18n)
* [caoxiemeihao/electron-forge-vite: For test "electron-forge" Vite template.](https://github.com/caoxiemeihao/electron-forge-vite)
* [caoxiemeihao/vite-electron-plugin: High-performance, esbuild-based Vite Electron plugin](https://github.com/caoxiemeihao/vite-electron-plugin)
* [cawa-93/vite-electron-builder: Secure boilerplate for Electron app based on Vite. TypeScript + Vue/React/Angular/Svelte/Vanilla](https://github.com/cawa-93/vite-electron-builder)
* [chenxch/vite-plugin-dynamic-base: Resolve all resource files dynamic publicpath, like Webpack's __webpack_public_path__](https://github.com/chenxch/vite-plugin-dynamic-base)
* [crcong/vite-plugin-externals: use to external resources](https://github.com/crcong/vite-plugin-externals)
* [cssninjaStudio/unplugin-fonts: Universal Webfont loader - Unfonts - based on https://web.dev/optimize-webfont-loading/](https://github.com/cssninjaStudio/unplugin-fonts)
* [ebeloded/vite-plugin-redirect](https://github.com/ebeloded/vite-plugin-redirect)
* [electron-builder](https://www.electron.build/)
* [electron-vite/create-electron-vite: Scaffolding Your Electron + Vite Project](https://github.com/electron-vite/create-electron-vite)
* [electron-vite/electron-vite-boilerplate: 📚 Really simple Electron + Vite boilerplate.](https://github.com/electron-vite/electron-vite-boilerplate)
* [electron-vite/electron-vite-vue: 🥳 Really simple Electron + Vite + Vue boilerplate.](https://github.com/electron-vite/electron-vite-vue)
* [electron-vite/vite-plugin-electron-renderer: Support use Node.js API in Electron-Renderer](https://github.com/electron-vite/vite-plugin-electron-renderer)
* [electron-vite/vite-plugin-electron: 🔗 ⚡️](https://github.com/electron-vite/vite-plugin-electron)
* [erdkse/adminlte-3-vue: Vue 3.2.39 start-up project with AdminLTE 3.2.0 template](https://github.com/erdkse/adminlte-3-vue)
* [feat-agency/vite-plugin-webfont-dl: ⚡ Webfont Download Vite Plugin - Make your Vite site load faster](https://github.com/feat-agency/vite-plugin-webfont-dl)
* [fi3ework/vite-plugin-checker: 💬 Vite plugin that provide checks of TypeScript, ESLint, vue-tsc, Stylelint and more.](https://github.com/fi3ework/vite-plugin-checker)
* [hydrati/vitectron: Powerful Vue Desktop Application Template](https://github.com/hydrati/vitectron)
* [intlify/bundle-tools: bundling for intlify i18n tools](https://github.com/intlify/bundle-tools/tree/main)
* [jooy2/vutron: 💚 Quick Start Templates for Vite + Electron + Vue 3 + Vuetify + TypeScript. Vutron is a preconfigured template for developing Electron cross-platform desktop apps. It uses Vue 3 and allows you to build a fast development environment with little effort.](https://github.com/jooy2/vutron)
* [kefranabg/awesome-vue-composition-api: 🚀 A curated list of awesome things related to vue composition api](https://github.com/kefranabg/awesome-vue-composition-api)
* [kirklin/unplugin-config: 🔧 Configuration file generator for web apps, allowing external customization of global variables without repackaging.](https://github.com/kirklin/unplugin-config)
* [onebay/vite-plugin-imp: A vite plugin for import library component style automatic.](https://github.com/onebay/vite-plugin-imp)
* [pd4d10/npmview: A web application to view npm package files](https://github.com/pd4d10/npmview)
* [sanyuan0704/vite-plugin-chunk-split: A vite plugin for better chunk splitting. 一个简单易用的 Vite 拆包插件](https://github.com/sanyuan0704/vite-plugin-chunk-split)
* [sindresorhus/awesome-electron: Useful resources for creating apps with Electron](https://github.com/sindresorhus/awesome-electron)
* [starter-vue3-adminlte3/package.json at main · carlospccarvalho/starter-vue3-adminlte3 · GitHub](https://github.com/carlospccarvalho/starter-vue3-adminlte3/blob/main/package.json)
* [tada5hi/vitron: This is a library to build beautiful (win, linux, mac) desktop apps for modern web projects with vite and electron.](https://github.com/tada5hi/vitron)
* [umbrella22/electron-vite-template: This project is a vue3 + Vite + electron project template composed of Vite and rollup. It has the same functions as my previous electron+Vue+template project](https://github.com/umbrella22/electron-vite-template)
* [unimorphic / vite-plugin-linter — Bitbucket](https://bitbucket.org/unimorphic/vite-plugin-linter/src/master/)
* [vite-plugin/vite-plugin-dynamic-import: Enhance Vite builtin dynamic import](https://github.com/vite-plugin/vite-plugin-dynamic-import)
* [vite-plugin/vite-plugin-optimizer: Manually Pre-Bundling of Vite](https://github.com/vite-plugin/vite-plugin-optimizer)
* [vite-plugin/vite-plugin-resolve: Custom resolve module content](https://github.com/vite-plugin/vite-plugin-resolve)
* [vite-plugin/vite-plugin-target: Make Vite support Electron, Node.js, etc.](https://github.com/vite-plugin/vite-plugin-target)
* [vite-plugins/packages/vite-plugin-external at main · fengxinming/vite-plugins · GitHub](https://github.com/fengxinming/vite-plugins/tree/main/packages/vite-plugin-external)
* [vite-pwa/vite-plugin-pwa: Zero-config PWA for Vite](https://github.com/vite-pwa/vite-plugin-pwa)
* [vitejs/awesome-vite: ⚡️ A curated list of awesome things related to Vite.js](https://github.com/vitejs/awesome-vite)
* [vue-composable](https://pikax.me/vue-composable/#introduction)
* [vuejs/awesome-vue: 🎉 A curated list of awesome things related to Vue.js](https://github.com/vuejs/awesome-vue)
* [vuejs/vitepress: Vite & Vue powered static site generator.](https://github.com/vuejs/vitepress)
* [vuesomedev/awesome-vue-3: A curated list of awesome things related to Vue 3](https://github.com/vuesomedev/awesome-vue-3)
* [wangzongming/vite-plugin-require: vite projects to support require](https://github.com/wangzongming/vite-plugin-require)
* [yingpengsha/vite-plugin-tips: 🏷 Provide better development server status tips on the page.](https://github.com/yingpengsha/vite-plugin-tips)
* [yracnet/vite-plugin-api: Create API routes from path directory like to Nextjs](https://github.com/yracnet/vite-plugin-api)
* [z-ti/vite-plugin-clean: A vite plugin to remove/clean your build folder(s).](https://github.com/z-ti/vite-plugin-clean)
