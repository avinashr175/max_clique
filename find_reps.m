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