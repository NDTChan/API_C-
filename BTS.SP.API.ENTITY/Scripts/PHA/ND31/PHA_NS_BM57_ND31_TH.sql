﻿create or replace PROCEDURE "PHA_NS_BM57_ND31_TH" (P_MA_DBHC IN NVARCHAR2,P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE, P_CAP VARCHAR2, DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   P_INSERT_DT clob;
   P_INSERT_CHI clob;
   QUERY_STR  VARCHAR2(32767);  
   P_CT VARCHAR2(32767);   
   TEMP VARCHAR2(32767);
    P_SELECT_DBHC VARCHAR2(32767);
      --CHI DAU TU PHAT TRIEN
   CT_CDT_QP VARCHAR2(32767);   CT_CDT_AN VARCHAR2(32767);   CT_CDT_KH VARCHAR2(32767);   CT_CDT_HDKT VARCHAR2(32767);
   CT_CDT_QLNN VARCHAR2(32767);   CT_CDT_BVMT VARCHAR2(32767);   CT_CDT_BDXH VARCHAR2(32767);   CT_CDT_VH VARCHAR2(32767);
   CT_CDT_KHCN VARCHAR2(32767);   CT_CDT_GD VARCHAR2(32767);   CT_CDT_YT VARCHAR2(32767);   CT_CDT_TDTT VARCHAR2(32767);
   CT_CDT_PT VARCHAR2(32767);   CT_CDT_HTV VARCHAR2(32767);    CT_CDT_K VARCHAR2(32767);
   --CHI THUONG XUYEN
   CT_CTX_QP VARCHAR2(32767);   CT_CTX_AN VARCHAR2(32767);   CT_CTX_KH VARCHAR2(32767);   CT_CTX_HDKT VARCHAR2(32767);
   CT_CTX_QLNN VARCHAR2(32767);   CT_CTX_BVMT VARCHAR2(32767);   CT_CTX_BDXH VARCHAR2(32767);   CT_CTX_VH VARCHAR2(32767);
   CT_CTX_KHCN VARCHAR2(32767);   CT_CTX_GD VARCHAR2(32767);   CT_CTX_YT VARCHAR2(32767);   CT_CTX_TDTT VARCHAR2(32767);
   CT_CTX_PT VARCHAR2(32767);

   BEGIN
    IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA_HCSN(P_CONGTHUC) INTO P_CT from dual;       
        P_CT:= ' AND ' || P_CT;
    END IF;

    CASE 
        WHEN P_CAP='2' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''400'' AND ''989''';
        WHEN P_CAP='3' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''600'' AND ''989''';
        WHEN P_CAP='4' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''800'' AND ''989''';
        ELSE TEMP:='';
    END CASE;
    IF(P_MA_DBHC <> 27) THEN
        P_SELECT_DBHC:= ' AND A.MA_DIABAN IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||''') OR MA_DBHC_CHA IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||'''))';
        ELSE P_SELECT_DBHC:= ' ';
        END IF;
--        IF(P_SELECT_DBHC IS NOT NULL) THEN
--        P_CT:=P_CT || P_SELECT_DBHC;
--        ELSE
--        P_CT:=P_CT;
--        END IF;
     -------Chi đầu tư
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QP';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_AN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_HDKT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QLNN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BVMT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BDXH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_VH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KHCN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_GD';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_YT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_TDTT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_PT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_HTV from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_HTV';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_K from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_K';
        -------Chi thường xuyên
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_QP';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_AN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_KH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_HDKT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_QLNN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_BVMT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_BDXH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_VH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_KHCN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_GD';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_YT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_TDTT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_PT';


    EXECUTE IMMEDIATE 'TRUNCATE TABLE PHA_THDT_HCSN_DT'; 

    P_INSERT_DT:='INSERT INTO PHA_THDT_HCSN_DT (MA_DIABAN,MA_TKTN,MA_CAP,MA_DVQHNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_CTMTQG,MA_KBNN,MA_NGUON_NSNN,NGAY_KET_SO,NGAY_HIEU_LUC,ENTERED_DR,ENTERED_CR,ACCOUNTED_DR,ACCOUNTED_CR,ATTRIBUTE8,GIA_TRI_HACH_TOAN,MA_NVC)
    SELECT A.MA_DIABAN,A.MA_TKTN,A.MA_CAP,A.MA_DVQHNS,A.MA_CHUONG,A.TEN_CHUONG,A.MA_NGANHKT,A.MA_LOAI,A.MA_CTMTQG,A.MA_KBNN,A.MA_NGUON_NSNN,A.NGAY_KET_SO,A.NGAY_HIEU_LUC,A.ENTERED_DR,A.ENTERED_CR,A.ACCOUNTED_DR,A.ACCOUNTED_CR,A.ATTRIBUTE8,A.GIA_TRI_HACH_TOAN,A.MA_NVC from PHA_DUTOAN A
    WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'') 
                        and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
    AND NOT A.MA_CAP like ''1'' AND NOT A.MA_CHUONG LIKE ''000'' '
     || TEMP
    || P_CT || ''; 

    P_INSERT_CHI:='INSERT INTO PHA_THDT_HCSN_DT (MA_DIABAN,MA_TKTN,TEN_TKTN,MA_MUC,MA_TIEUMUC,MA_CAP,MA_DVQHNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_CTMTQG,MA_KBNN,MA_NGUON_NSNN,NGAY_KET_SO,NGAY_HIEU_LUC,ENTERED_DR,ENTERED_CR,ACCOUNTED_DR,ACCOUNTED_CR,ATTRIBUTE8,GIA_TRI_HACH_TOAN,MA_NVC)
    SELECT A.MA_DIABAN,A.MA_TKTN,A.TEN_TKTN,A.MA_MUC,A.MA_TIEUMUC,A.MA_CAP,A.MA_DVQHNS,A.MA_CHUONG,A.TEN_CHUONG,A.MA_NGANHKT,A.MA_LOAI,A.MA_CTMTQG,A.MA_KBNN,A.MA_NGUON_NSNN,A.NGAY_KET_SO,A.NGAY_HIEU_LUC,A.ENTERED_DR,A.ENTERED_CR,A.ACCOUNTED_DR,A.ACCOUNTED_CR,A.ATTRIBUTE8,A.GIA_TRI_HACH_TOAN,A.MA_NVC from PHA_HACHTOAN_CHI A
    WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'') 
                        and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
    AND NOT A.MA_CAP like ''1'' AND NOT A.MA_CHUONG LIKE ''000'' '
    || TEMP
    || P_CT || P_SELECT_DBHC || '';

    QUERY_STR:='SELECT HT.MA_CHUONG, HT.TEN_CHUONG                      
                ,NVL(HT.DTMS,0) as DTMS, NVL(HT.DTDN,0) as DTDN, NVL(HT.DTBS,0) as DTBS, NVL(HT.DTGT,0) as DTGT, NVL(HT.KPTH,0) as KPTH
                , NVL(HT.CDT_QP,0) as CDT_QP, NVL(HT.CDT_AN,0) as CDT_AN, NVL(HT.CDT_KH,0) as CDT_KH, NVL(HT.CDT_HDKT,0) as CDT_HDKT, NVL(HT.CDT_QLNN,0) as CDT_QLNN
                            , NVL(HT.CDT_BVMT,0) as CDT_BVMT, NVL(HT.CDT_BDXH,0) as CDT_BDXH, NVL(HT.CDT_VH,0) as CDT_VH, NVL(HT.CDT_KHCN,0) as CDT_KHCN
                            , NVL(HT.CDT_GD,0) as CDT_GD, NVL(HT.CDT_YT,0) as CDT_YT, NVL(HT.CDT_TDTT,0) as CDT_TDTT, NVL(HT.CDT_PT,0) as CDT_PT , NVL(HT.CDT_HTV,0) as CDT_HTV, NVL(HT.CDT_K,0) as CDT_K                       
                            , NVL(HT.CTX_QP,0) as  CTX_QP, NVL(HT.CTX_AN,0) as  CTX_AN, NVL(HT.CTX_KH,0) as CTX_KH, NVL(HT.CTX_HDKT,0) as CTX_HDKT, NVL(HT.CTX_QLNN,0) as CTX_QLNN
                            , NVL(HT.CTX_BVMT,0) as CTX_BVMT, NVL(HT.CTX_BDXH,0) as CTX_BDXH, NVL(HT.CTX_VH,0) as CTX_VH, NVL(HT.CTX_KHCN,0) as CTX_KHCN
                            , NVL(HT.CTX_GD,0) as CTX_GD, NVL(HT.CTX_YT,0) as CTX_YT, NVL(HT.CTX_TDTT,0) as CTX_TDTT, NVL(HT.CTX_PT,0) as CTX_PT
                FROM
                (
                SELECT A.MA_CHUONG AS MA_CHUONG, A.TEN_CHUONG                        
                ,NVL(SUM (CASE WHEN ( ATTRIBUTE8 like ''06'' AND  MA_TKTN IN (''9523'',''9527'')) THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS DTMS                      
                ,NVL(SUM (CASE WHEN ( ATTRIBUTE8 like ''01'' AND  MA_TKTN IN (''9523'',''9527'')) THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS DTDN     
                ,NVL(SUM (CASE WHEN ( ATTRIBUTE8 like ''02'' AND  MA_TKTN IN (''9523'',''9527'')) THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS DTBS     
                ,NVL(SUM (CASE WHEN ( ATTRIBUTE8 like ''03'') THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS DTGT
                ,NVL(SUM (CASE WHEN ( MA_TKTN like ''81%'' OR MA_TKTN like ''82%'' OR MA_TKTN like ''15%'' OR MA_TKTN like ''17%'' OR MA_TKTN like ''19%'') THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS KPTH   
                ,0 AS CDT_QP
                ,0 AS CDT_AN
                            ,0 AS CDT_KH
                            ,0 AS CDT_HDKT
                            ,0 AS CDT_QLNN
                            ,0 AS CDT_BVMT
                            ,0 AS CDT_BDXH
                            ,0 AS CDT_VH
                            ,0 AS CDT_KHCN
                            ,0 AS CDT_GD
                            ,0 AS CDT_YT
                            ,0 AS CDT_TDTT
                            ,0 AS CDT_PT
                            ,0 AS CDT_HTV
                            ,0 AS CDT_K

                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_QP
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_AN
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_KH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_KH
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_HDKT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_HDKT
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_QLNN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_QLNN
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_BVMT
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_BDXH
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_VH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_VH
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_KHCN
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_GD ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_GD
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_YT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_YT
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_TDTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_TDTT
                            ,NVL(SUM (CASE WHEN ('|| CT_CTX_PT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTX_PT
                FROM PHA_THDT_HCSN_DT A
                WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                AND NOT A.MA_CAP in (''1'',''0'') AND NOT A.MA_CHUONG LIKE ''000'' AND NOT A.MA_DVQHNS LIKE ''7%'''
                || TEMP
                || P_CT
                || ' GROUP BY A.MA_CHUONG,A.TEN_CHUONG
                ) HT
                WHERE 1=1 ORDER BY HT.MA_CHUONG';      

   --DBMS_OUTPUT.put_line (QUERY_STR);
   --DBMS_OUTPUT.put_line ('P_INSERT_DT:=' ||  P_INSERT_DT );
   --DBMS_OUTPUT.put_line ('P_INSERT_CHI:=' ||  P_INSERT_CHI );

BEGIN
    EXECUTE IMMEDIATE P_INSERT_DT;
    EXECUTE IMMEDIATE P_INSERT_CHI;
    EXECUTE IMMEDIATE QUERY_STR;
OPEN cur FOR QUERY_STR;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (QUERY_STR  || SQLERRM); 
END;    
END PHA_NS_BM57_ND31_TH;
 