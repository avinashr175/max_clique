% The divisor set is of the form 
function updated_maximum_clique_size
    find_maximum_clique_size([3, 2], [2, 3], [0, 1, 2, 1], [0,0,0,1])
end

function maxcl=find_maximum_clique_size(M, p, a, b)
    % p: [p1, p2]
    % M: [M1, M2], N=p1^M1*p2^M2
    % a: Exponents of p1
    % b: Corresponding exponents of b
    % Divisor set: D={p1^a1*p2^b1, p1^a2*p2^b2, .........., p1^al*p2^bl}
    %1. Obtaining a subset of D such that ai<M1 & bi<M2 for all i
    ab=unique([a; b]', 'rows'); %Concatenating columns a & b and removing the duplicates
    l=size(ab, 1);  %No. of elements in the divisor set
    %Eliminating full or more exponents of p2 from D
    nbM2=0;
    k=1;
    while k<=l
        if ab(k, 2)>M(2)
            ab(k, :)=[];
            l=l-1;
        elseif ab(k, 2)==M(2)
            if ab(k, 1)<M(1)
                nbM2=nbM2+1;
            end
            ab(k, :)=[];
            l=l-1;
        else
            k=k+1;
        end
    end
    maxcl=p(1)^nbM2;    %Maximum clique size due to the elements of full exponents of p2
    %Eliminating full or more exponents of p1 from D
    naM1=0;
    k=l;
    while ab(k, 1)>M(1)
        ab(k, :)=[];
        k=k-1;
        if k==0
            break
        end
    end
    while ab(k, 1)==M(1)
        ab(k, :)=[];
        k=k-1;
        naM1=naM1+1;
        if k==0
            break
        end
    end
    maxcl=max(maxcl, p(2)^naM1);    %Maximum clique size due to the elements of full exponents of p1 & p2
    a=ab(1, :);
    b=ab(2, :);
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
        cl=p(1)^(length(lndssb2{k})-sum(reps))*prod(min(p(1).^reps, p(2)));
        if cl>maxcl
            maxcl=cl;
        end
    end
end

%To find all the non-decreasing sub-sequences of maximum length in a sequence
function [lndss, lndss_ind]=find_longest_nondecreasing_subsequences(x)
    N=length(x);
    s{1}=[x(1)];
    sl=ones(1, N);
    for k=2:N
        s{k, 1}=[];
        for p=1:k-1
            if x(k)>=x(p)
                if length(s{k})<length(s{p})  %A longer subsequence is found
                    for q=1:sl(p)
                        s{k, q}=s{p, q};  %Set of longest subsequences
                        sl(k)=sl(p);
                    end
                elseif length(s{k})==length(s{p}) %An equally long subsequence is found
                    for q=1:sl(p)
                        s{k, q+sl(k)}=s{p, q};  %Append to the existing set of longest subsequences
                    end
                    sl(k)=sl(k)+sl(p);
                end
            end
        end
        for q=1:sl(k)
            s{k, q}=[s{k, q}, x(k)];  %A new subsequence added to the list
        end
    end
    lndss_len=length(s{1});
    lndss_ind=1;
    %Capture the indices of the longest subsequences among the set of non-decreasing subsequences
    for k=2:N
        l=length(s{k});
        if l>lndss_len
            lndss_len=l;
            lndss_ind=k;
        elseif l==lndss_len
            lndss_ind=[lndss_ind, k];
        end
    end
    %The longest non-decreasing subsequences
    l=0;
    for k=lndss_ind
        for p=1:sl(k)
            l=l+1;
            lndss(l, :)=s{k, p};
        end
    end
    %lndssl: Length of the longest non-decreasing subsequence
    %lndssn: Number of longest non-decreasing subsequences
    [lndssn, lndssl]=size(lndss);
    %Indices of the elements in the longest non-decreasing subsequences
    lndss_ind=zeros(lndssn, lndssl);
    for k=1:lndssn
        q=1;
        for p=1:N
            if x(p)==lndss(k, q)
                lndss_ind(k, q)=p;
                q=q+1;
            end
            if q==lndssl+1
                break
            end
        end
    end    
end

%To find the number of element-wise repeated elements in a sorted list
function reps=find_reps(x)
    reps=[];
    k=1;
    m=1;
    while k<length(x)
        while x(k)==x(k+1)
            k=k+1;
            m=m+1;
            if k==length(x)
                break
            end
        end
        if m>1
            reps=[reps, m];
            m=1;
        end
        k=k+1;
    end
end

function lndssb2=handle_a_reps(a, lndssb, lndssb_ind)
    for k=1:size(lndssb,1)
        updated_ssb=[lndssb(1)];
        count=2;
        rep_count=0;
        for j=1:length(lndssb(k, :))-1
            if a(lndssb_ind(j))==a(lndssb_ind(j+1))
                rep_count=rep_count+1;
            else
                if rep_count>=1
                    equality_start_index=j-rep_count;
                    if equality_start_index>1
                        if lndssb(equality_start_index)==lndssb(equality_start_index-1)
                            updated_ssb(count-1)=lndssb(equality_start_index+1);
                        end
                    end
                end
                updated_ssb(count)=lndssb(j+1);
                count=count+1;
            end
        end
        lndssb2{k}=updated_ssb;
    end
end
