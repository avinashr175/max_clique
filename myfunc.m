function lndssb2 = myfunc(a,lndssb,lndssb_ind)
    for k=1:size(lndssb,1)
        updated_ssb=[];
        updated_ssb(1)=lndssb(k,1);
        count=2;
        rep_count=0;
        for j=1:length(lndssb(k,:))-1
            if(a(lndssb_ind(k,j))==a(lndssb_ind(k,j+1)))
                rep_count=rep_count+1;
                continue
            else
                if(rep_count>=1)
                    equality_start_index=(j-rep_count);
                    if(equality_start_index>1)
                        if(lndssb(k,equality_start_index)==lndssb(k,equality_start_index-1))
                            updated_ssb(count-1)=lndssb(k,equality_start_index+1);
                        end
                    end
                end
                updated_ssb(count)=lndssb(k,j+1);
                count=count+1;
            end
        end
        lndssb2{k}=updated_ssb;
    end
end

