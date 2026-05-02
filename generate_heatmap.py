import csv
import math
import sys
from collections import Counter
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

LOG_FILE = Path("ClickLog.txt")
OUTPUT_FILE = Path("heatmap.png")
PADDING = 100
MIN_RADIUS = 18
MAX_RADIUS = 80
BLUR_RADIUS = 10

COLORS = {
    "Left": (0, 255, 0),
    "Right": (255, 0, 0),
    "Middle": (0, 120, 255),
}


def read_clicks(filepath):
    if not filepath.exists():
        print(f"Error: {filepath} was not found. Run heatmap.ahk first to collect clicks.")
        sys.exit(1)

    with filepath.open(newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        required_columns = {"date", "time", "click", "x", "y"}
        if not reader.fieldnames or not required_columns.issubset(reader.fieldnames):
            print("Error: ClickLog.txt must contain this CSV header: date,time,click,x,y")
            sys.exit(1)

        clicks = []
        for row in reader:
            try:
                click_type = row["click"]
                if click_type not in COLORS:
                    continue
                clicks.append({
                    "click": click_type,
                    "x": int(float(row["x"])),
                    "y": int(float(row["y"])),
                })
            except (TypeError, ValueError):
                continue

    if not clicks:
        print("Error: No valid clicks found in ClickLog.txt.")
        sys.exit(1)

    return clicks


def determine_canvas(clicks):
    max_x = max(click["x"] for click in clicks)
    max_y = max(click["y"] for click in clicks)
    return max_x + PADDING, max_y + PADDING


def draw_heatmap(clicks):
    image_size = determine_canvas(clicks)
    image = Image.new("RGB", image_size, "black")
    overlay = Image.new("RGBA", image_size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")

    click_counts = Counter((click["click"], click["x"], click["y"]) for click in clicks)
    max_count = max(click_counts.values())

    for (click_type, x, y), count in click_counts.items():
        scale = math.log1p(count) / math.log1p(max_count)
        radius = int(MIN_RADIUS + (MAX_RADIUS - MIN_RADIUS) * scale)
        alpha = int(70 + 185 * scale)
        red, green, blue = COLORS[click_type]
        draw.ellipse(
            [x - radius, y - radius, x + radius, y + radius],
            fill=(red, green, blue, alpha),
        )

    overlay = overlay.filter(ImageFilter.GaussianBlur(BLUR_RADIUS))
    image.paste(overlay, (0, 0), overlay)
    return image


def main():
    clicks = read_clicks(LOG_FILE)
    image = draw_heatmap(clicks)
    image.save(OUTPUT_FILE)
    print(f"Saved {OUTPUT_FILE} using {len(clicks)} clicks.")


if __name__ == "__main__":
    main()
