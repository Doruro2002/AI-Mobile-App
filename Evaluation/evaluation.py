import tensorflow as tf
from keras.src.legacy.preprocessing.image import ImageDataGenerator
from keras.src.saving import load_model

# Step 1: Load the Model
# Ensure the path to the model file is correct
model = load_model('best_model_70.keras')

# Step 2: Prepare the Dataset
# Assuming you have a directory 'Dataset/test' with subdirectories for each class
test_datagen = ImageDataGenerator(rescale=1./255)
test_generator = test_datagen.flow_from_directory(
    '../Dataset/train',
    target_size=(64, 64),  # Update the target size based on your model's input shape
    batch_size=32,
    class_mode='categorical',
    shuffle=False
)

# Step 3: Evaluate the Model
evaluation = model.evaluate(test_generator)

# Print the evaluation metrics
for metric_name, metric_value in zip(model.metrics_names, evaluation):
    print(f"{metric_name}: {metric_value}")
