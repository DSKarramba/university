import numpy as np
import cv2
from sys import argv

face_file = './haarcascade_frontalface_default.xml'

if __name__ == '__main__':
    face_cascade = cv2.CascadeClassifier(face_file)
    img = cv2.imread(argv[1])
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 5)
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
    
    cv2.imshow('frame', img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()