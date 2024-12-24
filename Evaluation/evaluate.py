
import os

import keras
from PIL import Image
import tensorflow as tf

import numpy as np

import os
from PIL import Image


def load_test_data(test_dir, image_size=(128, 128)):
    images = []
    labels = []
    classes = sorted(os.listdir(test_dir))  # Ensures consistent class order
    class_to_idx = {c: i for i, c in enumerate(classes)}

    for class_name in classes:
        class_dir = os.path.join(test_dir, class_name)
        for file_name in os.listdir(class_dir):
            if file_name.lower().endswith((".png", ".jpg", ".jpeg")):
                file_path = os.path.join(class_dir, file_name)
                try:
                    img = Image.open(file_path).convert("RGB")
                    img = img.resize(image_size)
                    img = np.asarray(img) / 255.0  # Normalize to [0, 1]

                    images.append(img)
                    labels.append(class_to_idx[class_name])

                except Exception as e:
                    print(f"Warning: Could not open {file_path}, reason: {e}")

    x_test = np.stack(images)
    y_test = np.array(labels)
    y_test = keras.utils.to_categorical(y_test)
    return x_test, y_test
model_path = 'your_fruit_model.keras'  # Replace with your model path
test_dir = "path_to_your_test_data"  # Replace with the actual path to your test folder

image_size = (128, 128)  # Make sure this matches the training size

x_test, y_test = load_test_data(test_dir, image_size)

try:
    model = keras.models.load_model(model_path)
    if model:
        loss, *metrics = model.evaluate(x_test, y_test, verbose=1)
        print(f"Loss: {loss}")

        if len(metrics) > 0:
            metric_names = model.metrics_names[1:]
            for name, value in zip(metric_names, metrics):
                print(f"{name}: {value}")

        # Example for extra metrics
        y_pred = np.argmax(model.predict(x_test), axis=1)  # Converts probabilities to classes
        y_true = np.argmax(y_test, axis=1)  # Converts categorical labels to classes

        precision = precision_score(y_true, y_pred, average="weighted")
        recall = recall_score(y_true, y_pred, average="weighted")
        f1 = f1_score(y_true, y_pred, average="weighted")

        print(f"Precision: {precision}")
        print(f"Recall: {recall}")
        print(f"F1 Score: {f1}")

except Exception as e:
    print(f"Error loading model: {e}")