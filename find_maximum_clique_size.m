function maxcl=find_maximum_clique_size(p, N, D)
    % p: [p1, p2]
    % N=p1^M1*p2^M2
    % Divisor set: D={p1^a1*p2^b1, p1^a2*p2^b2, .........., p1^al*p2^bl}
    % Obtaining a subset of D such that ai<M1 & bi<M2 for all i
    if N<1
        error('The GCD graph must have at least one node!');
        return
    end
    M=factorize_2primes(p, N);
    D=D(D(D<N)>0);  % Removing the extreme cases
    ab=[];
    for k=1:length(D)
        ab_temp=factorize_2primes(p, D(k));
        if ab_temp(2)~=-1
            ab=[ab; ab_temp];
        end
    end
    ab=unique(ab, 'rows'); %Concatenating columns a & b and removing the duplicates
    l=size(ab, 1);  %No. of elements in the divisor set
    if l==0
        maxcl=1;
        return
    end
    %if M(1)==0
    %    maxcl=max(2, p(2)^l);
    %elseif M(2)==0
    %    maxcl=max(2, p(1)^l);
    %end
    %Eliminating full or more exponents of p2 from D
    nbM2=0;
    k=1;
    while k<=l
        if ab(k, 2)==M(2)
            nbM2=nbM2+1;
            ab(k, :)=[];
            l=l-1;
        else
            k=k+1;
        end
    end
    maxcl=max(p(1)^nbM2, 2);    %Maximum clique size due to the elements of full exponents of p2
    if l==0
        return
    end
    %Eliminating full or more exponents of p1 from D
    naM1=0;
    while ab(l, 1)==M(1)
        ab(l, :)=[];
        l=l-1;
        naM1=naM1+1;
        if l==0
            break
        end
    end
    maxcl=max(maxcl, p(2)^naM1);    %Maximum clique size due to the elements of full exponents of p1 & p2
    if l==0
        return
    end
    a=ab(:, 1)';
    b=ab(:, 2)';
    if p(1)==p(2)
        error('The 2 primes cannot be the same!');
        return
    elseif p(1)>p(2)
        [a, b]=deal(b, a);  %Interchange a and b
    end
    
    [lndssb, lndssb_ind]=find_longest_nondecreasing_subsequences(b);
    %For equalities in a
    lndssb2=handle_a_reps(a,lndssb,lndssb_ind);
    
    l=length(lndssb2);
    for k=1:l
        reps=find_reps(lndssb2{k});
        maxcl=max(maxcl, p(1)^(length(lndssb2{k})-sum(reps))*prod(min(p(1).^reps, p(2))));
    end
end