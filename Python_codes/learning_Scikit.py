#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 23 15:56:54 2019

@author: lakshmibalasubramanian
"""
import matplotlib
import numpy as np
import matplotlib.pyplot as plt

import skimage
from skimage import data
from skimage import io

camera = data.camera()
type(camera)
image_size = camera.shape
plt.imshow(camera, 'gray')
minimum_int = camera.min()
maximum_int = camera.max()
mean_int = camera.mean()
print(minimum_int, maximum_int, mean_int)


inspec = io.imread('/Users/lakshmibalasubramanian/Documents/Lakshmi/Image_analysis_course/NCBS_image_analysis_course_2019_content/Day1_images/image-inspection/B.tif')
plt.imshow(inspec, 'gray')
