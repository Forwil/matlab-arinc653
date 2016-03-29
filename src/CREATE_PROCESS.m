function CREATE_PROCESS(PROCESS_ATTRIBUTE_TYPE)
         
         
%          global Process_NAME_Set;
         global Process_ID_Set;
         global Process_NAME_Set
         global RETURN_CODE_TYPE;
         global PROCESS_STATE_TYPE ;
%          global OPERATING_MODE_TYPE;
%          global CURRENT_PARTITION_STATUS;

                        
         x=INVALIDE_NAME(PROCESS_ATTRIBUTE_TYPE.NAME);
         
         if x == 1
             RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
             fprintf('invalid name!\n')
             return
         end
         
         if PROCESS_ATTRIBUTE_TYPE.STACK_SIZE<0 || PROCESS_ATTRIBUTE_TYPE.STACK_SIZE>255
             RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
             return
         end
         
         if PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY<0 || PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY>255
             RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
	         return
         end

         if PROCESS_ATTRIBUTE_TYPE.PERIOD<0 || PROCESS_ATTRIBUTE_TYPE.PERIOD>255
            RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
	        return
         end
		
         if PROCESS_ATTRIBUTE_TYPE.TIME_CAPACITY > PROCESS_ATTRIBUTE_TYPE.PERIOD
            RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM;
	        return
         end
    
%          if(Current_Partition_status.OPERATING_MODE == OPERATING_MODE_TYPE.NORMAL)
%             RETURN_CODE = RETURN_CODE_TYPE.INVALID_MODE;
%             return
%          end
		


		 if INVALIDE_NAME(PROCESS_ATTRIBUTE_TYPE.NAME)==1
		    
    		RETURN_CODE = RETURN_CODE_TYPE.NO_ACTION;
    		return;
         end
         
        id = length(Process_ID_Set) + 1;
        %id = 1;
        %round(rand(1,1)*255)
        DORMANT = PROCESS_STATE_TYPE.DORMANT;
        
      
        PRO = PROCESS_TYPE(id,PROCESS_ATTRIBUTE_TYPE.NAME,PROCESS_ATTRIBUTE_TYPE.PERIOD,PROCESS_ATTRIBUTE_TYPE.STACK_SIZE,1,DORMANT,PROCESS_ATTRIBUTE_TYPE.PERIOD,PROCESS_ATTRIBUTE_TYPE.TIME_CAPACITY, PROCESS_ATTRIBUTE_TYPE.ENTRY_POINT, PROCESS_ATTRIBUTE_TYPE.STACK_SIZE,  PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY,PROCESS_ATTRIBUTE_TYPE.DEADLINE)
        
        
        
        global ID
        ID = PRO.ID
         %fprintf('sad is %d\n',ID)
        
        
        if INVALIDE_ID(PRO.ID)==1
            fprintf('invalide id!\n')
            RETURN_CODE = RETURN_CODE_TYPE.INVALID_CONFIG;
	        return
        end
    

        
       
        %PROCESS_TYPE.NAME = PROCESS_ATTRIBUTE_TYPE.NAME;
        %PROCESS_TYPE.PERIOD = PROCESS_ATTRIBUTE_TYPE.PERIOD;
        %PROCESS_TYPE.TIME_CAPACITY = PROCESS_ATTRIBUTE_TYPE.TIME_CAPACITY ;
        %PROCESS_TYPE.ENTRY_POINT = PROCESS_ATTRIBUTE_TYPE.ENTRY_POINT;
        %PROCESS_TYPE.STACK_SIZE = PROCESS_ATTRIBUTE_TYPE.STACK_SIZE;
        %PROCESS_TYPE.BASE_PRIORITY = PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY;
        %PROCESS_TYPE.DEADLINE = PROCESS_ATTRIBUTE_TYPE.DEADLINE;
        %PROCESS_TYPE.PROCESS_STATE = PROCESS_ATTRIBUTE_TYPE.DORMANT;

        %Initialize_Process_Context(Pro->ID);
        %Initialize_Process_Stack(Pro->ID); 
		
        
        %PRO = PROCESS_TYPE(id)
         
        Process_ID_Set(id) = id;
       % fprintf('sdfsdf\n')
        Process_NAME_Set{1,id} = PROCESS_ATTRIBUTE_TYPE.NAME;
        %Dormant_Processes_set=Dormant_Processes_set \-/ {Pro->ID};
				
        PROCESS_ID = PRO.ID;
        RETURN_CODE = RETURN_CODE_TYPE.NO_ERROR;
        
end




        
 