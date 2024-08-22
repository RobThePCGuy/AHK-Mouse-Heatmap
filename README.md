# AHK-Mouse-Heatmap

An AutoHotkey script that records and visualizes left, right, and middle mouse clicks, including date, time, and x/y coordinates. It features automatic GUI updates and generates a visual heatmap via a Python script accessible from the system tray. This tool is ideal for analyzing user interaction and creating detailed mouse activity maps.

![image](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/77c75132-e751-4e19-9312-a2767563a026)

![heatmap](https://github.com/RobThePCGuy/AHK-Mouse-Heatmap/assets/10876982/483dd7ab-f5a8-4594-8bb4-91f4a556faa7)

## Features

- **Easy Tracking**: Automatically logs your mouse clicks, noting the position and button used.
- **Smart Analysis**: Pinpoints hotspots by clustering frequent click areas.
- **Visual Heatmap**: See where you click most with a colorful heatmap.
- **Handy Tray Menu**: Quickly access the GUI, create a heatmap, or close the script.
- **Live Click Count**: The GUI keeps a live tally of all your clicks, updated on the fly. Plus, you can generate a heatmap right from the tray menu for quick insights.

## Prerequisites

Before you get started, make sure you have:

- [AutoHotkey](https://www.autohotkey.com/) installed to run AHK scripts.
- [Python](https://www.python.org/downloads/) 3.8 or later.
- Required Python libraries: `pandas`, `Pillow`, and `scikit-learn` (Install them using `pip install pandas Pillow scikit-learn`). 

This will ensure everything runs smoothly!

## Installation

To get started, download the zip file using the green button above or clone the repository to your local machine:

```bash
git clone https://github.com/ZeroOneZero/AHK-Mouse-Heatmap.git
cd AHK-Mouse-Heatmap
```

> [!IMPORTANT]
> If you're using `git clone` on Windows, you'll need [Git for Windows](https://git-scm.com/download/win) installed.

## Installation

Install the necessary Python libraries:

```bash
pip install -r requirements.txt
```

## Usage

To start collecting data, double-click `heatmap.ahk` or run it using:

```bash
# Make sure AutoHotkey is installed
heatmap.ahk
```

After gathering enough data, generate the heatmap by running the Python script:

```bash
python generate_heatmap.py
```

The **heatmap.png** will be saved in the project directory. Right-click the tray icon to generate the heatmap and view the statistics GUI.

![tray](https://github.com/user-attachments/assets/f1299b25-ef1e-417e-abec-6acafbd16ac2)
