# Scriptwide Rampant CJK
Rampart One with 3D effects removed

## Background
Fontworks released Rampart One under the OFL. However, only its 3D-styled characters are released.

Using scripts and manual glyph refining, I have (attempted to) remove the 3D style from Rampart One.

No additional glyphs should be added.

## `remove_contour.sh`
This is the script used to remove the outermost contour from a UFO font. Manual refinement is required to fully remove all 3D effects.

For best performance, run `sudo apt-get install -y xmlstarlet bc` before using the script.

The script should run on GNU/Linux, and assumes the UFO font is located at `~/Documents/RampartOne-Regular.ufo`.

`.bak` glyph backups are also generated, nearly doubling the size of the `/glyphs` folder.

Note that this script takes an exceptionally long time to process all glyphs. On my computer, it took around an hour to modify all 9175 glyphs in Rampart One.

## Licensing
All relevant font files are licensed under the OFL. "Rampart" is a reserved font name by Fontworks. Refer to `LICENSE-FONT` for details.

`remove_contour.sh` was generated with the help of DeepSeek and is licensed under the MIT License. Refer to `LICENSE-SCRIPT` for details.
