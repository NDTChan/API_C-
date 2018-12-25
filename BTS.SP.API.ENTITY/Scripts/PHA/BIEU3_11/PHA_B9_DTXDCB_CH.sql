﻿create or replace PROCEDURE PHA_B9_DTXDCB_CH (P_MA_DBHC IN NVARCHAR2,P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE,DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR  VARCHAR2(32767); 
   P_SQL_INSERT VARCHAR2(32767);
   P_CT VARCHAR2(32767);
   V_TU_NAM VARCHAR(4):= to_char(TUNGAY_HL,'yyyy');
   P_SELECT_DBHC VARCHAR2(32767);
   BEGIN
   IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA (P_CONGTHUC) INTO P_CT from dual;
        P_SQL_INSERT:= ' '||P_SQL_INSERT ||' and '||P_CT;
        END IF;
       

QUERY_STR:=' SELECT LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
            FROM (SELECT  LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA FROM
            (SELECT KB.MA, CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN AS TEN FROM 
            (SELECT HT.MA_DVQHNS, HT.TEN_DVQHNS, HT.MA_KBNN
                ,NVL(HT.DUTOAN,0) as DUTOAN 
                ,NVL(SUM (CASE WHEN (B.MA_TKTN IN(''8211'',''8261'',''8941'',''8951'',''8956'',''8251'') AND B.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                AND B.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                and B.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                and B.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'') AND B.MA_DIABAN <> ''27'' AND B.MA_CAP LIKE ''3'' )     THEN B.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CHI
                ,NVL(SUM (0),0) AS UNG
                FROM
                ( 
                 SELECT A.MA_CHUONG ,A.MA_DVQHNS, A.TEN_DVQHNS, A.MA_KBNN
                 ,NVL(SUM (CASE WHEN (A.MA_TKTN LIKE ''9%'' AND NOT A.MA_TKTN IN (''9557'',''9567'')) THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS DUTOAN
                     
                FROM PHA_DUTOAN A 
                WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')  
                AND A.MA_DVQHNS LIKE ''7%''
                AND A.MA_CAP LIKE ''3'' 
                '|| P_SQL_INSERT|| ' GROUP BY A.MA_CHUONG, A.MA_DVQHNS, A.TEN_DVQHNS, A.MA_KBNN
                ) HT LEFT JOIN PHA_HACHTOAN_CHI B ON HT.MA_DVQHNS = B.MA_DVQHNS AND HT.MA_CHUONG = B.MA_CHUONG AND HT.MA_KBNN = B.MA_KBNN
                WHERE 1=1 AND HT.DUTOAN <> 0
                 GROUP BY HT.MA_DVQHNS, HT.TEN_DVQHNS, HT.DUTOAN, HT.MA_KBNN) CT 
                 INNER JOIN DM_TKKHOBAC KB ON CT.MA_KBNN = KB.MA 
                GROUP BY KB.MA,CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN) LAST INNER JOIN SYS_DVQHNS DV ON LAST.MA_DVQHNS = DV.MA_DVQHNS
                GROUP BY LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA) LT INNER JOIN SYS_DVQHNS DV2 ON LT.MA_DVQHNS_CHA = DV2.MA_DVQHNS
                GROUP BY LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
                
                UNION ALL
                SELECT LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
                FROM (SELECT  LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA FROM
                (SELECT KB.MA,CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN AS TEN FROM 
                (SELECT B.MA_CHUONG, B.MA_DVQHNS, B.TEN_DVQHNS,  B.MA_KBNN
                ,NVL(SUM (0),0) AS DUTOAN
                ,NVL(SUM (0),0) AS CHI
                ,NVL(SUM (CASE WHEN (B.MA_TKTN BETWEEN ''1710'' AND ''1718'' AND B.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                AND B.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                and B.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                and B.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'') AND B.MA_DIABAN <> ''27'' AND B.MA_CAP LIKE ''3'')     THEN B.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS UNG
                FROM
               PHA_HACHTOAN_CHI B 
               WHERE 1=1 GROUP BY B.MA_CHUONG, B.MA_DVQHNS, B.TEN_DVQHNS,  B.MA_KBNN) CT
                 INNER JOIN DM_TKKHOBAC KB ON CT.MA_KBNN = KB.MA AND CT.UNG <> 0
                GROUP BY KB.MA,CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN) LAST INNER JOIN SYS_DVQHNS DV ON LAST.MA_DVQHNS = DV.MA_DVQHNS
                GROUP BY LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA) LT INNER JOIN SYS_DVQHNS DV2 ON LT.MA_DVQHNS_CHA = DV2.MA_DVQHNS
                GROUP BY LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
                
                 UNION ALL
                 SELECT LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
                 FROM (SELECT  LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA FROM
                (SELECT KB.MA,CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN AS TEN FROM 
                    (SELECT B.MA_CHUONG, B.MA_DVQHNS, B.TEN_DVQHNS,  B.MA_KBNN
                ,NVL(SUM (0),0) AS DUTOAN
                ,NVL(SUM (CASE WHEN (B.MA_TKTN IN(''8211'',''8261'',''8941'',''8951'')  AND B.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                AND B.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                and B.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                and B.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'') AND B.MA_DIABAN <> ''27'' AND B.MA_CAP LIKE ''3'')     THEN B.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CHI
                 ,NVL(SUM (0),0) AS UNG
                FROM
               PHA_HACHTOAN_CHI B 
               WHERE 1=1 GROUP BY B.MA_CHUONG, B.MA_DVQHNS, B.TEN_DVQHNS,  B.MA_KBNN) CT
                 INNER JOIN DM_TKKHOBAC KB ON CT.MA_KBNN = KB.MA AND CT.UNG <> 0
                GROUP BY KB.MA,CT.MA_DVQHNS,CT.TEN_DVQHNS,CT.DUTOAN, CT.CHI, CT.UNG, KB.TEN) LAST INNER JOIN SYS_DVQHNS DV ON LAST.MA_DVQHNS = DV.MA_DVQHNS
                GROUP BY LAST.MA,LAST.MA_DVQHNS,LAST.TEN_DVQHNS,LAST.DUTOAN, LAST.CHI, LAST.UNG, LAST.TEN, DV.MA_DVQHNS_CHA) LT INNER JOIN SYS_DVQHNS DV2 ON LT.MA_DVQHNS_CHA = DV2.MA_DVQHNS
                GROUP BY LT.MA,LT.MA_DVQHNS,LT.TEN_DVQHNS,LT.DUTOAN, LT.CHI, LT.UNG, LT.TEN, LT.MA_DVQHNS_CHA , DV2.TEN_DVQHNS
                ORDER BY TEN ';
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
END PHA_B9_DTXDCB_CH;