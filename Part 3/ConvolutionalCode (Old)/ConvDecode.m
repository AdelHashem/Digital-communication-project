function [x] = ConvDecode(bits,trellis)
tb = 4;
x = vitdec(bits,trellis,tb,'trunc','hard');
end