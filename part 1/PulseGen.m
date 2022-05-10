function x = PulseGen(t,dur,amp,start)
if start == 1
    v = amp .* ( t <=dur);
else
    v = amp .* ( t >=dur & t <= 2*dur);
end
x = v