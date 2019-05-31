 function maximum_clique_size_gcd
    p=[2, 3]; %  p1=2,p2=3
    for k=0:6
        for m=0:3
            N=p(1)^k*p(2)^m;
            if N<=72
                D_temp=p(1).^(0:k-1);
                D=[];
                for n=0:m-1
                    D=[D, D_temp*p(2).^n];
                end
                rand_indices=randi(2,1,numel(D))-1;
                D=D(find(rand_indices==1));
                if(numel(D)==0) % ignoring empty Divisor sets
                    continue;
                end
		
                if(find_maximum_clique_size(p, N, D)~=call_from_python_nx(D,N))
                    N
                    D
                    disp([find_maximum_clique_size(p, N, D),call_from_python_nx(D,N)])
                end
            end
        end
    end
end
