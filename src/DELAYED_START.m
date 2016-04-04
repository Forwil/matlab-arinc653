

function [b] = IS_ID_EXIST(PROCESS_ID)
  global Process_ID_Set
  tmp = sum(ismember(Process_ID_Set, PROCESS_ID))
  if (tmp > 0)
      b = true
  else
      b = false
end

function [b] = IS_DELAY_TIME_IN_RANGE(DELAY_TIME)
  if (DELAY_TIME < 128 && DELAY_TIME >=0)
    b = true
  else
    b = false
end

function [RETURN_CODE] = DELAYED_START(PROCESS_ID, DELAY_TIME )
  global RETURN_CODE_TYPE
  
  if not IS_ID_EXIST(PROCESS_ID)
    RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM
  endif
  
  Pro = GET_PROCESS_CLASS(PROCESS_ID) %% not imp
  PROCESS_STATUS = Pro.PROCESS_STATE
  
  if not (PROCESS_STATUS == PROCESS_STATE_TYPE.DORMANT)
    RETURN_CODE = RETURN_CODE_TYPE.NO_ACTION
  endif
  
  if not IS_DELAY_TIME_IN_RANGE(DELAY_TIME)
    RETURN_CODE = RETURN_CODE_TYPE.INVALID_PARAM
  endif
  
  if DELAY_IME >= Pro.PERIOD
    RETURN_CODE = RETURN_CODE_TYPE.INVALID_CONFIG
  endif
  
  if IS_APERIODIC_PROCESS(Pro) %% not imp
    Pro.PRIORITY = PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY
    RESET_CONTEXT(Pro)  %% not imp
    RESET_STACK(Pro)    %% not imp
    if OPERATING_MODE_TYPE.NORMAL %% not imp
      if ( DELAY_TIME == 0 )
        Pro.PROCESS_STATE = PROCESS_STATE_TYPE.READY 
        Pro.DEADLINE_TIME = GET_NOW_TIME() + Pro.TIME_CAPACITY %% not imp
      else
        Pro.PROCESS_STATE = PROCESS_STATE_TYPE.WAITING
        Pro.DEADLINE_TIME = GET_NOW_TIME() + DELAY_TIME
        SET_TIMER(DELAY_TIME) %% not sense
      endif
      if (ENABLE_PREEMPTION()) % not imp
        PROCESS_SCHEDULING() % not imp
      endif
    else
      Pro.PROCESS_STATE = PROCESS_STATE_TYPE.WAITING
    endif
    RETURN_CODE = RETURN_CODE_TYPE.NO_ERROR;
  else
    Pro.PRIORITY = PROCESS_ATTRIBUTE_TYPE.BASE_PRIORITY
    RESET_CONTEXT(Pro)  %% not imp
    RESET_STACK(Pro)    %% not imp
    if OPERATING_MODE_TYPE.NORMAL %% not imp
      Pro.PROCESS_STATE = PROCESS_STATE_TYPE.WAITING
      
      Pro.FIRST_RELEASE_POINT = DELAY_TIME
      %% set the first release point (see Section 2.3.1) of the specified 
      %% process including the delay time; 
      Pro.DEADLINE_TIME = Pro.GET_FIRST_RELEASE_POINT() + Pro.TIME_CAPACITY
    else 
      Pro.PROCESS_STATE = PROCESS_STATE_TYPE.WAITING
    endif
    RETURN_CODE = RETURN_CODE_TYPE.NO_ERROR;
  end