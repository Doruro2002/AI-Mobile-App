import tensorflow as tf

model = tf.keras.models.load_model('../Saved Models/best_model_70.keras')
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open('model7.tflite', 'wb') as f:
    f.write(tflite_model)