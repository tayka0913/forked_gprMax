function f = fftfreq(N, dt)
    f = fftshift(1/2/dt * (-N/2:N/2-1));
end