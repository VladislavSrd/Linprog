function x = lp121(f,a,b,lb)
x = linprog(f,a,b,[],[],lb);
disp(x);
end