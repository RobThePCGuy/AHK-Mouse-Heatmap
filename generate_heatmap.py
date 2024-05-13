import pandas as pd
from PIL import Image, ImageDraw, ImageFilter
import numpy as np
from sklearn.cluster import DBSCAN
import sys

def read_click_log(filepath):
    try:
        return pd.read_csv(filepath)
    except FileNotFoundError:
        print("Error: File not found", filepath)
        sys.exit(1)

def perform_clustering(data, eps, min_samples):
    coords = data[['x', 'y']].to_numpy()
    clustering = DBSCAN(eps=eps, min_samples=min_samples).fit(coords)
    return clustering.labels_, coords

def create_heatmap(coords, labels, image_size, colors):
    image = Image.new('RGB', image_size, 'black')
    draw = ImageDraw.Draw(image)
    
    for label in set(labels):
        if label == -1:  # Ignore noise
            continue
        class_member_mask = (labels == label)
        xy = coords[class_member_mask]
        if xy.size == 0:  # Check if xy is empty
            continue

        intensity = max(1, min(255, np.log1p(len(xy)) * 2))  # Using logarithmic scaling
        radius = min(25, len(xy) * 1)
        color = choose_color(label, colors)
        color_with_intensity = adjust_color_intensity(color, intensity)
        draw_cluster(draw, xy, radius, color_with_intensity)
    
    return image

def choose_color(label, colors):
    return colors['Left'] if label % 3 == 0 else colors['Right'] if label % 3 == 1 else colors['Middle']

def adjust_color_intensity(color, intensity):
    # Ensures that each component of the color is an integer
    return tuple(int(min(base + intensity, 255)) for base in color)

def draw_cluster(draw, points, radius, color):
    color = tuple(int(c) for c in color)  # Convert color components to integer
    radius = int(radius)  # Ensure radius is an integer
    for point in points:
        x, y = map(int, point)  # Ensure points are used as integers
        draw.ellipse([x - radius, y - radius, x + radius, y + radius], fill=color)

df = read_click_log("ClickLog.txt")
labels, coords = perform_clustering(df, 0.1, 1)
colors = {'Left': (0, 255, 0), 'Right': (255, 0, 0), 'Middle': (0, 0, 255)}
image = create_heatmap(coords, labels, (4096, 2160), colors)
image = image.filter(ImageFilter.GaussianBlur(0))  # Blur radius
image.save("heatmap.png")