import numpy as np

def automatic():
    path = "data/"
    with open(path + "dt") as file:
        dt = float(file.read())

    with open(path + "numberoftimesteps") as file:
        NofTS = int(file.read())

    traces = np.fromfile(path + "traces/traces.dat",
                         dtype=np.float_).reshape(NofTS+1,12)

    t = np.arange(0.,NofTS+1) * dt

    reflected_p = traces[:,3]
    reflected_s = traces[:,4]

    PulseX = reflected_p
    PulseY = reflected_s
    
    spy =(np.fft.fft(PulseX)) * dt
    spz =(np.fft.fft(PulseY)) * dt
    w = np.fft.fftfreq(len(spy),d=dt)

    S0 = np.real(spy * np.conjugate(spy) + spz * np.conjugate(spz))
    S3 = -2 * np.imag(spy * np.conjugate(spz))

    chi = 0.5 * np.arcsin(S3 / S0)
    ellipticity = np.tan(chi)
    
    return w, ellipticity
