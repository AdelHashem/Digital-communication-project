function x = PulseGen(t,dur,amp,sequance)
s_dur = 0;
e_dur = dur;
v = zeros(1,length(t));
for i =1:length(sequance)
    if sequance(i) == 1
    v = amp .* (t >=s_dur & t <= e_dur) + v;
    end
    s_dur = s_dur + dur;
    e_dur = e_dur + dur;
end
x = v;