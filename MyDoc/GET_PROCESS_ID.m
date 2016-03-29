function GET_PROCESS_ID (PROCESS_NAME)
        global ID;
        
        global RETURN_CODE_TYPE;
        
        x=INVALIDE_NAME(PROCESS_NAME);
        if x == 1
 			
		 	RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
			return;
        end
         
         x=INVALIDE_NAME(PROCESS_NAME);
		if x==1
			
			RETURN_CODE = RETURN_CODE_TYPE.INVALID_CONFIG;
			return;
        end
		

% 		Pro.<NAME:PROCESS_NAME> : Process_Set;
        fprintf('%d\n',ID)
 	    PROCESS_ID = ID;
%       PRO.disp()
		RETURN_CODE = RETURN_CODE_TYPE.NO_ERROR;
		return;
end