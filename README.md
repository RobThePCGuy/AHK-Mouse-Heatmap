# AHK-Mouse-Heatmap

A local Windows click heatmap for seeing where you actually click.

AHK-Mouse-Heatmap records left, right, and middle mouse-click positions, keeps simple live counts in a small AutoHotkey GUI, and generates a `heatmap.png` that visualizes your click patterns.

It is useful for quick UI testing, personal workflow curiosity, game or app layout analysis, and accessibility reviews where you want a local record of pointer activity.

![Screenshot of GUI](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/77c75132-e751-4e19-9312-a2767563a026)
![Screenshot of Heatmap](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/483dd7ab-f5a8-4594-8bb4-91f4a556faa7)

## What it does

- Logs mouse-click date, time, button type, and x/y screen position.
- Tracks left, right, and middle click counts live in a simple GUI.
- Generates a local heatmap image from your click log.
- Uses the tray menu to show the GUI, generate the heatmap, or exit.
- Runs locally. No network service is used by this project.

## Privacy

This tool records mouse-click metadata only:

```csv
date,time,click,x,y
```

It does not record screenshots, keystrokes, window titles, browser history, file contents, or network traffic.

The click log is written locally to `ClickLog.txt` in the project folder. Delete that file any time to clear your click history. Generated heatmaps are saved locally as `heatmap.png`.

## Download

For most users, download the latest Windows release ZIP from the GitHub Releases page.

The release ZIP contains:

- `AHK-Mouse-Heatmap.exe`: the click tracker and GUI.
- `generate_heatmap.exe`: the bundled heatmap generator.
- `README.md`: usage and privacy notes.

Keep both `.exe` files in the same folder. `AHK-Mouse-Heatmap.exe` calls `generate_heatmap.exe` when you choose `Run Heatmap`.

## Usage from release ZIP

1. Download and unzip `AHK-Mouse-Heatmap-Windows.zip`.
2. Run `AHK-Mouse-Heatmap.exe`.
3. Click normally for a while.
4. Right-click the tray icon and choose `Run Heatmap`, or open the GUI and click `Run Heatmap`.
5. Open `heatmap.png` from the same folder.
6. Right-click the tray icon and choose `Exit` to stop logging.

![tray](https://github.com/user-attachments/assets/f1299b25-ef1e-417e-abec-6acafbd16ac2)

## Run from source

If you prefer to run the scripts directly, install:

- Windows
- [AutoHotkey](https://www.autohotkey.com/)
- [Python](https://www.python.org/downloads/) 3.8 or newer

The Python heatmap generator only requires Pillow:

```bash
git clone https://github.com/RobThePCGuy/AHK-Mouse-Heatmap.git
cd AHK-Mouse-Heatmap
pip install -r requirements.txt
```

Then run `heatmap.ahk`.

On Windows, cloning requires [Git for Windows](https://git-scm.com/download/win) or [GitHub Desktop](https://desktop.github.com/download/). Downloading the ZIP does not require Git.

## Build a Windows release ZIP

This repo includes a GitHub Actions workflow that builds `AHK-Mouse-Heatmap-Windows.zip`.

To build manually:

1. Open the repo on GitHub.
2. Go to `Actions`.
3. Select `Build Windows Release`.
4. Click `Run workflow`.
5. Download the `AHK-Mouse-Heatmap-Windows` artifact from the completed workflow run.

To attach the ZIP to a GitHub Release, create and push a tag that starts with `v`, such as `v0.1.0`. The workflow will build the ZIP and attach it to the release automatically.

## Output files

`ClickLog.txt` is created automatically when you run the tracker. It is ignored by Git because it contains local activity data.

`heatmap.png` is created when you run the heatmap generator. It is also ignored by Git because it is generated output.

## Notes

This is a small local utility, not a full analytics product. Review the scripts before use if you are uncomfortable running input-hook tools.

This repo may be used in your own projects, for profit or loss, but I do not accept liability for either.
