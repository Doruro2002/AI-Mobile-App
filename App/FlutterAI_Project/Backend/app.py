from flask import Flask, request, jsonify
from flask_cors import CORS
import tensorflow as tf
from PIL import Image
import numpy as np
import io
import base64

app = Flask(__name__)
CORS(app)  # Enable CORS for cross-origin requests

# Load TFLite model
interpreter = tf.lite.Interpreter(model_path="../flutterproject/assets/models/model7.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Load labels
with open("../flutterproject/assets/models/labels.txt", "r") as f:
    labels = [line.strip() for line in f.readlines()]


@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get the image data from POST request.
        image_b64 = request.json['image']
        image_bytes = base64.b64decode(image_b64)

      # Pre-process image
        image = Image.open(io.BytesIO(image_bytes)).convert('RGB')
        image = image.resize((64, 64))  # Resize to 64x64 pixels
        input_data = np.expand_dims(np.array(image, dtype=np.float32) / 255.0, axis=0)

        # Perform inference
        interpreter.set_tensor(input_details[0]['index'], input_data)
        interpreter.invoke()
        output_data = interpreter.get_tensor(output_details[0]['index'])

        # Process predictions
        predictions = [{"label": labels[i], "confidence": float(output_data[0][i])}
                        for i in range(len(labels))]
        predictions = sorted(predictions, key=lambda x: x['confidence'], reverse=True)

        return jsonify({"predictions": predictions[:5]})  # Top 5 predictions
    except Exception as e:
           return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)