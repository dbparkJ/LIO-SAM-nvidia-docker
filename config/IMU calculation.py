import math

# Constants for conversion
micro_g_to_m_s2 = 9.81e-6  # 1 micro g to m/s²
deg_to_rad = math.pi / 180  # degrees to radians

# Accelerometer specifications
acc_noise_density_micro_g = 60  # µg/√Hz
acc_bias_stability_micro_g = 10  # µg (taking the x-axis bias stability as a reference)

# Gyroscope specifications
gyr_noise_density_deg = 0.007  # º/s/√Hz
gyr_bias_stability_deg_per_hour = 8  # deg/h

# Bandwidth for RMS calculation
bandwidth = 10  # Hz

# Convert noise densities to the proper units
acc_noise_density_m_s2 = acc_noise_density_micro_g * micro_g_to_m_s2  # m/s²/√Hz
gyr_noise_density_rad_s = gyr_noise_density_deg * deg_to_rad  # rad/s/√Hz

# Calculate RMS noise values for a bandwidth of 10 Hz
acc_noise_rms = acc_noise_density_m_s2 * math.sqrt(bandwidth)  # m/s²
gyr_noise_rms = gyr_noise_density_rad_s * math.sqrt(bandwidth)  # rad/s

# Convert gyroscope bias stability to rad/s (from deg/h to rad/s)
gyr_bias_stability_rad_s = (gyr_bias_stability_deg_per_hour * deg_to_rad) / 3600  # rad/s

# Convert accelerometer bias stability to m/s² (from µg to m/s²)
acc_bias_stability_m_s2 = acc_bias_stability_micro_g * micro_g_to_m_s2  # m/s²

acc_noise_rms, gyr_noise_rms, acc_bias_stability_m_s2, gyr_bias_stability_rad_s
