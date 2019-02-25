data = load('campanadetalle.txt');

freqs = data(:,1);
volts = data(:,2);


amax = max(volts);
wr = max(freqs);

al = amax - amax/2;
au = amax + amax/2;

f = [];

for j = 1:length(volts)
    if al < volts(j) & volts(j) < au
        f = [f freqs(j)];
    end
end

f;
af = f(length(f)) - f(1)


format long
Q = (wr / af)
wr

