-- Start of DDL Script for Table LASNIHEWA.APPLICATIONS

CREATE TABLE applications
    (app_app_no                     VARCHAR2(20 BYTE) NOT NULL,
    app_app_type                   VARCHAR2(5 BYTE),
    app_process_type               VARCHAR2(5 BYTE) NOT NULL,
    app_language                   VARCHAR2(5 BYTE),
    app_app_date                   DATE NOT NULL,
    app_high_approval              VARCHAR2(1 BYTE),
    app_status                     VARCHAR2(1 BYTE))
 

-- Constraints for APPLICATIONS

ALTER TABLE applications
ADD CONSTRAINT pk_wm_t_appdetails PRIMARY KEY (app_app_no)

/


-- End of DDL Script for Table LASNIHEWA.APPLICATIONS

-- Start of DDL Script for Table LASNIHEWA.CONFIG_DETAILS

CREATE TABLE config_details
    (wch_workf_code                 VARCHAR2(10 BYTE) NOT NULL,
    wch_task_code                  VARCHAR2(10 BYTE) ,
    wch_mand_opt                   VARCHAR2(1 BYTE),
    wch_order                      NUMBER(4,0),
    wch_active_yn                  VARCHAR2(1 BYTE) DEFAULT 'Y')

/



-- Indexes for CONFIG_DETAILS

CREATE INDEX idx_wch_workf_code ON config_details
  (
    wch_workf_code                  ASC
  )
 
/


-- Constraints for CONFIG_DETAILS

ALTER TABLE config_details
ADD CONSTRAINT pk_wm_t_config_details PRIMARY KEY (wch_workf_code, wch_task_code)

/

ALTER TABLE config_details
ADD CHECK ("WCH_MAND_OPT" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE config_details
ADD CHECK ("WCH_TASK_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE config_details
ADD CHECK ("WCH_WORKF_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/


-- End of DDL Script for Table LASNIHEWA.CONFIG_DETAILS

-- Start of DDL Script for Table LASNIHEWA.CONFIG_HEADER


CREATE TABLE config_header
    (wch_workflow_code              VARCHAR2(10 BYTE) NOT NULL,
    wch_description                VARCHAR2(150 BYTE))
/





-- Indexes for CONFIG_HEADER

CREATE INDEX idx_fk_wch_workflow_code ON config_header
  (
    wch_workflow_code               ASC
  )

/



-- Constraints for CONFIG_HEADER

ALTER TABLE config_header
ADD CONSTRAINT pk_wm_t_config_header PRIMARY KEY (wch_workflow_code)
/

ALTER TABLE config_header
ADD CHECK ("WCH_WORKFLOW_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/


-- End of DDL Script for Table LASNIHEWA.CONFIG_HEADER

-- Start of DDL Script for Table LASNIHEWA.LOCATION


CREATE TABLE location
    (location_code                  VARCHAR2(5 BYTE) NOT NULL,
    location_name                  VARCHAR2(150 BYTE) NOT NULL)
 
/


-- Constraints for LOCATION

ALTER TABLE location
ADD CONSTRAINT pk_wm_r_location PRIMARY KEY (location_code)

/


-- End of DDL Script for Table LASNIHEWA.LOCATION

-- Start of DDL Script for Table LASNIHEWA.LOCATION_TASK_QTY


CREATE TABLE location_task_qty
    (task_location                  VARCHAR2(20 BYTE) ,
    task_code                      VARCHAR2(20 BYTE) ,
    task_app_qty                   NUMBER(10,0),
    task_allocated_qty             NUMBER(10,0),
    task_org_loc                   VARCHAR2(1 BYTE))
/



-- Constraints for LOCATION_TASK_QTY



ALTER TABLE location_task_qty
ADD CONSTRAINT pk_wm_t_location_task_qty PRIMARY KEY (task_location, task_code)
/


-- End of DDL Script for Table LASNIHEWA.LOCATION_TASK_QTY

-- Start of DDL Script for Table LASNIHEWA.TASKS


CREATE TABLE tasks
    (wrt_task_code                  VARCHAR2(10 BYTE) ,
    wrt_task_desc                  VARCHAR2(100 BYTE),
    wrt_task_type                  VARCHAR2(1 BYTE))

/


-- Indexes for TASKS

CREATE INDEX idx_wrt_task_type ON tasks
  (
    wrt_task_type                   ASC
  )

/


-- Constraints for TASKS

ALTER TABLE tasks
ADD CONSTRAINT pk_wm_r_tasks PRIMARY KEY (wrt_task_code)

/


-- Comments for TASKS

COMMENT ON COLUMN tasks.wrt_task_type IS 'Task Type (M - Main, F - Forward, B - Other, A - Action)'
/

-- End of DDL Script for Table LASNIHEWA.TASKS

-- Start of DDL Script for Table LASNIHEWA.USERS

CREATE TABLE users
    (user_id                        VARCHAR2(20 BYTE) NOT NULL,
    user_password                  VARCHAR2(20 BYTE),
    user_emp_no                    VARCHAR2(20 BYTE),
    user_full_name                 VARCHAR2(150 BYTE))

/


-- Constraints for USERS

ALTER TABLE users
ADD CONSTRAINT pk_wm_r_users PRIMARY KEY (user_id)

/


-- End of DDL Script for Table LASNIHEWA.USERS

-- Start of DDL Script for Table LASNIHEWA.WF_QUEUE


CREATE TABLE wf_queue
    (wfq_workflow_cde               VARCHAR2(10 BYTE) NOT NULL,
    wfq_application_no             VARCHAR2(20 BYTE) NOT NULL,
    wfq_task_code                  VARCHAR2(10 BYTE) NOT NULL,
    wfq_task_staus                 VARCHAR2(2 BYTE),
    wfq_initiated_time             DATE,
    wfq_task_completed_date        DATE,
    wfq_applicaiton_status         VARCHAR2(1 BYTE),
    wfq_queue_seq                  NUMBER(*,0) ,
    wfq_task_completed_by          VARCHAR2(10 BYTE),
    wfq_fwd_user                   VARCHAR2(20 BYTE),
    wfq_fwd_date                   DATE,
    wfq_wait_user                  VARCHAR2(20 BYTE),
    wfq_wait_date                  DATE,
    wfq_task_loc                   VARCHAR2(5 BYTE),
    wfq_fwd_tsk_code               VARCHAR2(10 BYTE),
    wfq_fwd_tsk_from               VARCHAR2(10 BYTE),
    wfq_process_type               VARCHAR2(1 BYTE))
/



-- Indexes for WF_QUEUE

CREATE INDEX idx_wm_t_workflow_queue_7 ON wf_queue
  (
    wfq_task_completed_date         ASC
  )

/

CREATE INDEX idx_wait_dt ON wf_queue
  (
    TO_CHAR("WFQ_WAIT_DATE",'YYYY/MM/DD') ASC,
    wfq_task_code                   ASC,
    wfq_application_no              ASC
  )

/

CREATE INDEX idx_wfq_appno_task_code_nw ON wf_queue
  (
    wfq_task_code                   ASC,
    wfq_application_no              ASC
  )

/

CREATE INDEX idx_fk_fwd_task_cd_nw ON wf_queue
  (
    wfq_fwd_tsk_code                ASC
  )

/

CREATE INDEX idx_proc_que_nw ON wf_queue
  (
    wfq_task_code                   ASC,
    wfq_task_staus                  ASC,
    wfq_queue_seq                   ASC
  )

/

CREATE INDEX idx_wf_app_no_nw ON wf_queue
  (
    wfq_application_no              ASC,
    wfq_task_code                   ASC,
    wfq_task_staus                  ASC,
    wfq_queue_seq                   ASC
  )

/

CREATE INDEX idx_fk_wf_code_nw ON wf_queue
  (
    wfq_workflow_cde                ASC
  )

/

CREATE INDEX idx_act_comp_nw ON wf_queue
  (
    TO_CHAR("WFQ_TASK_COMPLETED_DATE",'yyyy/mm/dd') ASC
  )

/



-- Constraints for WF_QUEUE



ALTER TABLE wf_queue
ADD CHECK ("WFQ_QUEUE_SEQ" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_APPLICAITON_STATUS" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_INITIATED_TIME" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_TASK_STAUS" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_TASK_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_APPLICATION_NO" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CHECK ("WFQ_WORKFLOW_CDE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE wf_queue
ADD CONSTRAINT pk_workflow_queue_nw PRIMARY KEY (wfq_queue_seq)

/



-- End of DDL Script for Table LASNIHEWA.WF_QUEUE

-- Start of DDL Script for Sequence LASNIHEWA.SEQ_WM_T_CONFIG_DETAILS


CREATE SEQUENCE seq_wm_t_config_details
  INCREMENT BY 1
  START WITH 41
  MINVALUE 1
  MAXVALUE 99999999999999999999
  NOCYCLE
  NOORDER
  CACHE 20
/


-- End of DDL Script for Sequence LASNIHEWA.SEQ_WM_T_CONFIG_DETAILS

-- Start of DDL Script for Sequence LASNIHEWA.SEQ_WM_T_CONFIG_HEADER


CREATE SEQUENCE seq_wm_t_config_header
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 99999999999999999999
  NOCYCLE
  NOORDER
  CACHE 20
/


-- End of DDL Script for Sequence LASNIHEWA.SEQ_WM_T_CONFIG_HEADER

-- Start of DDL Script for Sequence LASNIHEWA.SEQ_WORKFLOW_QUEUE


CREATE SEQUENCE seq_workflow_queue
  INCREMENT BY 1
  START WITH 81
  MINVALUE 1
  MAXVALUE 999999999999999999
  NOCYCLE
  NOORDER
  CACHE 20
/


-- End of DDL Script for Sequence LASNIHEWA.SEQ_WORKFLOW_QUEUE

-- Foreign Key
ALTER TABLE config_details
ADD CONSTRAINT fk_wm_t_config_details FOREIGN KEY (wch_workf_code)
REFERENCES config_header (wch_workflow_code)
/
ALTER TABLE config_details
ADD CONSTRAINT fk_task_code FOREIGN KEY (wch_task_code)
REFERENCES tasks (wrt_task_code)
ENABLE NOVALIDATE
/
-- Foreign Key
ALTER TABLE location_task_qty
ADD CONSTRAINT fk_2_wm_t_location_task_qty FOREIGN KEY (task_location)
REFERENCES location (location_code)
/
ALTER TABLE location_task_qty
ADD CONSTRAINT fk1_wm_t_location_task_qty FOREIGN KEY (task_code)
REFERENCES tasks (wrt_task_code)
/
-- Foreign Key
ALTER TABLE wf_queue
ADD CONSTRAINT fk_workflow_queue_4 FOREIGN KEY (wfq_application_no)
REFERENCES applications (app_app_no)
/
ALTER TABLE wf_queue
ADD CONSTRAINT fk6_workflow_task FOREIGN KEY (wfq_task_code)
REFERENCES tasks (wrt_task_code)
/
ALTER TABLE wf_queue
ADD CONSTRAINT fk_2_wm_t_workflow_queue FOREIGN KEY (wfq_task_loc)
REFERENCES location (location_code)
/
-- End of DDL script for Foreign Key(s)
