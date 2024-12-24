import os
import pathlib

def extract_class_names_os(data_dir):
    """Extracts class names using os.listdir."""
    try:
        class_names = [
            d for d in os.listdir(data_dir)
            if os.path.isdir(os.path.join(data_dir, d))
        ]
        return class_names
    except FileNotFoundError:
        print(f"Error: Directory not found at {data_dir}")
        return []
    except Exception as e:
        print(f"Error extracting class names using os: {e}")
        return []


def extract_class_names_pathlib(data_dir):
    """Extracts class names using pathlib."""
    try:
        data_path = pathlib.Path(data_dir)
        class_names = [
          str(d.name)
          for d in data_path.iterdir()
          if d.is_dir()
        ]
        return class_names
    except FileNotFoundError:
        print(f"Error: Directory not found at {data_dir}")
        return []
    except Exception as e:
      print(f"Error extracting class names using pathlib: {e}")
      return []

# Example usage
if __name__ == '__main__':
    data_directory = '../Dataset/train'  # Replace with your actual path

    class_names_os = extract_class_names_os(data_directory)
    if class_names_os:
        print("Class names extracted using os:")
        for name in class_names_os:
          print(name)
    else:
       print("No class names found using os")

    class_names_pathlib = extract_class_names_pathlib(data_directory)
    if class_names_pathlib:
       print("Class names extracted using pathlib:")
       for name in class_names_pathlib:
           print(name)
    else:
      print("No class names found using pathlib")