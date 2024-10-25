from picamera2 import Picamera2

picam2 = Picamera2()
config = picam2.create_still_configuration()
picam2.configure(config)

picam2.start()

np_array = picam2.capture_array()
print(np_array)
filename = f"new_image.jpg"
picam2.capture_file(filename)
picam2.stop()

