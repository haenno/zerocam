# save an image from raspberry pi camera to a file with a timestamp

import picamera
import time

camera = picamera.PiCamera()
timestamp = time.strftime('%Y%m%d-%H%M%S')
filename = 'image-' + timestamp + '.jpg'
camera.capture(filename)
camera.close()
