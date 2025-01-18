import subprocess
import os
from flask import Flask, request, jsonify
# In a real project, use joblib or pickle
# import joblib 

app = Flask(__name__)

# This mock "ML model" classifies a Mandelbrot coordinate into a zone
# based on its escape time 'n', which is calculated by the C program.
#
# Zone Definitions:
# - Zone 0 (n=1000): "The Deep Set" - Points that likely never escape.
# - Zone 1 (100 < n < 1000): "The Borderlands" - Complex, interesting edges.
# - Zone 2 (n <= 100): "The Abyss" - Points that escape quickly.
def predict_zone(escape_n):
    """Mock ML model logic."""
    print(f"Model predicting for escape_n: {escape_n}")
    if escape_n == 1000:
        return "Zone 0: The Deep Set"
    elif escape_n > 100:
        return "Zone 1: The Borderlands"
    else:
        return "Zone 2: The Abyss"

# Path to the compiled C utility. The Makefile places it in the same directory.
extractor_path = os.path.join(os.path.dirname(__file__), 'escape_time')

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    
    if not data or "x" not in data or "y" not in data:
        return jsonify({"error": "Missing 'x' or 'y' key in JSON payload."}), 400
        
    try:
        x_coord = float(data["x"])
        y_coord = float(data["y"])
    except ValueError:
        return jsonify({"error": "Invalid coordinates. 'x' and 'y' must be numbers."}), 400
            
    x_str = str(x_coord)
    y_str = str(y_coord)
    
    try:
        process = subprocess.run(
            [extractor_path, x_str, y_str],
            text=True,
            capture_output=True,
            check=True, 
            timeout=5
        )
        
        output = process.stdout.strip()
        escape_n = int(output)

    except subprocess.CalledProcessError as e:
        error_message = e.stderr.strip() if e.stderr else "C program failed."
        return jsonify({"error": f"Invalid input: {error_message}"}), 400
    
    except subprocess.TimeoutExpired:
        return jsonify({"error": "C program timed out."}), 500
        
    except FileNotFoundError:
        return jsonify({"error": "Feature extractor binary not found."}), 500
        
    except ValueError:
        return jsonify({"error": f"C program gave un-parseable output: {output}"}), 500
            
    prediction = predict_zone(escape_n)
    
    return jsonify({
        "coordinates": {"x": x_coord, "y": y_coord},
        "computed_feature (escape_n)": escape_n,
        "model_prediction": prediction
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 