function flag = INVALIDE_ID(NUM)

global Process_ID_Set
flag=0;
for i=1:255
    if Process_ID_Set[i] == NUM;
        flag = 1;
        break;
    else
        flag = 0;
    end
end
%disp(flag);