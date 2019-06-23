from skimage.restoration import denoise_nl_means, estimate_sigma
from skimage import img_as_float, img_as_ubyte
from skimage import io
import numpy as np

image = img_as_float(io.imread("lena.jpg")).astype(np.float32)

sigma_est = np.mean(estimate_sigma(image, multichannel=True))
print("estimated noise standard deviation = {}".format(sigma_est))
