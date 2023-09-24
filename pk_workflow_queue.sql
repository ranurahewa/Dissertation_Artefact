-- Start of DDL Script for Package LASNIHEWA.PK_WORKFLOW_QUEUE

CREATE OR REPLACE 
PACKAGE pk_workflow_queue IS


  PROCEDURE PU_RECEIVE_APLICATION(WK_APP_NO  IN VARCHAR2,
                                  WK_PROCESS_TYPE IN VARCHAR2,
                                  WK_APP_TYPE IN VARCHAR2,
                                  WK_LANGUAGE IN VARCHAR2,
                                  WK_APP_DATE IN DATE,
                                  WK_HIGH_APPROVAL IN VARCHAR2,
                                  WK_STATUS OUT VARCHAR2) ;

  PROCEDURE PU_REQUEST_NEXT_APLICATION(WK_TASK IN VARCHAR2,
                                   WK_PROCESS_TYPE IN VARCHAR2,
                                   WK_LOCATION IN VARCHAR2,
                                   WK_USER   IN VARCHAR2,
                                   WK_APP_NO OUT VARCHAR2,
                                   WK_STATUS OUT VARCHAR2) ;


  PROCEDURE PU_TASK_COMPLETION    (WK_TASK IN VARCHAR2,
                                   WK_PROCESS_TYPE IN VARCHAR2,
                                   WK_LOCATION IN VARCHAR2,
                                   WK_APP_NO IN VARCHAR2,
                                   WK_USER   IN VARCHAR2,
                                   WK_TASK_STATUS  IN VARCHAR2,
                                   WK_STATUS OUT VARCHAR2) ;



  PROCEDURE PU_REQUEST_FORWARD_TASK  (WK_TASK IN VARCHAR2,
                                      WK_FORWARD_TASK IN VARCHAR2,
                                      WK_PROCESS_TYPE IN VARCHAR2,
                                      WK_LOCATION IN VARCHAR2,
                                      WK_APP_NO IN VARCHAR2,
                                      WK_USER   IN VARCHAR2,
                                      WK_STATUS OUT VARCHAR2) ;



  PROCEDURE PU_ACTION_TASK_COMPLETION(WK_TASK IN VARCHAR2,
                                      WK_PROCESS_TYPE IN VARCHAR2,
                                      WK_LOCATION IN VARCHAR2,
                                      WK_APP_NO IN VARCHAR2,
                                      WK_USER   IN VARCHAR2,
                                      WK_STATUS OUT VARCHAR2) ;


  PROCEDURE PU_INSERT_WF_QUEUE(WK_WF_CODE  VARCHAR2,
                                          WK_APP_NO   VARCHAR2,
                                          WK_TASK_CODE  VARCHAR2,
                                          WK_TASK_STATUS  VARCHAR2,
                                          WK_COMPLETED_DATE DATE,
                                          WK_APPLICAITON_STATUS VARCHAR2,
                                          WK_COMPLETED_BY VARCHAR2,
                                          WK_FWD_USER VARCHAR2,
                                          WK_FWD_DATE DATE,
                                          WK_WAIT_USER VARCHAR2,
                                          WK_WAIT_DATE DATE,
                                          WK_TASK_LOC VARCHAR2,
                                          WK_FWD_TSK_CODE VARCHAR2,
                                          WK_FWD_TSK_FROM VARCHAR2,
                                          WK_PROCESS_TYPE VARCHAR2) ;

  PROCEDURE PU_INSERT_APPLICATIONS (WK_APP_NO  IN VARCHAR2,
                                       WK_APP_TYPE IN VARCHAR2,
                                       WK_PROCESS_TYPE IN VARCHAR2,
                                       WK_LANGUAGE IN VARCHAR2,
                                       WK_APP_DATE IN VARCHAR2,
                                       WK_HIGH_APPROVAL IN VARCHAR2,
                                       WK_STATUS  IN VARCHAR2)  ;

  PROCEDURE PU_GET_TASK_LOCATION (WK_PROCESS_TYPE IN VARCHAR2,
                                  WK_TASK_CODE IN VARCHAR2,
                                  WK_LAST_LOCATION IN VARCHAR2,
                                  WK_APP_TYPE IN VARCHAR2,
                                  WK_LANGUAGE IN VARCHAR2,
                                  WK_HIGH_APPROVAL IN VARCHAR2,
                                  WK_LOCATION OUT VARCHAR2,
                                  WK_STATUS OUT VARCHAR2);

  PROCEDURE PU_GEN_NEXT_TASK     (
                                  WK_APP_NO  IN VARCHAR2,
                                  WK_PROCESS_TYPE IN VARCHAR2,
                                  WK_LAST_TASK IN VARCHAR2,
                                  WK_LOCATION IN VARCHAR2,
                                  WK_USER   IN VARCHAR2,
                                  WK_STATUS OUT VARCHAR2) ;



  PROCEDURE PU_PROGRESS_STATUS    (WK_APP_NO  IN  VARCHAR2,
                                   WK_STATUS  OUT VARCHAR2,
                                   WK_REMARKS OUT VARCHAR2)  ;

  PROCEDURE PU_ADD_NEW_TASK   (WK_WF_CODE  IN VARCHAR2,
                               WK_TASK_CODE  IN VARCHAR2,
                               WK_PREVIOUS_TASK IN VARCHAR2,
                               WK_NEXT_TASK IN VARCHAR2);

  PROCEDURE PU_REMOVE_TASK    (WK_WF_CODE  IN VARCHAR2,
                               WK_TASK_CODE  IN VARCHAR2,
                               WK_IMPACT IN VARCHAR2);

END pk_workflow_queue;
/


CREATE OR REPLACE 
PACKAGE BODY pk_workflow_queue
IS


---------API 1-----RECEIVE APPLICATION ONLINE-----------------------------------

PROCEDURE PU_RECEIVE_APLICATION(WK_APP_NO  IN VARCHAR2,
                                WK_PROCESS_TYPE IN VARCHAR2,
                                WK_APP_TYPE IN VARCHAR2,
                                WK_LANGUAGE IN VARCHAR2,
                                WK_APP_DATE IN DATE,
                                WK_HIGH_APPROVAL IN VARCHAR2,
                                WK_STATUS OUT VARCHAR2) IS

WK_INIT_TASK  VARCHAR2(20);
WK_WF_CODE    VARCHAR2(20);

BEGIN

WK_INIT_TASK := 'M100'; -- RECEIVE APPLICATION TO DRP
WK_WF_CODE := 'PR_NM_APP';


        PU_INSERT_APPLICATIONS      (WK_APP_NO,
                                     WK_APP_TYPE,
                                     WK_PROCESS_TYPE,
                                     WK_LANGUAGE,
                                     WK_APP_DATE,
                                     WK_HIGH_APPROVAL,
                                     'P') ;

               PU_INSERT_WF_QUEUE(WK_WF_CODE,
                                  WK_APP_NO,
                                  WK_INIT_TASK,
                                  'C',
                                  SYSDATE,
                                  'P',
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  WK_PROCESS_TYPE);
PK_WORKFLOW_QUEUE.PU_GEN_NEXT_TASK     (
                                WK_APP_NO,
                                WK_PROCESS_TYPE,
                                WK_INIT_TASK,
                                NULL,
                                NULL,
                                WK_STATUS);


  COMMIT;

WK_STATUS := 0;

EXCEPTION WHEN OTHERS THEN

WK_STATUS := 1;

END;



-------------API 2----REQUEST NEXT APPLICATION API------------------------------

PROCEDURE PU_REQUEST_NEXT_APLICATION(WK_TASK IN VARCHAR2,
                                 WK_PROCESS_TYPE IN VARCHAR2,
                                 WK_LOCATION IN VARCHAR2,
                                 WK_USER   IN VARCHAR2,
                                 WK_APP_NO OUT VARCHAR2,
                                 WK_STATUS OUT VARCHAR2) IS

CURSOR CUR_GET_NEXT_APP IS
SELECT WFQ_APPLICATION_NO
FROM WF_QUEUE
WHERE WFQ_TASK_LOC = WK_LOCATION
AND WFQ_PROCESS_TYPE = WK_PROCESS_TYPE
AND WFQ_TASK_CODE = WK_TASK
AND WFQ_TASK_STAUS = 'W';


BEGIN

OPEN CUR_GET_NEXT_APP;
FETCH CUR_GET_NEXT_APP INTO WK_APP_NO;
CLOSE CUR_GET_NEXT_APP;

UPDATE WF_QUEUE
SET WFQ_TASK_STAUS = 'P',
WFQ_TASK_COMPLETED_BY = WK_USER
WHERE WFQ_TASK_LOC = WK_LOCATION
AND WFQ_PROCESS_TYPE = WK_PROCESS_TYPE
AND WFQ_TASK_CODE = WK_TASK
AND WFQ_APPLICATION_NO = WK_APP_NO
AND WFQ_TASK_STAUS = 'W';

COMMIT;

IF WK_APP_NO IS NOT NULL THEN
  WK_STATUS  := 0;
ELSE
  WK_STATUS  := 1;
END IF;



END;

--------------API3---TASK COMPLETION------------------------------------------------

PROCEDURE PU_TASK_COMPLETION    (WK_TASK IN VARCHAR2,
                                 WK_PROCESS_TYPE IN VARCHAR2,
                                 WK_LOCATION IN VARCHAR2,
                                 WK_APP_NO IN VARCHAR2,
                                 WK_USER   IN VARCHAR2,
                                 WK_TASK_STATUS  IN VARCHAR2,
                                 WK_STATUS OUT VARCHAR2) IS

BEGIN

IF WK_TASK_STATUS = 'C' THEN

      UPDATE WF_QUEUE
      SET WFQ_TASK_STAUS = 'C',
      WFQ_TASK_COMPLETED_BY = WK_USER,
      WFQ_TASK_COMPLETED_DATE = SYSDATE
      WHERE WFQ_APPLICATION_NO = WK_APP_NO
      AND WFQ_TASK_CODE = WK_TASK
      AND WFQ_TASK_STAUS = 'P';


      IF WK_TASK LIKE 'F%' THEN

            UPDATE WF_QUEUE
            SET WFQ_TASK_STAUS = 'W'
            WHERE WFQ_APPLICATION_NO = WK_APP_NO
            AND WFQ_TASK_STAUS = 'H';

      ELSE

            IF WK_TASK = 'M200' THEN

                UPDATE APPLICATIONS
                SET APP_STATUS = 'A'
                WHERE APP_APP_NO = WK_APP_NO;

            ELSE

               PK_WORKFLOW_QUEUE.PU_GEN_NEXT_TASK (
                                            WK_APP_NO,
                                            WK_PROCESS_TYPE,
                                            WK_TASK,
                                            WK_LOCATION,
                                            WK_USER,
                                            WK_STATUS);
            END IF;

     END IF;

ELSIF WK_TASK_STATUS = 'R' THEN

      UPDATE WF_QUEUE
      SET WFQ_TASK_STAUS = 'W'
      WHERE WFQ_APPLICATION_NO = WK_APP_NO
      AND WFQ_TASK_CODE = WK_TASK
      AND WFQ_TASK_STAUS = 'P';

END IF;

COMMIT;

WK_STATUS := 0;

EXCEPTION WHEN OTHERS THEN

WK_STATUS := 1;



END;

---------------API 4--REQUEST FORWARD TASK--------------------------------------

PROCEDURE PU_REQUEST_FORWARD_TASK  (WK_TASK IN VARCHAR2,
                                    WK_FORWARD_TASK IN VARCHAR2,
                                    WK_PROCESS_TYPE IN VARCHAR2,
                                    WK_LOCATION IN VARCHAR2,
                                    WK_APP_NO IN VARCHAR2,
                                    WK_USER   IN VARCHAR2,
                                    WK_STATUS OUT VARCHAR2) IS

WK_WF_CODE VARCHAR2(10);

BEGIN

WK_WF_CODE := 'PR_NM_APP';

      UPDATE WF_QUEUE
      SET WFQ_TASK_STAUS = 'H',
      WFQ_TASK_COMPLETED_DATE = SYSDATE,
      WFQ_TASK_COMPLETED_BY = WK_USER
      WHERE WFQ_APPLICATION_NO = WK_APP_NO
      AND WFQ_TASK_CODE = WK_TASK
      AND WFQ_TASK_STAUS = 'P';


               PU_INSERT_WF_QUEUE(WK_WF_CODE,
                                  WK_APP_NO,
                                  WK_FORWARD_TASK,
                                  'P',
                                  SYSDATE,
                                  'P',
                                  WK_USER,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  WK_LOCATION,
                                  NULL,
                                  NULL,
                                  WK_PROCESS_TYPE);


      COMMIT;


END;


---------------API 5--REQUEST ACTION TASK-------------------------------------------

PROCEDURE PU_ACTION_TASK_COMPLETION(WK_TASK IN VARCHAR2,
                                    WK_PROCESS_TYPE IN VARCHAR2,
                                    WK_LOCATION IN VARCHAR2,
                                    WK_APP_NO IN VARCHAR2,
                                    WK_USER   IN VARCHAR2,
                                    WK_STATUS OUT VARCHAR2) IS

WK_WF_CODE VARCHAR2(10);

BEGIN

WK_WF_CODE := 'PR_NM_APP';


               PU_INSERT_WF_QUEUE(WK_WF_CODE,
                                  WK_APP_NO,
                                  WK_TASK,
                                  'C',
                                  SYSDATE,
                                  'P',
                                  WK_USER,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  WK_LOCATION,
                                  NULL,
                                  NULL,
                                  WK_PROCESS_TYPE);


      COMMIT;


END;


--------------------------------------------------------------------------------

PROCEDURE PU_GET_TASK_LOCATION (WK_PROCESS_TYPE IN VARCHAR2,
                                WK_TASK_CODE IN VARCHAR2,
                                WK_LAST_LOCATION IN VARCHAR2,
                                WK_APP_TYPE IN VARCHAR2,
                                WK_LANGUAGE IN VARCHAR2,
                                WK_HIGH_APPROVAL IN VARCHAR2,
                                WK_LOCATION OUT VARCHAR2,
                                WK_STATUS OUT VARCHAR2)IS

WK_LOC  VARCHAR2(20);
WK_LOC1 VARCHAR2(20);
WK_LOC2 VARCHAR2(20);
WK_LOC3 VARCHAR2(20);
WK_LOC4 VARCHAR2(20);
WK_LOC5 VARCHAR2(20);

WK_CMB NUMBER(2);
WK_KND NUMBER(2);
WK_JAF NUMBER(2);

WK_HIGH_APP_LOC VARCHAR2(20);
WK_TAMIL_LOC  VARCHAR2(20);
WK_L_C_LOC1   VARCHAR2(20);
WK_L_C_LOC2   VARCHAR2(20);
WK_AUTH_TASK  VARCHAR2(5);
WK_LOC_STATUS VARCHAR2(1);
WK_OPT_LOCATION VARCHAR2(20);

WK_QTY_STAGE1   NUMBER(5);
WK_QTY_STAGE2   NUMBER(5);
WK_QTY_STAGE3   NUMBER(5);



CURSOR CHECK_LOC_AVAILABILITY(WK_LOC VARCHAR2, WK_TASK VARCHAR2) IS
SELECT TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK
 AND TASK_LOCATION = WK_LOC
 AND (TASK_APP_QTY - TASK_ALLOCATED_QTY) > 0 ;

CURSOR CURSOR_CUR1 IS
SELECT A.TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK_CODE
 AND NVL(TASK_ALLOCATED_QTY,0) = 0;

CURSOR CURSOR_CUR2 IS
SELECT A.TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK_CODE
 AND NVL(TASK_APP_QTY,0) - NVL(TASK_ALLOCATED_QTY,0) > 0
 AND NVL(TASK_ALLOCATED_QTY,0) >= WK_QTY_STAGE1;

CURSOR CURSOR_CUR3 IS
SELECT A.TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK_CODE
 AND NVL(TASK_APP_QTY,0) - NVL(TASK_ALLOCATED_QTY,0) > 0
 AND NVL(TASK_ALLOCATED_QTY,0) >= WK_QTY_STAGE2;

CURSOR CURSOR_CUR4 IS
SELECT A.TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK_CODE
 AND NVL(TASK_APP_QTY,0) - NVL(TASK_ALLOCATED_QTY,0) > 0
 AND NVL(TASK_ALLOCATED_QTY,0) >= WK_QTY_STAGE2;

 CURSOR CURSOR_CUR5 IS
SELECT A.TASK_LOCATION
  FROM LOCATION_TASK_QTY A
 WHERE TASK_CODE = WK_TASK_CODE
 AND NVL(TASK_APP_QTY,0) - NVL(TASK_ALLOCATED_QTY,0) > 0
 AND NVL(TASK_ALLOCATED_QTY,0) >= WK_QTY_STAGE3;


BEGIN

    WK_CMB := 0;
    WK_KND := 0;
    WK_JAF := 0;

    WK_AUTH_TASK := 'M110';
    WK_LOC_STATUS := 0;

    WK_QTY_STAGE1 := 20;
    WK_QTY_STAGE2 := 50;
    WK_QTY_STAGE3 := 100;

IF WK_TASK_CODE = WK_AUTH_TASK THEN

    IF WK_HIGH_APPROVAL = 'Y' THEN
      WK_CMB := 1;
    END IF;

    IF WK_APP_TYPE IN ('C','L') THEN
       WK_CMB := WK_CMB + 1;
       WK_KND := 1;
    END IF;

    IF WK_LANGUAGE = 'TML' THEN
      WK_JAF := 1;
    END IF;


   IF WK_JAF > 0 THEN
        OPEN CHECK_LOC_AVAILABILITY('JAF',WK_TASK_CODE);
        FETCH CHECK_LOC_AVAILABILITY INTO WK_OPT_LOCATION;
        CLOSE CHECK_LOC_AVAILABILITY;

        IF WK_OPT_LOCATION  IS NOT NULL THEN
          WK_LOCATION := WK_OPT_LOCATION;
          WK_LOC_STATUS := 1;
        END IF;
   END IF;


   IF WK_LOC_STATUS = 0 THEN
      IF WK_CMB > 0 THEN

        OPEN CHECK_LOC_AVAILABILITY('CMB',WK_TASK_CODE);
        FETCH CHECK_LOC_AVAILABILITY INTO WK_OPT_LOCATION;
        CLOSE CHECK_LOC_AVAILABILITY;

        IF WK_OPT_LOCATION  IS NOT NULL THEN
          WK_LOCATION := WK_OPT_LOCATION;
          WK_LOC_STATUS := 1;
        END IF;

      END IF;
   END IF;


   IF WK_LOC_STATUS = 0 THEN
      IF WK_KND > 0 THEN
        OPEN CHECK_LOC_AVAILABILITY('KND',WK_TASK_CODE);
        FETCH CHECK_LOC_AVAILABILITY INTO WK_OPT_LOCATION;
        CLOSE CHECK_LOC_AVAILABILITY;

        IF WK_OPT_LOCATION  IS NOT NULL THEN
          WK_LOCATION := WK_OPT_LOCATION;
          WK_LOC_STATUS := 1;
        END IF;

      END IF;
   END IF;


END IF;



IF WK_LOC_STATUS = 0 THEN

        OPEN CURSOR_CUR1;
        FETCH CURSOR_CUR1 INTO WK_LOC1;
        CLOSE CURSOR_CUR1;


        IF WK_LOC1 IS NOT NULL THEN
            WK_LOCATION := WK_LOC1;
        ELSE
            OPEN CURSOR_CUR2;
            FETCH CURSOR_CUR2 INTO WK_LOC2;
            CLOSE CURSOR_CUR2;

            IF WK_LOC2 IS NOT NULL THEN
                WK_LOCATION := WK_LOC2;
            ELSE
                OPEN CURSOR_CUR3;
                FETCH CURSOR_CUR3 INTO WK_LOC3;
                CLOSE CURSOR_CUR3;

                    IF WK_LOC3 IS NOT NULL THEN
                        WK_LOCATION := WK_LOC3;
                    ELSE
                        OPEN CURSOR_CUR4;
                        FETCH CURSOR_CUR4 INTO WK_LOC4;
                        CLOSE CURSOR_CUR4;

                            IF WK_LOC4 IS NOT NULL THEN
                                WK_LOCATION := WK_LOC4;
                            ELSE
                                OPEN CURSOR_CUR5;
                                FETCH CURSOR_CUR5 INTO WK_LOC5;
                                CLOSE CURSOR_CUR5;

                                        IF WK_LOC5 IS NOT NULL THEN
                                            WK_LOCATION := WK_LOC5;
                                        END IF;
                            END IF;
                    END IF;
            END IF;
        END IF;
END IF;

    IF WK_LOCATION IS NOT NULL THEN

       UPDATE LOCATION_TASK_QTY
       SET TASK_ALLOCATED_QTY = NVL(TASK_ALLOCATED_QTY,0) + 1
       WHERE TASK_CODE = WK_TASK_CODE
       AND TASK_LOCATION = WK_LOCATION;


      WK_STATUS := 0;

    ELSE

      WK_STATUS := 1;

    END IF ;



END;

--------------------------------------------------------------------------------
PROCEDURE PU_GEN_NEXT_TASK     (
                                WK_APP_NO  IN VARCHAR2,
                                WK_PROCESS_TYPE IN VARCHAR2,
                                WK_LAST_TASK IN VARCHAR2,
                                WK_LOCATION IN VARCHAR2,
                                WK_USER   IN VARCHAR2,
                                WK_STATUS OUT VARCHAR2) IS


WK_WF_CODE    VARCHAR2(20);
WK_NEXT_TASK VARCHAR2(20);
WK_NEW_LOCATION   VARCHAR2(20);

WK_APP_TYPE  VARCHAR2(1);
WK_LANGUAGE  VARCHAR2(3);
WK_HIGH_APPROVAL  VARCHAR2(1);

CURSOR CUR_GET_APP_DATA IS
SELECT A.APP_APP_TYPE,A.APP_LANGUAGE,A.APP_HIGH_APPROVAL
  FROM APPLICATIONS A
  WHERE A.APP_APP_NO = WK_APP_NO;


CURSOR CUR_GET_NEXT_TASK IS
  SELECT WCH_TASK_CODE
  FROM CONFIG_DETAILS A
  WHERE WCH_ORDER = (
  SELECT MIN(WCH_ORDER)
  FROM CONFIG_DETAILS
  WHERE WCH_ORDER >
  (SELECT B.WCH_ORDER
  FROM CONFIG_DETAILS B
  WHERE B.WCH_WORKF_CODE = WK_WF_CODE
  AND B.WCH_TASK_CODE = WK_LAST_TASK));


BEGIN


WK_WF_CODE := 'PR_NM_APP';

OPEN CUR_GET_NEXT_TASK;
FETCH CUR_GET_NEXT_TASK INTO WK_NEXT_TASK;
CLOSE CUR_GET_NEXT_TASK;

OPEN CUR_GET_APP_DATA;
FETCH CUR_GET_APP_DATA INTO WK_APP_TYPE, WK_LANGUAGE, WK_HIGH_APPROVAL;
CLOSE CUR_GET_APP_DATA;

PK_WORKFLOW_QUEUE.PU_GET_TASK_LOCATION (WK_PROCESS_TYPE,
                                        WK_NEXT_TASK,
                                        WK_LOCATION,
                                        WK_APP_TYPE,
                                        WK_LANGUAGE,
                                        WK_HIGH_APPROVAL,
                                        WK_NEW_LOCATION,
                                        WK_STATUS);
IF WK_STATUS = 0 THEN

               PU_INSERT_WF_QUEUE(WK_WF_CODE,
                                  WK_APP_NO,
                                  WK_NEXT_TASK,
                                  'W',
                                  SYSDATE,
                                  'P',
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  WK_NEW_LOCATION,
                                  NULL,
                                  NULL,
                                  WK_PROCESS_TYPE);



ELSE

WK_STATUS := 1;

END IF;

WK_STATUS := 0;

EXCEPTION WHEN OTHERS THEN

WK_STATUS := 1;

END;
--------------------------------------------------------------------------------
PROCEDURE PU_INSERT_WF_QUEUE(WK_WF_CODE  VARCHAR2,
                                        WK_APP_NO   VARCHAR2,
                                        WK_TASK_CODE  VARCHAR2,
                                        WK_TASK_STATUS  VARCHAR2,
                                        WK_COMPLETED_DATE DATE,
                                        WK_APPLICAITON_STATUS VARCHAR2,
                                        WK_COMPLETED_BY VARCHAR2,
                                        WK_FWD_USER VARCHAR2,
                                        WK_FWD_DATE DATE,
                                        WK_WAIT_USER VARCHAR2,
                                        WK_WAIT_DATE DATE,
                                        WK_TASK_LOC VARCHAR2,
                                        WK_FWD_TSK_CODE VARCHAR2,
                                        WK_FWD_TSK_FROM VARCHAR2,
                                        WK_PROCESS_TYPE VARCHAR2) IS

BEGIN

INSERT INTO WF_QUEUE
      ( WFQ_WORKFLOW_CDE, WFQ_APPLICATION_NO, WFQ_TASK_CODE,
       WFQ_TASK_STAUS, WFQ_INITIATED_TIME,
       WFQ_TASK_COMPLETED_DATE, WFQ_APPLICAITON_STATUS,
       WFQ_QUEUE_SEQ, WFQ_TASK_COMPLETED_BY, WFQ_FWD_USER,
       WFQ_FWD_DATE, WFQ_WAIT_USER, WFQ_WAIT_DATE, WFQ_TASK_LOC,
       WFQ_FWD_TSK_CODE, WFQ_FWD_TSK_FROM,WFQ_PROCESS_TYPE)

    VALUES(WK_WF_CODE,LTRIM(RTRIM(WK_APP_NO)),WK_TASK_CODE,
    WK_TASK_STATUS,SYSDATE,WK_COMPLETED_DATE,WK_APPLICAITON_STATUS,SEQ_WORKFLOW_QUEUE.NEXTVAL,
    WK_COMPLETED_BY,WK_FWD_USER,WK_FWD_DATE,WK_WAIT_USER,WK_WAIT_DATE,
    WK_TASK_LOC,WK_FWD_TSK_CODE,WK_FWD_TSK_FROM,WK_PROCESS_TYPE);




END;


--INSERT DATA TO WM_T_APPDETAILS
--------------------------------------------------------------------------------

PROCEDURE PU_INSERT_APPLICATIONS (WK_APP_NO  IN VARCHAR2,
                                     WK_APP_TYPE IN VARCHAR2,
                                     WK_PROCESS_TYPE IN VARCHAR2,
                                     WK_LANGUAGE IN VARCHAR2,
                                     WK_APP_DATE IN VARCHAR2,
                                     WK_HIGH_APPROVAL IN VARCHAR2,
                                     WK_STATUS  IN VARCHAR2)  IS

BEGIN

     INSERT INTO APPLICATIONS
      ( APP_APP_NO, APP_APP_TYPE, APP_PROCESS_TYPE, APP_LANGUAGE,
       APP_APP_DATE, APP_HIGH_APPROVAL, APP_STATUS )

     VALUES(WK_APP_NO, WK_APP_TYPE, WK_PROCESS_TYPE, WK_LANGUAGE,
            WK_APP_DATE, WK_HIGH_APPROVAL, WK_STATUS);


END;

----------------------API 6--Progress Status--------------------------------


PROCEDURE PU_PROGRESS_STATUS    (WK_APP_NO  IN  VARCHAR2,
                                 WK_STATUS  OUT VARCHAR2,
                                 WK_REMARKS OUT VARCHAR2)  IS

WK_TASK_CODE varchar2(5);

CURSOR CUR_STATUS IS
SELECT wfq_task_code
FROM WF_QUEUE
WHERE wfq_queue_seq IN
(
SELECT MAX(wfq_queue_seq)
FROM WF_QUEUE
WHERE wfq_application_no = WK_APP_NO
AND wfq_task_staus = 'C'
AND wfq_task_code LIKE 'M%'
);



BEGIN

OPEN CUR_STATUS;
FETCH CUR_STATUS INTO WK_TASK_CODE;
CLOSE CUR_STATUS;

IF WK_TASK_CODE IS NOT NULL THEN
     IF WK_TASK_CODE IN ('M100') THEN
     wk_status := 'Waiting for process NIC';
  ELSIF  WK_TASK_CODE IN ('M110','M120','M130','M140')  THEN
     wk_status := 'Document Verification Process Completed';
  ELSIF  WK_TASK_CODE IN ('M150','M155','M160')  THEN
     wk_status := 'Registration Completed';
  ELSIF  WK_TASK_CODE IN ('M170','M180')  THEN
     wk_status := 'NIC Printing Completed';
  ELSIF  WK_TASK_CODE IN ('M190')  THEN
     wk_status := 'Ready to Dispatch';
  ELSIF  WK_TASK_CODE IN ('M200')  THEN
     wk_status := 'Dispatch Completed';
  END IF;
END IF;

END;


----------------API 7--ADD NEW TASK TO THE ONGOING WF------------------------

PROCEDURE PU_ADD_NEW_TASK   (WK_WF_CODE  IN VARCHAR2,
                             WK_TASK_CODE  IN VARCHAR2,
                             WK_PREVIOUS_TASK IN VARCHAR2,
                             WK_NEXT_TASK IN VARCHAR2)
                             IS

WK_PRE_ORDER NUMBER(4);
WK_ORDER NUMBER(4);

CURSOR CUR_ORDER is
SELECT A.wch_order
FROM config_details A
WHERE A.wch_task_code = WK_PREVIOUS_TASK;

BEGIN

OPEN CUR_ORDER;
FETCH CUR_ORDER INTO  WK_PRE_ORDER;
CLOSE CUR_ORDER;

WK_ORDER := WK_PRE_ORDER + 2;


insert into config_details
(wch_workf_code, wch_task_code, wch_mand_opt, wch_order)
VALUES
(WK_WF_CODE, WK_TASK_CODE, 'M', wk_order);


commit;

END;


----------------API 8--REMOVE TASK FROM THE ONGOING WF------------------------

PROCEDURE PU_REMOVE_TASK    (WK_WF_CODE  IN VARCHAR2,
                             WK_TASK_CODE  IN VARCHAR2,
                             WK_IMPACT IN VARCHAR2)
                             IS

WK_PRE_ORDER NUMBER(4);
WK_ORDER NUMBER(4);
WK_STATUS VARCHAR2(1);

WK_APP_NO VARCHAR2(20);
WK_PROCESS_TYPE VARCHAR2(1);

CURSOR CUR_GET_TASK_WAIT_APPS IS
SELECT a.wfq_application_no, a.wfq_process_type
  FROM wf_queue a
  WHERE  a.wfq_workflow_cde = WK_WF_CODE
  AND a.wfq_task_code = WK_TASK_CODE;


BEGIN


IF WK_IMPACT = 'Y' THEN

   OPEN CUR_GET_TASK_WAIT_APPS;
   LOOP
   FETCH CUR_GET_TASK_WAIT_APPS INTO WK_APP_NO,WK_PROCESS_TYPE;
   EXIT WHEN CUR_GET_TASK_WAIT_APPS%NOTFOUND;

              PK_WORKFLOW_QUEUE.PU_GEN_NEXT_TASK
                         (      WK_APP_NO,
                                WK_PROCESS_TYPE,
                                WK_TASK_CODE,
                                NULL,
                                USER,
                                WK_STATUS);

   END LOOP;
   CLOSE CUR_GET_TASK_WAIT_APPS;



    UPDATE wf_queue
    SET wfq_task_staus = 'R', --Remove,
      WFQ_TASK_COMPLETED_BY = USER,
      WFQ_TASK_COMPLETED_DATE = SYSDATE
    WHERE wfq_workflow_cde = WK_WF_CODE
    AND wfq_task_code = WK_TASK_CODE
    and wfq_task_staus = 'W';

END IF;

UPDATE config_details
SET WCH_ACTIVE_YN = 'N'
WHERE wch_workf_code = WK_WF_CODE
AND wch_task_code = WK_TASK_CODE;

commit;

END;





END;
/


-- End of DDL Script for Package LASNIHEWA.PK_WORKFLOW_QUEUE

