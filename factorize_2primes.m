function ab=factorize_2primes(p, x)
    % p: [p1, p2]
    a=0;
    b=0;
    while mod(x, p(1))==0
        a=a+1;  %Exponent of p1
        x=x/p(1);
    end
    f=1;
    while f<x
        f=f*p(2);
        b=b+1;  %Exponent of p2
    end
    if f~=x %Not completely divisible by primes p1 and p2 together
        a=-1;
        b=-1;
    end
    ab=[a, b];
end