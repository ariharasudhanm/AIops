from ultralytics import YOLO

# model = YOLO("yolo11n-seg.pt")
# model.predict("bus.jpg", save=True, imgsz=320, conf=0.5)
# model.export(format="onnx")

onnx_model = YOLO("yolo11n-seg.onnx")
results = onnx_model("https://ultralytics.com/images/bus.jpg")
