function rec_bit_seq = Decoder(rec_sample_seq,fs)
rec_bit_seq = zeros(1,length(rec_sample_seq)/fs);
        zeros_f = 0;
        count = 1;
        for i = 1:fs:length(rec_sample_seq)
            for j = i:1:i+fs-1
                if (rec_sample_seq(j) == 0)
                    zeros_f=zeros_f+1;
                end
            end
            if (zeros_f >= fs/2)
                rec_bit_seq(count) = 0;
            else
                rec_bit_seq(count) = 1;
            end
            count = count + 1;
            zeros_f = 0;
        end