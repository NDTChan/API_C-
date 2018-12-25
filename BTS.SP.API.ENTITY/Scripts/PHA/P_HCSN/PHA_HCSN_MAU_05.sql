﻿create or replace procedure PHA_HCSN_MAU_05(P_CONGTHUC VARCHAR2,NAM_HL VARCHAR2,DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR  VARCHAR2(32767); 
   P_SQL_INSERT VARCHAR2(32767);
   P_Q VARCHAR2(32767);
   BEGIN
   IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA (P_CONGTHUC) into P_Q from dual;
        P_SQL_INSERT:= ' '||P_SQL_INSERT ||' and '||P_Q;
        END IF;
QUERY_STR:='select * FROM (SELECT
         tg.MA_CHUONG,
         tg.MA_CAP,
         tg.MA_MUC,
         tg.MA_TIEUMUC,
         tg.MA_CAPMLNS,
         tg.MA_LOAI,
         tg.MA_KBNN,
         tg.MA_DVQHNS,
         tg.MA_NGUON_NSNN,         
         tg.MA_NGANHKT,
         tg.MA_TKTN,
         c.TEN_DVQHNS,
         SUM (NVL(tg.GIA_TRI_HACH_TOAN,0) /nvl('|| DONVI_TIEN ||',1))AS SoDu
    FROM PHA_TIENGUI tg LEFT JOIN SYS_DVQHNS c ON tg.MA_DVQHNS = c.MA_DVQHNS
    WHERE 1=1 and tg.MA_TKTN like ''15%'' AND tg.MA_CAP = ''2'''||P_SQL_INSERT||'
    And To_Char(tg.NGAY_HIEU_LUC,' || Chr(39) || 'yyyy' || Chr(39) || ') = ' || NAM_HL ||'      
GROUP BY tg.MA_CHUONG, tg.MA_CAP, tg.MA_CAPMLNS, 
tg.MA_MUC, tg.MA_TIEUMUC,tg.MA_LOAI,tg.MA_NGANHKT,tg.MA_KBNN,tg.MA_DVQHNS,
tg.MA_NGUON_NSNN,tg.MA_TKTN,c.TEN_DVQHNS)
order by  MA_CHUONG'; 
DBMS_OUTPUT.put_line (QUERY_STR);
BEGIN
OPEN cur FOR QUERY_STR;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (QUERY_STR  || SQLERRM); 
END;    
END PHA_HCSN_MAU_05;