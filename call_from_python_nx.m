function clique_number = call_from_python_nx(D,N)
    D_string=sprintf('%.0f,',D);
    D_string = D_string(1:end-1); % removing the last comma from the string
    N_string=num2str(N);
    res=python3('clique_size_networkx.py',D_string,N_string);
    clique_number=str2num(res);
end


