function [mf,mt] = ideal(signal,cutoff,f)
H=1.*(abs(f)<=cutoff);
X=fftshift(fft(signal));
mf=X.*H;
mt=real(ifft(ifftshift(mf)));
end

