
# Mouse Click Heatmap

The "Mouse Click Heatmap" is a tool designed to visualize mouse click data, providing insights into user interaction patterns across a specified interface. This project utilizes both an AutoHotkey script for collecting mouse click data and a Python script to analyze and visualize these data points on a heatmap.

## Features

- **Data Collection**: Automate the tracking of mouse clicks including position and button type.
- **Data Analysis**: Use clustering to identify frequent areas of clicks.
- **Heatmap Visualization**: Generate a visual heatmap representation of mouse clicks across the screen.

## Prerequisites

Before you begin, ensure you have met the following requirements:
- AutoHotkey installed for running AHK scripts.
- Python 3.8 or higher.
- Libraries: pandas, PIL, sklearn (Install using `pip install pandas Pillow scikit-learn`)

## Installation

Clone the repo to your local machine:

```bash
git clone https://github.com/ZeroOneZero/AHK-Mouse-Heatmap.git
cd AHK-Mouse-Heatmap
```

Install the required Python libraries:

```bash
pip install -r requirements.txt
```

## Usage

To start collecting data, double-click or use the following snippet to run the AutoHotkey script:

```bash
# Make sure AutoHotkey is installed
AutoHotkey heatmap.ahk
```

After collecting enough data, run the Python script to generate the heatmap:

```bash
python generate_heatmap.py
```

The heatmap image will be saved in the project directory.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE5NjUzOTI0OSwxOTIwODQwNjEyLDEzOD
g0Mjk5OTBdfQ==
-->