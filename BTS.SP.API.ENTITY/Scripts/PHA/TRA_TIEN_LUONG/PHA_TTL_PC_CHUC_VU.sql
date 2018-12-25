﻿create or replace PROCEDURE PHA_TTL_PC_CHUC_VU (P_CHUC_VU IN NVARCHAR2, P_MA_DBHC IN NVARCHAR2,NAM IN NUMBER, THANG IN NUMBER,DONVI_TIEN number, cur OUT SYS_REFCURSOR) AS
P_QUERRY VARCHAR(32767);
P_SELECT_DBHC VARCHAR2(32767);
BEGIN
  P_SELECT_DBHC:= ' AND list.MA_DBHC IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||''') OR MA_DBHC_CHA IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||'''))';
  P_QUERRY:= ' SELECT detail.HO_TEN, detail.CHUC_DANH,
  SUM (NVL(detail.HO_SO_LUONG,0) /nvl('|| DONVI_TIEN ||',1)) AS HO_SO_LUONG,
  SUM (NVL(detail.PC_KV,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_KV,
  SUM (NVL(detail.PC_CHUC_VU,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_CHUC_VU,
  SUM (NVL(detail.PC_THAM_NIEN,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_THAM_NIEN,
  SUM (NVL(detail.PC_TRACH_NHIEM,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_TRACH_NHIEM,
  SUM (NVL(detail.PC_CONG_VU,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_CONG_VU,
  SUM (NVL(detail.PC_LOAI_XA,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_LOAI_XA,
  SUM (NVL(detail.PC_LAU_NAM,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_LAU_NAM,
  SUM (NVL(detail.PC_THU_HUT,0) /nvl('|| DONVI_TIEN ||',1)) AS PC_THU_HUT,
  SUM (NVL(detail.TONG_HS,0) /nvl('|| DONVI_TIEN ||',1)) AS TONG_HS,
  SUM (NVL(detail.THANH_TIEN,0) /nvl('|| DONVI_TIEN ||',1)) AS THANH_TIEN,
  SUM (NVL(detail.BHXH,0) /nvl('|| DONVI_TIEN ||',1)) AS BHXH,
  SUM (NVL(detail.BHYT,0) /nvl('|| DONVI_TIEN ||',1)) AS BHYT,
  SUM (NVL(detail.CONG_CKPT,0) /nvl('|| DONVI_TIEN ||',1)) AS CONG_CKPT,
  SUM (NVL(detail.THUC_LINH,0) /nvl('|| DONVI_TIEN ||',1)) AS THUC_LINH,
  detail.KY_NHAN, detail.GHI_CHU,
  list.MA_DBHC, list.TEN_DBHC FROM PHA_THANHTOAN_LUONG_DETAIL detail
  INNER JOIN PHA_THANHTOAN_LUONG list ON detail.PHA_THANHTOAN_LUONG_REFID = list.REFID
  WHERE list.NAM = '''||NAM||''' AND list.THANG = '''||THANG||''' AND detail.CHUC_DANH like '''||P_CHUC_VU||''' '||P_SELECT_DBHC||' 
  GROUP BY detail.HO_TEN, detail.CHUC_DANH, detail.KY_NHAN, detail.GHI_CHU, list.MA_DBHC, list.TEN_DBHC 
  ORDER BY list.MA_DBHC ';
  BEGIN
OPEN cur FOR P_QUERRY;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (P_QUERRY  || SQLERRM); 
END; 
END PHA_TTL_PC_CHUC_VU;