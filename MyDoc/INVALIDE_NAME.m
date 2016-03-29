%STR='pkb';
%Ch = {'pkb','LKR'};
%Ch = cell(1,2);
%Ch{1,1}='pkb';
%Ch{1,2}='LKR';

function flag = INVALIDE_NAME(STR)
%PROCESS_ATTRIBUTE_TYPE.NAME='pkb';
global Process_NAME_Set
flag=0;
for i=1:255
    if strcmp(STR,Process_NAME_Set{1,i})==1
        flag = 1;
        break;
    else
        flag = 0;
    end
end
%disp(flag);