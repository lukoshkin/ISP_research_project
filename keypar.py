import numpy as np

def get_stats(w,ellipticity,endpoints):
    if np.prod(np.iscomplex(ellipticity)):
        ellipticity = abs(ellipticity)
        
    a,b = endpoints
    span = ((2 * np.pi * w > a) & (2 * np.pi * w < b)).nonzero()[0]
    mean = ellipticity[span].mean()
    maxi = ellipticity[span].max()
    
    return mean, maxi
