# Pocket Playtime DEMO

A game inspired by the WarioWare series, for Playdate.

## Project structure

```
source/
├─ libraries/
│  │  ** Third-party libraries **
│  ├─ roomy.lua
│  ├─ animatedSprite.lua
│  └─ ...
├─ rooms/
│  ├─ microgames/
│  │  │  ** Each microgame is self-contained **
│  │  ├─ microgameA.lua
│  │  ├─ microgameB.lua
│  │  └─ ...
│  │  ** Other rooms, like menus and other screens **
│  ├─ roomA.lua
│  ├─ roomB.lua
│  └─ ...
├─ scripts/
│  │  ** User-made scripts and modules **
│  ├─ myScript.lua
│  └─ ...
├─ utilities/
│  │  ** Self-contained functions **
│  ├─ myFunction.lua
│  └─ ...
├─ assets/
│  │  ** Each microgame gets its own asset folder, for convenience **
│  ├─ microgameA/
│  │  ├─ imageA.png
│  │  ├─ imageB.png
│  │  ├─ sound.wav
│  │  └─ ...
│  ├─ microgameB/
│  │  ├─ imageA.png
│  │  ├─ imageB.png
│  │  ├─ sound.wav
│  │  └─ ...
│  ├─ .../
│  │  ** Other assets **
│  ├─ imageA.png
│  ├─ imageB.png
│  ├─ sound.wav
│  └─ ...
main.lua
```