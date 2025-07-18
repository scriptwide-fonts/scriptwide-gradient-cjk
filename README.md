# Scriptwide Gradient CJK
Rampart One with 3D effects removed

## Background
Fontworks released Rampart One under the OFL. However, only its 3D-styled characters are released.

Using scripts and manual glyph refining, I have (attempted to) remove the 3D style from Rampart One.

No additional glyphs should be added.

## [`remove_contour.sh`](remove_contour.sh)
This is the script used to remove the outermost contour from a UFO font. Manual refinement is required to fully remove all 3D effects.

For best performance, run `sudo apt-get install -y xmlstarlet bc` before using the script.

The script should run on GNU/Linux, and assumes the UFO font is located at `~/Documents/RampartOne-Regular.ufo`.

`.bak` glyph backups are also generated, nearly doubling the size of the `/glyphs` folder.

Note that this script takes an exceptionally long time to process all glyphs. On my computer, it took around an hour to modify all 9175 glyphs in Rampart One.

### Generating a UFO file from Rampart One

The instructions below are for FontForge. Steps may vary for other font editors.

1. Open the Rampart One font file in FontForge.
2. Go to `File` > `Generate Fonts...`.
3. Select `Unified Font Object (UFO3)` and generate.

## Licensing
All relevant font files are licensed under the OFL. Rampart is a trademark of Fontworks Inc. Refer to [`LICENSE-FONT`](LICENSE-FONT) for details.

`remove_contour.sh` was generated with the help of DeepSeek and is licensed under the MIT License. Refer to [`LICENSE-SCRIPT`](LICENSE-SCRIPT) for details.
