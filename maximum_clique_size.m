% The divisor set is of the form 
function maximum_clique_size
  %x=[0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15];
  %s=find_longest_nondecreasing_subsequence(x)
  %x=[0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
  %x=[3, 2, 7, 4, 5, 1];
  %x=[1, 3, 2, 4];
  %[lndss, lndss_ind]=find_longest_nondecreasing_subsequences(x)
  %reps=find_reps([1, 2, 2, 4, 4, 4])
  % Assuming N=72 and D=[2,3,6,12]
  find_maximum_clique_size([2, 3], [0 1 0 2 1 2], [0 0 1 0 1 1])
end

function maxcl=find_maximum_clique_size(p, a, b)
  % p: [p1, p2]
  % a: Exponents of p1
  % b: Corresponding exponents of b
  %1. Rearranging the b vector in accordance with sorted a
  ab=sortrows([a; b]')'
  a=ab(1, :);
  b=ab(2, :);
  [lndssb, lndssb_ind]=find_longest_nondecreasing_subsequences(b)
  %For equalities in a
  %To be filled by Avinash
  %for k=1:size(lndssb, 1)
  %  lndssb2{k}=lndssb(k, :);
  %end
  lndssb2=myfunc(a,lndssb,lndssb_ind)
  
  l=length(lndssb2);
  maxcl=1;
  for k=1:l
    reps=find_reps(lndssb2{k});
    cl=p(1)^(length(lndssb2{k})-sum(reps))*prod(min(p(1).^reps, p(2)));
    if cl>maxcl
      maxcl=cl;
    end
  end
end

