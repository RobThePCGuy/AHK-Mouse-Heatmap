# AHK-Mouse-Heatmap

This AutoHotkey script logs the date, time, and x/y coordinates of individual left, right, and middle mouse clicks. It offers automatic GUI updates and can create a visual heatmap from the system tray or the GUI using Python. I use this tool just for fun. This repo may be used in your own projects, for profit or loss, but I do not accept liability for either.

![Screenshot of GUI](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/77c75132-e751-4e19-9312-a2767563a026)
![Screenshot of Heatmap](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/483dd7ab-f5a8-4594-8bb4-91f4a556faa7)

## Features

- **Easy Logging**: Automatically logs the date, time, and x/y coordinates of individual left, right, and middle mouse clicks.
- **Smart Analysis**: Pinpoints hotspots by clustering frequently clicked areas.
- **Visual Heatmap**: See where you click most with a colorful heatmap.
- **Live Click Count**: View live stats from the GUI, where you can also create a heatmap.
- **Tray Menu**: Show the GUI, create a heatmap, or close the script from the tray menu.

## Prerequisites

Before you get started, make sure you have:

- [AutoHotkey](https://www.autohotkey.com/) installed to run AHK scripts.

    > You may download and install [v2 AHK](https://www.autohotkey.com/download/ahk-v2.exe) since the application detects v1 scripts and will automatically install v1.

- [Python](https://www.python.org/downloads/) 3.8 or later.

   > Installation of `requirements.txt` (see below for steps) or just run `pip install pandas Pillow numpy scikit-learn`.

## Getting the Files:

To get started, download the zip file using the green button above or clone the repository to your local machine:

```bash
# Steps to clone repo locally
git clone https://github.com/RobThePCGuy/AHK-Mouse-Heatmap.git
cd AHK-Mouse-Heatmap
```

> [!IMPORTANT]
> If you're using `git clone` on Windows, you'll need [Git for Windows](https://git-scm.com/download/win) or [GitHub Desktop](https://desktop.github.com/download/).

## Installation

Install the necessary Python libraries:

```bash
pip install -r requirements.txt
# or pip install pandas Pillow numpy scikit-learn
```

## Usage

To start logging clicks, run `heatmap.ahk`.

After a few clicks, you are ready to generate a visual heatmap of the clustered areas you've been clicking. Do this via the GUI, found in the tray menu, or by clicking `Run Heatmap` from the tray menu.

A new file, **heatmap.png** will be saved in the project directory.

To exit out of the script and stop logging, right-click the tray icon and select the `Exit` option.

![tray](https://github.com/user-attachments/assets/f1299b25-ef1e-417e-abec-6acafbd16ac2)
