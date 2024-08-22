# AHK-Mouse-Heatmap

The "Mouse Click Heatmap" is a tool designed to visualize mouse click data, providing insights into user interaction patterns across a specified interface. This project utilizes both an AutoHotkey script for collecting mouse click data and a Python script to analyze and visualize these data points on a heatmap.

![image](https://github.com/ZeroOneZero/AHK-Mouse-Heatmap/assets/10876982/77c75132-e751-4e19-9312-a2767563a026)

![heatmap](https://github.com/ZeroOneZero/AHK-Mouse-Heatmap/assets/10876982/483dd7ab-f5a8-4594-8bb4-91f4a556faa7)

## Features

- **Data Collection**: Automate the tracking of mouse clicks, including position and button type.
- **Data Analysis**: Use clustering to identify frequent areas of clicks.
- **Heatmap Visualization**: Generate a visual heatmap representation of mouse clicks across the screen.
- **Tray Menu**: Access the GUI, generate a heatmap, or exit the script.
- **GUI**: Shows an updated count from previous sessions updated on the fly of total clicks (left, right, and middle).
  - For convenience, you can also generate a heatmap from the GUI via the dedicated button.

## Prerequisites

Before you begin, ensure you have met the following requirements:
- [AutoHotkey](https://www.autohotkey.com/) installed for running AHK scripts.
- [Python](https://www.python.org/downloads/) 3.8 or higher.
- Libraries: pandas, PIL, sklearn (Install using `pip install pandas Pillow scikit-learn`)

## Installation

Download the zip file via the green button above, or clone the repo to your local machine:

```bash
git clone https://github.com/ZeroOneZero/AHK-Mouse-Heatmap.git
cd AHK-Mouse-Heatmap
```

> [!IMPORTANT]
> To use the `git clone` on Windows, requries [git for windows](https://git-scm.com/download/win).

Install the required Python libraries:

```bash
pip install -r requirements.txt
```

## Usage

To start collecting data, double-click or use the following snippet to run the AutoHotkey script:

```bash
# Make sure AutoHotkey is installed
heatmap.ahk
```

After collecting enough data, run the Python script to generate the heatmap:

```bash
python generate_heatmap.py
```

The **heatmap.png** image will be saved in the project directory.
