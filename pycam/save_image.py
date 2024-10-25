# save an image from raspberry pi camera to a file with a timestamp

from picamzero import Camera
import time

cam = Camera()
cam.start_preview()
timestamp = time.strftime('%Y%m%d-%H%M%S')
filename = 'image-' + timestamp + '.jpg'
cam.take_photo(filename)

