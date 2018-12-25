create or replace procedure PHA_NS_BM54_ND31_TH(P_LOAI_BAOCAO IN VARCHAR2, P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE, P_CAP VARCHAR2, DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR   CLOB; 
   P_CT  VARCHAR2(32767);    
   P_SQL_INSERT  VARCHAR2(32767); 
   TEMP  VARCHAR2(32767);
   
   --CHI DAU TU PHAT TRIEN
   CT_CDT_QP VARCHAR2(32767);   CT_CDT_AN VARCHAR2(32767);   CT_CDT_KH VARCHAR2(32767);   CT_CDT_HDKT VARCHAR2(32767);
   CT_CDT_QLNN VARCHAR2(32767);   CT_CDT_BVMT VARCHAR2(32767);   CT_CDT_BDXH VARCHAR2(32767);   CT_CDT_VH VARCHAR2(32767);
   CT_CDT_KHCN VARCHAR2(32767);   CT_CDT_GD VARCHAR2(32767);   CT_CDT_YT VARCHAR2(32767);   CT_CDT_TDTT VARCHAR2(32767);
   CT_CDT_PT VARCHAR2(32767);
   --CHI THUONG XUYEN
   CT_CTX_QP VARCHAR2(32767);   CT_CTX_AN VARCHAR2(32767);   CT_CTX_KH VARCHAR2(32767);   CT_CTX_HDKT VARCHAR2(32767);
   CT_CTX_QLNN VARCHAR2(32767);   CT_CTX_BVMT VARCHAR2(32767);   CT_CTX_BDXH VARCHAR2(32767);   CT_CTX_VH VARCHAR2(32767);
   CT_CTX_KHCN VARCHAR2(32767);   CT_CTX_GD VARCHAR2(32767);   CT_CTX_YT VARCHAR2(32767);   CT_CTX_TDTT VARCHAR2(32767);
   CT_CTX_PT VARCHAR2(32767);
   --KHAC
   CT_CTMTCDT VARCHAR2(32767);   CT_CTMTCTX VARCHAR2(32767);   CT_CTN VARCHAR2(32767);   CT_CBS VARCHAR2(32767); CT_CCN VARCHAR2(32767);
   
   BEGIN
    IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA_HCSN(P_CONGTHUC) INTO P_CT from dual;       
        P_CT:= ' AND ' || P_CT;
    END IF;
    
    --Gán công thức
    IF(UPPER(P_LOAI_BAOCAO) = 'DH') THEN 
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
    END IF;
    IF(UPPER(P_LOAI_BAOCAO) = 'QT') THEN 
         -------Chi đầu tư
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QP';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_AN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_HDKT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QLNN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BVMT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BDXH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_VH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KHCN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_GD';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_YT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_TDTT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_PT';
        -------Chi thường xuyên
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_QP';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_AN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_KH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_HDKT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_QLNN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_BVMT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_BDXH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_VH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_KHCN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_GD';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_YT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_TDTT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTX_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CTX_PT';        
    END IF;
    -------KHAC
     select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTMTCDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM54_ND31' AND MA_COT='CTMTCDT';
     select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTMTCTX from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM54_ND31' AND MA_COT='CTMTCTX';
     select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CTN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM54_ND31' AND MA_COT='CTN';
     select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CBS from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM54_ND31' AND MA_COT='CBS';
     select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM54_ND31' AND MA_COT='CCN';
    
    CASE 
        WHEN P_CAP='2' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''400'' AND ''989''';
        WHEN P_CAP='3' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''600'' AND ''989''';
        WHEN P_CAP='4' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''800'' AND ''989''';
        ELSE TEMP:='';
    END CASE;
            
            QUERY_STR:='
            select * from
            (
            select Cast(''1'' as nvarchar2(50)) as MA_CHUONG,Cast(''CÁC CƠ QUAN, TỔ CHỨC'' as nvarchar2(50)) as TEN_CHUONG
                        , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                        , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                        , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                        , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                        , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                        , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                        , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN, sum(0) as CBS, sum(0) as CCN
                        from dual
            )
            union all
            select * from (
            SELECT HT.MA_CHUONG, HT.TEN_CHUONG
                        , NVL(HT.CDT_QP,0) as CDT_QP, NVL(HT.CDT_AN,0) as CDT_AN, NVL(HT.CDT_KH,0) as CDT_KH, NVL(HT.CDT_HDKT,0) as CDT_HDKT, NVL(HT.CDT_QLNN,0) as CDT_QLNN
                        , NVL(HT.CDT_BVMT,0) as CDT_BVMT, NVL(HT.CDT_BDXH,0) as CDT_BDXH, NVL(HT.CDT_VH,0) as CDT_VH, NVL(HT.CDT_KHCN,0) as CDT_KHCN
                        , NVL(HT.CDT_GD,0) as CDT_GD, NVL(HT.CDT_YT,0) as CDT_YT, NVL(HT.CDT_TDTT,0) as CDT_TDTT, NVL(HT.CDT_PT,0) as CDT_PT                        
                        , NVL(HT.CTX_QP,0) as  CTX_QP, NVL(HT.CTX_AN,0) as  CTX_AN, NVL(HT.CTX_KH,0) as CTX_KH, NVL(HT.CTX_HDKT,0) as CTX_HDKT, NVL(HT.CTX_QLNN,0) as CTX_QLNN
                        , NVL(HT.CTX_BVMT,0) as CTX_BVMT, NVL(HT.CTX_BDXH,0) as CTX_BDXH, NVL(HT.CTX_VH,0) as CTX_VH, NVL(HT.CTX_KHCN,0) as CTX_KHCN
                        , NVL(HT.CTX_GD,0) as CTX_GD, NVL(HT.CTX_YT,0) as CTX_YT, NVL(HT.CTX_TDTT,0) as CTX_TDTT, NVL(HT.CTX_PT,0) as CTX_PT
                        , NVL(HT.CTMTCDT,0) as CTMTCDT, NVL(HT.CTMTCTX,0) as CTMTCTX, NVL(HT.CTN,0) as CTN, NVL(HT.CBS,0) as CBS, NVL(HT.CCN,0) as CCN
                        
                        FROM
                        (
                        SELECT A.MA_CHUONG AS MA_CHUONG, A.TEN_CHUONG
                        
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_QP
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_AN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_KH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_KH
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_HDKT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_HDKT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_QLNN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_QLNN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_BVMT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_BDXH
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_VH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_VH
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_KHCN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_GD ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_GD
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_YT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_YT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_TDTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_TDTT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_PT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_PT
                        
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
                        
                        ,NVL(SUM (CASE WHEN ('|| CT_CTMTCDT ||')    THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTMTCDT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTMTCTX ||')    THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTMTCTX
                        ,NVL(SUM (CASE WHEN ('|| CT_CTN ||')        THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CTN
                        ,NVL(SUM (CASE WHEN ('|| CT_CBS ||')        THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CBS
                        ,NVL(SUM (CASE WHEN ('|| CT_CCN ||')        THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CCN

                        FROM PHA_HACHTOAN_CHI A
                        WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND NOT A.MA_CAP like ''1'' AND NOT A.MA_CHUONG LIKE ''000'' '
                        || TEMP
                        || P_CT
                        || ' GROUP BY A.MA_CHUONG,A.TEN_CHUONG
                        ) HT
                        WHERE 1=1 ORDER BY HT.MA_CHUONG   )
                        union all
                        select * from 
                        (                       
                        select Cast(''II'' as nvarchar2(50)) as MA_CHUONG, Cast(''CHI TRẢ NỢ LÃI DO CHÍNH QUYỀN ĐỊA PHƯƠNG VAY (2)'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT 
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX
                            , SUM (CASE WHEN (MA_TKTN like ''36%'' and MA_TIEUMUC = ''0814'' ) THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS CTN
                            , sum(0) as CBS, sum(0) as CCN
                        from PHA_HACHTOAN_CHI where NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        
                        union all
                        select Cast(''III'' as nvarchar2(50)) as MA_CHUONG, Cast(''CHI BỔ SUNG QUỸ DỰ TRỮ TÀI CHÍNH (2)'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN
                            , SUM (CASE WHEN (MA_TKTN in (8991,8992,8951) and MA_MUC = ''7500'') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS CBS
                            , sum(0) as CCN
                        from PHA_HACHTOAN_CHI where NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        
                        union all                         
                        select Cast(''IV'' as nvarchar2(50)) as MA_CHUONG,Cast(''CHI DỰ PHÒNG NGÂN SÁCH'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN, sum(0) as CBS, sum(0) as CCN
                        from dual
                        
                        union all
                        select Cast(''V'' as nvarchar2(50)) as MA_CHUONG,Cast(''CHI TẠO NGUỒN, ĐIỀU CHỈNH LÊN LƯƠNG'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN, sum(0) as CBS, sum(0) as CCN                        
                        from dual
                        
                        union all                        
                        select Cast(''VI'' as nvarchar2(50)) as MA_CHUONG,Cast(''CHI BỔ SUNG CÓ MỤC TIÊU CHO NGÂN SÁCH CẤP DƯỚI(3)'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN, sum(0) as CBS, sum(0) as CCN
                        from dual
                        union all
                        select Cast(''VII'' as nvarchar2(50)) as MA_CHUONG,Cast(''CHI CHUYỂN NGUỒN SANG NGÂN SÁCH NĂM SAU'' as nvarchar2(50)) as TEN_CHUONG
                            , sum(0) as CDT_QP, sum(0) as CDT_AN, sum(0) as CDT_KH, sum(0) as CDT_HDKT, sum(0) as CDT_QLNN
                            , sum(0) as CDT_BVMT, sum(0) as CDT_BDXH, sum(0) as CDT_VH, sum(0) as CDT_KHCN
                            , sum(0) as CDT_GD, sum(0) as CDT_YT, sum(0) as CDT_TDTT, sum(0) as CDT_PT
                            , sum(0) as  CTX_QP, sum(0) as  CTX_AN, sum(0) as CTX_KH, sum(0) as CTX_HDKT, sum(0) as CTX_QLNN
                            , sum(0) as CTX_BVMT, sum(0) as CTX_BDXH, sum(0) as CTX_VH, sum(0) as CTX_KHCN
                            , sum(0) as CTX_GD, sum(0) as CTX_YT, sum(0) as CTX_TDTT, sum(0) as CTX_PT
                            , sum(0) as CTMTCDT, sum(0) as CTMTCTX, sum(0) as CTN, sum(0) as CBS
                            , SUM (CASE WHEN (MA_TKTN = 8411 and MA_CHUONG in (160,560,760,860) and MA_NGANHKT = 369 and MA_MUC = ''0950'') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS CCN
                        from PHA_HACHTOAN_CHI where NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        )
                        
                        ';
                        
                    
--DBMS_OUTPUT.put_line(QUERY_STR); 
 
BEGIN
EXECUTE IMMEDIATE QUERY_STR;
OPEN cur FOR QUERY_STR;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
     DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
    --DBMS_OUTPUT.ENABLE(200000);
     DBMS_OUTPUT.put_line ('<your message>'  || SQLERRM); 
END;   
END PHA_NS_BM54_ND31_TH;