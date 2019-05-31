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

