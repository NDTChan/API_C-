﻿create or replace PROCEDURE PHA_B5_BAO_CAO_TONG_HOP_CHI (P_MA_DBHC IN NVARCHAR2,P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE,DONVI_TIEN number, cur OUT SYS_REFCURSOR) AS 
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
        P_SELECT_DBHC:= ' AND MA_DIABAN IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||''') OR MA_DBHC_CHA IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||'''))';
        IF(P_SELECT_DBHC IS NOT NULL) THEN
        P_SQL_INSERT:=P_SQL_INSERT || P_SELECT_DBHC;
        ELSE
        P_SQL_INSERT:=P_SQL_INSERT;
        END IF;

QUERY_STR:=' 
SELECT  MA_NHOM, TEN_NHOM, MA_TIEUNHOM, TEN_TIEUNHOM, MA_MUC, TEN_MUC, MA_TIEUMUC, TEN_TIEUMUC ,TW_PS,TINH_PS, HUYEN_PS,XA_PS FROM 
(SELECT MA_CAP, 
    (CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'',''6051'',''6099'',''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124''
    ,''6149'',''6151'',''6152'',''6154'',''6155'',''6156'',''6157'',''6199'',''6201'',''6202'',''6249'',''6251'',''6252'',''6253'',''6254'',''6299'',''6301'',''6302'',''6303'',''6304'',''6349'',''6353'',''6399'',''6401'',''6402'',''6403'',''6404''
    ,''6449'',''6501'',''6502'',''6503'',''6504'',''6505'',''6549'',''6551'',''6552'',''6553'',''6599'',''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'',''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699''
    ,''6701'',''6702'',''6703'',''6704'',''6705'',''6749'',''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'',''6801'',''6802'',''6803'',''6805'',''6806'',''6849'',''6851'',''6852'',''6853'',''6855'',''6899'',''6901''
    ,''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'',''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'',''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'',''7051''
    ,''7052'',''7053'',''7054'',''7099'',''7101'',''7102'',''7103'',''7104'',''7149'',''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'',''7201'',''7202'',''7203'',''7249'',''7251''
    ,''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'',''7301'',''7302'',''7303'',''7304'',''7351'',''7356'',''7357'',''7399'',''7401'',''7402'',''7403'',''7405'',''7406'',''7449'',''7451'',''7452'',''7453''
    ,''7454'',''7455'',''7456'',''7457'',''7458'',''7499'',''7501'',''7549'',''7551'',''7552'',''7599'',''7601'',''7602'',''7603'',''7649'',''7651'',''7652'',''7653'',''7654'',''7655'',''7699'',''7701'',''7702'',''7703'',''7749'',''7751'',''7753''
    ,''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'',''7851'',''7852'',''7853'',''7854'',''7899'',''7901'',''7903'',''7949'',''7951'',''7952'',''7953'',''7954'',''7999'',''8003'',''8004'',''8006''
    ,''8008'',''8049'',''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'',''8151'',''8152'',''8153'',''8154'',''8199'',''8301'',''8302'',''8303'',''8304'',''8349'',''8351'',''8352'',''8353'',''8354'',''8399'',''8553'',''8555'',''8556''
    ,''8557'',''8561'',''8599'',''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''0500'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''0600'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'',''8952'',''8953'',''8954'',''8955'',''8999'',''9201'',''9202'',''9203'',''9204'',''9249'',''9251'',''9252'',''9253'',''9254'',''9255'',''9299'',''9301'',''9302'',''9303''
    ,''9349'',''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'',''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''0700'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'',''9651'',''9653'',''9699'',''9701'',''9749'',''9801'') THEN TO_CHAR(''0800'')
    WHEN MA_TIEUMUC IN (''0821'',''0832'',''0836'',''0837'',''0839'',''0845'',''0846'',''0847'',''0848'',''0859'') THEN TO_CHAR(''III'')
    WHEN MA_TIEUMUC IN (''0911'',''0912'',''0913'',''0914'',''0915'',''0916'',''0917'',''0918'',''0961'',''0962'',''0963'',''0964'',''0965'',''0966'',''0967'',''0968'') THEN TO_CHAR(''IV'')
    WHEN (MA_TIEUMUC IN(''0052'') AND MA_TKTN LIKE ''1713'') THEN TO_CHAR(''V'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_NHOM)
    END) AS MA_NHOM
    , (CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'',''6051'',''6099'',''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124''
    ,''6149'',''6151'',''6152'',''6154'',''6155'',''6156'',''6157'',''6199'',''6201'',''6202'',''6249'',''6251'',''6252'',''6253'',''6254'',''6299'',''6301'',''6302'',''6303'',''6304'',''6349'',''6353'',''6399'',''6401'',''6402'',''6403'',''6404''
    ,''6449'',''6501'',''6502'',''6503'',''6504'',''6505'',''6549'',''6551'',''6552'',''6553'',''6599'',''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'',''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699''
    ,''6701'',''6702'',''6703'',''6704'',''6705'',''6749'',''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'',''6801'',''6802'',''6803'',''6805'',''6806'',''6849'',''6851'',''6852'',''6853'',''6855'',''6899'',''6901''
    ,''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'',''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'',''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'',''7051''
    ,''7052'',''7053'',''7054'',''7099'',''7101'',''7102'',''7103'',''7104'',''7149'',''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'',''7201'',''7202'',''7203'',''7249'',''7251''
    ,''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'',''7301'',''7302'',''7303'',''7304'',''7351'',''7356'',''7357'',''7399'',''7401'',''7402'',''7403'',''7405'',''7406'',''7449'',''7451'',''7452'',''7453''
    ,''7454'',''7455'',''7456'',''7457'',''7458'',''7499'',''7501'',''7549'',''7551'',''7552'',''7599'',''7601'',''7602'',''7603'',''7649'',''7651'',''7652'',''7653'',''7654'',''7655'',''7699'',''7701'',''7702'',''7703'',''7749'',''7751'',''7753''
    ,''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'',''7851'',''7852'',''7853'',''7854'',''7899'',''7901'',''7903'',''7949'',''7951'',''7952'',''7953'',''7954'',''7999'',''8003'',''8004'',''8006''
    ,''8008'',''8049'',''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'',''8151'',''8152'',''8153'',''8154'',''8199'',''8301'',''8302'',''8303'',''8304'',''8349'',''8351'',''8352'',''8353'',''8354'',''8399'',''8553'',''8555'',''8556''
    ,''8557'',''8561'',''8599'',''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''CHI THƯỜNG XUYÊN'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''CHI MUA HÀNG HÓA, VẬT TƯ DỰ TRỮ'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'',''8952'',''8953'',''8954'',''8955'',''8999'',''9201'',''9202'',''9203'',''9204'',''9249'',''9251'',''9252'',''9253'',''9254'',''9255'',''9299'',''9301'',''9302'',''9303''
    ,''9349'',''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'',''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''CHI ĐẦU TƯ PHÁT TRIỂN'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'',''9651'',''9653'',''9699'',''9701'',''9749'',''9801'') THEN TO_CHAR(''CHI CHO VAY VÀ GÓP VỐN CỦA NGÂN SÁCH NHÀ NƯỚC'')
    WHEN MA_TIEUMUC IN (''0821'',''0832'',''0836'',''0837'',''0839'',''0845'',''0846'',''0847'',''0848'',''0859'') THEN TO_CHAR(''VAY VÀ TRẢ NỢ GỐC VAY CỦA NGÂN SÁCH NHÀ NƯỚC'')
    WHEN MA_TIEUMUC IN (''0911'',''0912'',''0913'',''0914'',''0915'',''0916'',''0917'',''0918'',''0961'',''0962'',''0963'',''0964'',''0965'',''0966'',''0967'',''0968'') THEN TO_CHAR(''MÃ SỐ DANH MỤC THEO DÕI CHUYỂN NGUỒN GIỮA CÁC NĂM'')
    WHEN (MA_TIEUMUC IN(''0052'') AND MA_TKTN LIKE ''1717'') THEN TO_CHAR(''MỤC TẠM CHI CHƯA ĐƯA VÀO NGÂN SÁCH NHÀ NƯỚC'')
    WHEN MA_TKTN LIKE ''36%''  THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.TEN_NHOM)
    END) AS TEN_NHOM
    , (CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'',''6051'',''6099'',''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124'',''6149'',''6151'',''6152''
    ,''6154'',''6155'',''6156'',''6157'',''6199'',''6201'',''6202'',''6249'',''6251'',''6252'',''6253'',''6254'',''6299'',''6301'',''6302'',''6303'',''6304'',''6349'',''6353'',''6399'',''6401'',''6402'',''6403'',''6404'',''6449'') THEN TO_CHAR(''0129'')
    WHEN MA_TIEUMUC IN (''6501'',''6502'',''6503'',''6504'',''6505'',''6549'',''6551'',''6552'',''6553'',''6599'',''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'',''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699''
    ,''6701'',''6702'',''6703'',''6704'',''6705'',''6749'',''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'',''6801'',''6802'',''6803'',''6805'',''6806'',''6849'',''6851'',''6852'',''6853'',''6855'',''6899'',''6901''
    ,''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'',''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'',''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'',''7051''
    ,''7052'',''7053'',''7054'',''7099'') THEN TO_CHAR(''0130'')
    WHEN MA_TIEUMUC IN (''7101'',''7102'',''7103'',''7104'',''7149'',''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'',''7201'',''7202'',''7203'',''7249'',''7251''
    ,''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'',''7301'',''7302'',''7303'',''7304'',''7351'',''7356'',''7357'',''7399'',''7401'',''7402'',''7403'',''7405'',''7406'',''7449'',''7451'',''7452'',''7453''
    ,''7454'',''7455'',''7456'',''7457'',''7458'',''7499'') THEN ''0131''
    WHEN MA_TIEUMUC IN (''7501'',''7549'',''7551'',''7552'',''7599'',''7601'',''7602'',''7603'',''7649'',''7651'',''7652'',''7653'',''7654'',''7655'',''7699'',''7701'',''7702'',''7703'',''7749'',''7751'',''7753''
    ,''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'',''7851'',''7852'',''7853'',''7854'',''7899'',''7901'',''7903'',''7949'',''7951'',''7952'',''7953'',''7954'',''7999'',''8003'',''8004'',''8006''
    ,''8008'',''8049'',''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'',''8151'',''8152'',''8153'',''8154'',''8199'') THEN TO_CHAR(''0132'')
    WHEN MA_TIEUMUC IN (''8301'',''8302'',''8303'',''8304'',''8349'',''8351'',''8352'',''8353'',''8354'',''8399'',''8553'',''8555'',''8556'',''8557'',''8561'',''8599'',''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''0133'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''0134'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'',''8952'',''8953'',''8954'',''8955'',''8999'') THEN TO_CHAR(''0135'')
    WHEN MA_TIEUMUC IN (''9201'',''9202'',''9203'',''9204'',''9249'',''9251'',''9252'',''9253'',''9254'',''9255'',''9299'',''9301'',''9302'',''9303'',''9349'',''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'',''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''0136'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'',''9651'',''9653'',''9699'',''9701'',''9749'') THEN TO_CHAR(''0137'')
    WHEN MA_TIEUMUC IN (''9801'') THEN TO_CHAR(''0138'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_TIEUNHOM)
    END) AS MA_TIEUNHOM
    , (CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'',''6051'',''6099'',''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124'',''6149'',''6151'',''6152''
    ,''6154'',''6155'',''6156'',''6157'',''6199'',''6201'',''6202'',''6249'',''6251'',''6252'',''6253'',''6254'',''6299'',''6301'',''6302'',''6304'',''6349'',''6353'',''6399'',''6401'',''6402'',''6403'',''6404'',''6449'') THEN TO_CHAR(''Chi thanh toán cho cá nhân'')
    WHEN MA_TIEUMUC IN (''6501'',''6502'',''6503'',''6504'',''6505'',''6549'',''6551'',''6552'',''6553'',''6599'',''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'',''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699''
    ,''6701'',''6702'',''6703'',''6704'',''6705'',''6749'',''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'',''6801'',''6802'',''6803'',''6805'',''6806'',''6849'',''6851'',''6852'',''6853'',''6855'',''6899'',''6901''
    ,''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'',''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'',''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'',''7051''
    ,''7052'',''7053'',''7054'',''7099'') THEN TO_CHAR(''Chi về hàng hóa, dịch vụ'')
    WHEN MA_TIEUMUC IN (''7101'',''7102'',''7103'',''7104'',''7149'',''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'',''7201'',''7202'',''7203'',''7249'',''7251''
    ,''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'',''7301'',''7302'',''7303'',''7304'',''7351'',''7356'',''7357'',''7399'',''7401'',''7402'',''7403'',''7405'',''7406'',''7449'',''7451'',''7452'',''7453''
    ,''7454'',''7455'',''7456'',''7457'',''7458'',''7499'') THEN TO_CHAR(''Chi hỗ trợ và bổ sung'')
    WHEN MA_TIEUMUC IN (''7501'',''7549'',''7551'',''7552'',''7599'',''7601'',''7602'',''7603'',''7649'',''7651'',''7652'',''7653'',''7654'',''7655'',''7699'',''7701'',''7702'',''7703'',''7749'',''7751'',''7753''
    ,''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'',''7851'',''7852'',''7853'',''7854'',''7899'',''7901'',''7903'',''7949'',''7951'',''7952'',''7953'',''7954'',''7999'',''8003'',''8004'',''8006''
    ,''8008'',''8049'',''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'',''8151'',''8152'',''8153'',''8154'',''8199'') THEN TO_CHAR(''Các khoản chi khác'')
    WHEN MA_TIEUMUC IN (''8301'',''8302'',''8303'',''8304'',''8349'',''8351'',''8352'',''8353'',''8354'',''8399'',''8553'',''8555'',''8556'',''8557'',''8561'',''8599'',''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''Chi trả nợ lãi, phí vay thuộc ngân sách Nhà nước'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''Chi mua hàng hóa, vật tư dự trữ'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'',''8952'',''8953'',''8954'',''8955'',''8999'') THEN TO_CHAR(''Đầu tư, hỗ trợ vốn cho các doanh nghiệp, các quỹ và đầu tư phát triển khác'')
    WHEN MA_TIEUMUC IN (''9201'',''9202'',''9203'',''9204'',''9249'',''9251'',''9252'',''9253'',''9254'',''9255'',''9299'',''9301'',''9302'',''9303'',''9349'',''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'',''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''Chi đầu tư các dự án'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'',''9651'',''9653'',''9699'',''9701'',''9749'') THEN TO_CHAR(''Chi cho vay và góp vốn của Nhà nước'')
    WHEN MA_TIEUMUC IN (''9801'') THEN TO_CHAR(''Chi hỗ trợ địa phương khác'')
    WHEN MA_TIEUMUC IN (''0821'',''0832'',''0836'',''0837'',''0839'',''0845'',''0846'',''0847'',''0848'',''0859'') THEN TO_CHAR(''VAY VÀ TRẢ NỢ GỐC VAY CỦA NGÂN SÁCH NHÀ NƯỚC'')
    WHEN (MA_TIEUMUC IN(''0052'') AND MA_TKTN LIKE ''1717'') THEN TO_CHAR(''MỤC TẠM CHI CHƯA ĐƯA VÀO NGÂN SÁCH NHÀ NƯỚC'')
    WHEN MA_TKTN LIKE ''36%''  THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.TEN_TIEUNHOM)
    END) AS TEN_TIEUNHOM
    , (CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'') THEN TO_CHAR(''6000'')
    WHEN MA_TIEUMUC IN (''6051'',''6099'') THEN TO_CHAR(''6050'')
    WHEN MA_TIEUMUC IN (''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124'',''6149'') THEN ''6100''
    WHEN MA_TIEUMUC IN (''6151'',''6152'',''6154'',''6155'',''6156'',''6157'',''6199'') THEN TO_CHAR(''6150'')
    WHEN MA_TIEUMUC IN (''6201'',''6202'',''6249'') THEN TO_CHAR(''6200'')
    WHEN MA_TIEUMUC IN (''6251'',''6252'',''6253'',''6254'',''6299'') THEN TO_CHAR(''6250'')
    WHEN MA_TIEUMUC IN (''6301'',''6302'',''6303'',''6304'',''6349'') THEN TO_CHAR(''6300'')
    WHEN MA_TIEUMUC IN (''6353'',''6399'') THEN TO_CHAR(''6350'')
    WHEN MA_TIEUMUC IN (''6401'',''6402'',''6403'',''6404'',''6449'') THEN TO_CHAR(''6400'')
    WHEN MA_TIEUMUC IN (''6501'',''6502'',''6503'',''6504'',''6505'',''6549'') THEN TO_CHAR(''6500'')
    WHEN MA_TIEUMUC IN (''6551'',''6552'',''6553'',''6599'') THEN TO_CHAR(''6550'')
    WHEN MA_TIEUMUC IN (''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'') THEN TO_CHAR(''6600'')
    WHEN MA_TIEUMUC IN (''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699'') THEN TO_CHAR(''6650'')
    WHEN MA_TIEUMUC IN (''6701'',''6702'',''6703'',''6704'',''6705'',''6749'') THEN TO_CHAR(''6700'')
    WHEN MA_TIEUMUC IN (''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'') THEN TO_CHAR(''6750'')
    WHEN MA_TIEUMUC IN (''6801'',''6802'',''6803'',''6805'',''6806'',''6849'') THEN TO_CHAR(''6800'')
    WHEN MA_TIEUMUC IN (''6851'',''6852'',''6853'',''6855'',''6899'') THEN TO_CHAR(''6850'')
    WHEN MA_TIEUMUC IN (''6901'',''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'') THEN TO_CHAR(''6900'')
    WHEN MA_TIEUMUC IN (''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'') THEN TO_CHAR(''6950'')
    WHEN MA_TIEUMUC IN (''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'') THEN TO_CHAR(''7000'')
    WHEN MA_TIEUMUC IN (''7051'',''7052'',''7053'',''7054'',''7099'') THEN TO_CHAR(''7050'')
    WHEN MA_TIEUMUC IN (''7101'',''7102'',''7103'',''7104'',''7149'') THEN TO_CHAR(''7100'')
    WHEN MA_TIEUMUC IN (''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'') THEN TO_CHAR(''7150'')
    WHEN MA_TIEUMUC IN (''7201'',''7202'',''7203'',''7249'') THEN TO_CHAR(''7200'')
    WHEN MA_TIEUMUC IN (''7251'',''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'') THEN TO_CHAR(''7250'')
    WHEN MA_TIEUMUC IN (''7301'',''7302'',''7303'',''7304'') THEN TO_CHAR(''7300'')
    WHEN MA_TIEUMUC IN (''7351'',''7356'',''7357'',''7399'') THEN TO_CHAR(''7350'')
    WHEN MA_TIEUMUC IN (''7401'',''7402'',''7403'',''7405'',''7406'',''7449'') THEN TO_CHAR(''7400'')
    WHEN MA_TIEUMUC IN (''7451'',''7452'',''7453'',''7454'',''7455'',''7456'',''7457'',''7458'',''7499'') THEN TO_CHAR(''7450'')
    WHEN MA_TIEUMUC IN (''7501'',''7549'') THEN TO_CHAR(''7500'')
    WHEN MA_TIEUMUC IN (''7551'',''7552'',''7599'') THEN TO_CHAR(''7550'')
    WHEN MA_TIEUMUC IN (''7601'',''7602'',''7603'',''7649'') THEN TO_CHAR(''7600'')
    WHEN MA_TIEUMUC IN (''7651'',''7652'',''7653'',''7654'',''7655'',''7699'') THEN TO_CHAR(''7650'')
    WHEN MA_TIEUMUC IN (''7701'',''7702'',''7703'',''7749'') THEN TO_CHAR(''7700'')
    WHEN MA_TIEUMUC IN (''7751'',''7753'',''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'') THEN TO_CHAR(''7750'')
    WHEN MA_TIEUMUC IN (''7851'',''7852'',''7853'',''7854'',''7899'') THEN TO_CHAR(''7850'')
    WHEN MA_TIEUMUC IN (''7901'',''7903'',''7949'') THEN TO_CHAR(''7900'')
    WHEN MA_TIEUMUC IN (''7951'',''7952'',''7953'',''7954'',''7999'') THEN TO_CHAR(''7950'')
    WHEN MA_TIEUMUC IN (''8003'',''8004'',''8006'',''8008'',''8049'') THEN TO_CHAR(''8000'')
    WHEN MA_TIEUMUC IN (''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'') THEN TO_CHAR(''8050'')
    WHEN MA_TIEUMUC IN (''8151'',''8152'',''8153'',''8154'',''8199'') THEN TO_CHAR(''8150'')
    WHEN MA_TIEUMUC IN (''8301'',''8302'',''8303'',''8304'',''8349'') THEN TO_CHAR(''8300'')
    WHEN MA_TIEUMUC IN (''8351'',''8352'',''8353'',''8354'',''8399'') THEN TO_CHAR(''8350'')
    WHEN MA_TIEUMUC IN (''8553'',''8555'',''8556'',''8557'',''8561'',''8599'') THEN TO_CHAR(''8550'')
    WHEN MA_TIEUMUC IN (''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''8600'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''8750'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'') THEN TO_CHAR(''8900'')
    WHEN MA_TIEUMUC IN (''8952'',''8953'',''8954'',''8955'',''8999'') THEN TO_CHAR(''8950'')
    WHEN MA_TIEUMUC IN (''9201'',''9202'',''9203'',''9204'',''9249'') THEN TO_CHAR(''9200'')
    WHEN MA_TIEUMUC IN (''9251'',''9252'',''9253'',''9254'',''9255'',''9299'') THEN TO_CHAR(''9250'')
    WHEN MA_TIEUMUC IN (''9301'',''9302'',''9303'',''9349'') THEN TO_CHAR(''9300'')
    WHEN MA_TIEUMUC IN (''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'') THEN TO_CHAR(''9350'')
    WHEN MA_TIEUMUC IN (''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''9400'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'') THEN TO_CHAR(''9500'')
    WHEN MA_TIEUMUC IN (''9651'',''9653'',''9699'') THEN TO_CHAR(''9650'')
    WHEN MA_TIEUMUC IN (''9701'',''9749'') THEN TO_CHAR(''9700'')
    WHEN MA_TIEUMUC IN (''9801'') THEN TO_CHAR(''9800'')
    WHEN MA_TIEUMUC IN (''0821'',''0832'',''0836'',''0837'',''0839'') THEN TO_CHAR(''0820'')
    WHEN MA_TIEUMUC IN (''0845'',''0846'',''0847'',''0848'',''0859'') THEN TO_CHAR(''0840'')
    WHEN MA_TIEUMUC IN (''0911'',''0912'',''0913'',''0914'',''0915'',''0916'',''0917'',''0918'') THEN TO_CHAR(''0900'')
    WHEN MA_TIEUMUC IN (''0961'',''0962'',''0963'',''0964'',''0965'',''0966'',''0967'',''0968'') THEN TO_CHAR(''0950'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_MUC)
    END) AS MA_MUC
    ,(CASE WHEN MA_TIEUMUC IN (''6001'',''6003'',''6049'') THEN TO_CHAR(''Tiền lương'')
    WHEN MA_TIEUMUC IN (''6051'',''6099'') THEN TO_CHAR(''Tiền công trả cho vị trí lao động thường xuyên theo hợp đồng'')
    WHEN MA_TIEUMUC IN (''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124'',''6149'') THEN ''Phụ cấp lương''
    WHEN MA_TIEUMUC IN (''6151'',''6152'',''6154'',''6155'',''6156'',''6157'',''6199'') THEN TO_CHAR(''Học bổng và hỗ trợ khác cho học sinh, sinh viên, cán bộ đi học'')
    WHEN MA_TIEUMUC IN (''6201'',''6202'',''6249'') THEN TO_CHAR(''Tiền thưởng'')
    WHEN MA_TIEUMUC IN (''6251'',''6252'',''6253'',''6254'',''6299'') THEN TO_CHAR(''Phúc lợi tập thể'')
    WHEN MA_TIEUMUC IN (''6301'',''6302'',''6303'',''6304'',''6349'') THEN TO_CHAR(''Các khoản đóng góp'')
    WHEN MA_TIEUMUC IN (''6353'',''6399'') THEN TO_CHAR(''Chi cho cán bộ không chuyên trách xã, thôn, bản'')
    WHEN MA_TIEUMUC IN (''6401'',''6402'',''6403'',''6404'',''6449'') THEN TO_CHAR(''Các khoản thanh toán khác cho cá nhân'')
    WHEN MA_TIEUMUC IN (''6501'',''6502'',''6503'',''6504'',''6505'',''6549'') THEN TO_CHAR(''Thanh toán dịch vụ công cộng'')
    WHEN MA_TIEUMUC IN (''6551'',''6552'',''6553'',''6599'') THEN TO_CHAR(''Vật tư văn phòng'')
    WHEN MA_TIEUMUC IN (''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'') THEN TO_CHAR(''Thông tin, tuyên truyền, liên lạc'')
    WHEN MA_TIEUMUC IN (''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699'') THEN TO_CHAR(''Hội nghị'')
    WHEN MA_TIEUMUC IN (''6701'',''6702'',''6703'',''6704'',''6705'',''6749'') THEN TO_CHAR(''Công tác phí'')
    WHEN MA_TIEUMUC IN (''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'') THEN TO_CHAR(''Chi phí thuê mướn'')
    WHEN MA_TIEUMUC IN (''6801'',''6802'',''6803'',''6805'',''6806'',''6849'') THEN TO_CHAR(''Chi đoàn ra'')
    WHEN MA_TIEUMUC IN (''6851'',''6852'',''6853'',''6855'',''6899'') THEN TO_CHAR(''Chi đoàn vào'')
    WHEN MA_TIEUMUC IN (''6901'',''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'') THEN TO_CHAR(''Sửa chữa, duy tu tài sản phục vụ công tác chuyên môn và các công trình cơ sở hạ tầng'')
    WHEN MA_TIEUMUC IN (''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'') THEN TO_CHAR(''Mua sắm tài sản phục vụ công tác chuyên môn'')
    WHEN MA_TIEUMUC IN (''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'') THEN TO_CHAR(''Chi phí nghiệp vụ chuyên môn của từng ngành'')
    WHEN MA_TIEUMUC IN (''7051'',''7052'',''7053'',''7054'',''7099'') THEN TO_CHAR(''Mua sắm tài sản vô hình'')
    WHEN MA_TIEUMUC IN (''7101'',''7102'',''7103'',''7104'',''7149'') THEN TO_CHAR(''Chi hỗ trợ kinh tế tập thể và dân cư'')
    WHEN MA_TIEUMUC IN (''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'') THEN TO_CHAR(''Chi về công tác người có công với cách mạng và xã hội'')
    WHEN MA_TIEUMUC IN (''7201'',''7202'',''7203'',''7249'') THEN TO_CHAR(''Trợ giá theo chính sách của Nhà nước'')
    WHEN MA_TIEUMUC IN (''7251'',''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'') THEN TO_CHAR(''Chi lương hưu và trợ cấp bảo hiểm xã hội'')
    WHEN MA_TIEUMUC IN (''7301'',''7302'',''7303'',''7304'') THEN TO_CHAR(''Chi bổ sung cho ngân sách cấp dưới'')
    WHEN MA_TIEUMUC IN (''7351'',''7356'',''7357'',''7399'') THEN TO_CHAR(''Chi xúc tiến thương mại, du lịch và đầu tư'')
    WHEN MA_TIEUMUC IN (''7401'',''7402'',''7403'',''7405'',''7406'',''7449'') THEN TO_CHAR(''Chi viện trợ'')
    WHEN MA_TIEUMUC IN (''7451'',''7452'',''7453'',''7454'',''7455'',''7456'',''7457'',''7458'',''7499'') THEN TO_CHAR(''Chi về công tác bảo đảm xã hội'')
    WHEN MA_TIEUMUC IN (''7501'',''7549'') THEN TO_CHAR(''Chi bổ sung quỹ dự trữ tài chính'')
    WHEN MA_TIEUMUC IN (''7551'',''7552'',''7599'') THEN TO_CHAR(''Chi hoàn thuế giá trị gia tăng theo Luật thuế giá trị gia tăng'')
    WHEN MA_TIEUMUC IN (''7601'',''7602'',''7603'',''7649'') THEN TO_CHAR(''Chi xử lý tài sản được xác lập sở hữu Nhà nước'')
    WHEN MA_TIEUMUC IN (''7651'',''7652'',''7653'',''7654'',''7655'',''7699'') THEN TO_CHAR(''Chi các khoản thu nhầm, thu thừa năm trước và chi trả lãi do trả chậm'')
    WHEN MA_TIEUMUC IN (''7701'',''7702'',''7703'',''7749'') THEN TO_CHAR(''Chi hoàn trả giữa các cấp ngân sách'')
    WHEN MA_TIEUMUC IN (''7751'',''7753'',''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'') THEN TO_CHAR(''Chi khác'')
    WHEN MA_TIEUMUC IN (''7851'',''7852'',''7853'',''7854'',''7899'') THEN TO_CHAR(''Chi cho công tác Đảng ở tổ chức Đảng cơ sở và các cấp trên cơ sở, các đơn vị hành chính, sự nghiệp'')
    WHEN MA_TIEUMUC IN (''7901'',''7903'',''7949'') THEN TO_CHAR(''Chi cho các sự kiện lớn'')
    WHEN MA_TIEUMUC IN (''7951'',''7952'',''7953'',''7954'',''7999'') THEN TO_CHAR(''Chi lập các quỹ của đơn vị thực hiện khoán chi và đơn vị sự nghiệp có thu theo chế độ quy định'')
    WHEN MA_TIEUMUC IN (''8003'',''8004'',''8006'',''8008'',''8049'') THEN TO_CHAR(''Chi hỗ trợ và giải quyết việc làm'')
    WHEN MA_TIEUMUC IN (''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'') THEN TO_CHAR(''Chi hỗ trợ doanh nghiệp và Quỹ tài chính của Nhà nước'')
    WHEN MA_TIEUMUC IN (''8151'',''8152'',''8153'',''8154'',''8199'') THEN TO_CHAR(''Chi quy hoạch'')
    WHEN MA_TIEUMUC IN (''8301'',''8302'',''8303'',''8304'',''8349'') THEN TO_CHAR(''Trả lãi tiền vay trong nước của ngân sách nhà nước'')
    WHEN MA_TIEUMUC IN (''8351'',''8352'',''8353'',''8354'',''8399'') THEN TO_CHAR(''Trả lãi tiền vay ngoài nước của ngân sách nhà nước'')
    WHEN MA_TIEUMUC IN (''8553'',''8555'',''8556'',''8557'',''8561'',''8599'') THEN TO_CHAR(''Trả các khoản phí và chi phí liên quan đến các khoản vay trong nước'')
    WHEN MA_TIEUMUC IN (''8651'',''8652'',''8653'',''8654'',''8655'',''8699'') THEN TO_CHAR(''Trả các khoản phí và chi phí liên quan đến các khoản vay ngoài nước'')
    WHEN MA_TIEUMUC IN (''8751'',''8752'',''8753'',''8754'',''8799'') THEN TO_CHAR(''Hàng hoá, vật tư dự trữ Quốc gia'')
    WHEN MA_TIEUMUC IN (''8901'',''8902'',''8903'',''8904'',''8905'',''8949'') THEN TO_CHAR(''Hỗ trợ hoạt động tín dụng của Nhà nước'')
    WHEN MA_TIEUMUC IN (''8952'',''8953'',''8954'',''8955'',''8999'') THEN TO_CHAR(''Đầu tư vốn cho các doanh nghiệp, các quỹ'')
    WHEN MA_TIEUMUC IN (''9201'',''9202'',''9203'',''9204'',''9249'') THEN TO_CHAR(''Chi chuẩn bị đầu tư'')
    WHEN MA_TIEUMUC IN (''9251'',''9252'',''9253'',''9254'',''9255'',''9299'') THEN TO_CHAR(''Chi bồi thường, hỗ trợ, tái định cư khi Nhà nước thu hồi đất'')
    WHEN MA_TIEUMUC IN (''9301'',''9302'',''9303'',''9349'') THEN TO_CHAR(''Chi xây dựng'')
    WHEN MA_TIEUMUC IN (''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'') THEN TO_CHAR(''Chi thiết bị'')
    WHEN MA_TIEUMUC IN (''9401'',''9402'',''9403'',''9405'',''9449'') THEN TO_CHAR(''Chi phí khác'')
    WHEN MA_TIEUMUC IN (''9501'',''9549'') THEN TO_CHAR(''Cho vay đầu tư phát triển trong nước'')
    WHEN MA_TIEUMUC IN (''9651'',''9653'',''9699'') THEN TO_CHAR(''Cho vay ngoài nước'')
    WHEN MA_TIEUMUC IN (''9701'',''9749'') THEN TO_CHAR(''Đóng góp với các tổ chức quốc tế và tham gia góp vốn của Nhà nước'')
    WHEN MA_TIEUMUC IN (''9801'') THEN TO_CHAR(''Chi hỗ trợ địa phương khác'')
    WHEN MA_TIEUMUC IN (''0821'',''0832'',''0836'',''0837'',''0839'') THEN TO_CHAR(''Vay và trả nợ gốc vay trong nước của Ngân sách nhà nước'')
    WHEN MA_TIEUMUC IN (''0845'',''0846'',''0847'',''0848'',''0859'') THEN TO_CHAR(''Vay và trả nợ gốc vay ngoài nước của Ngân sách nhà nước'')
    WHEN MA_TIEUMUC IN (''0911'',''0912'',''0913'',''0914'',''0915'',''0916'',''0917'',''0918'') THEN TO_CHAR(''Nguồn năm trước chuyển sang năm nay (thu chuyển nguồn)'')
    WHEN MA_TIEUMUC IN (''0961'',''0962'',''0963'',''0964'',''0965'',''0966'',''0967'',''0968'') THEN TO_CHAR(''Chuyển nguồn năm nay sang năm sau (chi chuyển nguồn)'')
    WHEN (MA_TIEUMUC IN(''0052'') AND MA_TKTN LIKE ''1717'') THEN TO_CHAR(''Tạm ứng vốn xây dựng cơ bản qua Kho bạc Nhà nước '')
    WHEN MA_TKTN LIKE ''36%'' THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_MUC)
    END) AS TEN_MUC
    , MA_TIEUMUC, TEN_TIEUMUC, SUM(GIA_TRI_HACH_TOAN) AS PS, MA_TKTN 
    FROM PHA_HACHTOAN_CHI WHERE 1=1 '||' AND (MA_TIEUMUC IN(''6001'',''6003'',''6049'',''6051'',''6099'',''6101'',''6102'',''6103'',''6105'',''6107'',''6111'',''6112'',''6113'',''6114'',''6115'',''6116'',''6121'',''6122'',''6123'',''6124''
    ,''6149'',''6151'',''6152'',''6154'',''6155'',''6156'',''6157'',''6199'',''6201'',''6202'',''6249'',''6251'',''6252'',''6253'',''6254'',''6299'',''6301'',''6302'',''6303'',''6304'',''6349'',''6353'',''6399'',''6401'',''6402'',''6403'',''6404''
    ,''6449'',''6501'',''6502'',''6503'',''6504'',''6505'',''6549'',''6551'',''6552'',''6553'',''6599'',''6601'',''6603'',''6605'',''6606'',''6608'',''6618'',''6649'',''6651'',''6652'',''6653'',''6654'',''6655'',''6656'',''6657'',''6658'',''6699''
    ,''6701'',''6702'',''6703'',''6704'',''6705'',''6749'',''6751'',''6752'',''6754'',''6755'',''6756'',''6757'',''6758'',''6761'',''6799'',''6801'',''6802'',''6803'',''6805'',''6806'',''6849'',''6851'',''6852'',''6853'',''6855'',''6899'',''6901''
    ,''6902'',''6903'',''6905'',''6907'',''6912'',''6913'',''6918'',''6921'',''6922'',''6923'',''6949'',''6951'',''6952'',''6953'',''6954'',''6955'',''6956'',''6999'',''7001'',''7004'',''7008'',''7011'',''7012'',''7017'',''7018'',''7049'',''7051''
    ,''7052'',''7053'',''7054'',''7099'',''7101'',''7102'',''7103'',''7104'',''7149'',''7151'',''7152'',''7153'',''7154'',''7155'',''7157'',''7158'',''7161'',''7162'',''7164'',''7165'',''7166'',''7199'',''7201'',''7202'',''7203'',''7249'',''7251''
    ,''7252'',''7254'',''7255'',''7256'',''7257'',''7258'',''7261'',''7262'',''7263'',''7299'',''7301'',''7302'',''7303'',''7304'',''7351'',''7356'',''7357'',''7399'',''7401'',''7402'',''7403'',''7405'',''7406'',''7449'',''7451'',''7452'',''7453''
    ,''7454'',''7455'',''7456'',''7457'',''7458'',''7499'',''7501'',''7549'',''7551'',''7552'',''7599'',''7601'',''7602'',''7603'',''7649'',''7651'',''7652'',''7653'',''7654'',''7655'',''7699'',''7701'',''7702'',''7703'',''7749'',''7751'',''7753''
    ,''7754'',''7756'',''7757'',''7761'',''7762'',''7763'',''7764'',''7765'',''7766'',''7767'',''7799'',''7851'',''7852'',''7853'',''7854'',''7899'',''7901'',''7903'',''7949'',''7951'',''7952'',''7953'',''7954'',''7999'',''8003'',''8004'',''8006''
    ,''8008'',''8049'',''8051'',''8052'',''8053'',''8054'',''8055'',''8056'',''8099'',''8151'',''8152'',''8153'',''8154'',''8199'',''8301'',''8302'',''8303'',''8304'',''8349'',''8351'',''8352'',''8353'',''8354'',''8399'',''8553'',''8555'',''8556''
    ,''8557'',''8561'',''8599'',''8651'',''8652'',''8653'',''8654'',''8655'',''8699'',''8751'',''8752'',''8753'',''8754'',''8799'',''8901'',''8902'',''8903'',''8904'',''8905'',''8949'',''8952'',''8953'',''8954'',''8955'',''8999'',''9201'',''9202''
    ,''9203'',''9204'',''9249'',''9251'',''9252'',''9253'',''9254'',''9255'',''9299'',''9301'',''9302'',''9303'',''9349'',''9351'',''9352'',''9353'',''9354'',''9355'',''9356'',''9399'',''9401'',''9402'',''9403'',''9405'',''9449'',''9501'',''9549''
    ,''9651'',''9653'',''9699'',''9701'',''9749'',''9801'',''0821'',''0832'',''0836'',''0837'',''0839'',''0845'',''0846'',''0847'',''0848'',''0859'',''0911'',''0912'',''0913'',''0914'',''0915'',''0916'',''0917'',''0918'',''0961'',''0962'',''0963''
    ,''0964'',''0965'',''0966'',''0967'',''0968'') OR (MA_TIEUMUC IN(''0052'') AND MA_TKTN LIKE ''1717'') OR (MA_TKTN LIKE ''36%'')) 
                AND NGAY_HIEU_LUC >= TO_DATE ('''|| to_char(TUNGAY_HL,'ddMMyyyy') ||''', ''ddMMyyyy'')
                     AND NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                     and NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'') 
                     and NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')'||P_SQL_INSERT||' 
                     GROUP BY MA_CAP,  MA_NHOM, TEN_NHOM, MA_TIEUNHOM, TEN_TIEUNHOM, MA_MUC, TEN_MUC, MA_TIEUMUC, TEN_TIEUMUC, MA_TKTN)
                     PIVOT ( sum(PS) as PS
          FOR MA_CAP
          IN (''1'' AS TW, ''2'' AS TINH, ''3'' AS HUYEN, ''4'' AS XA)
          )
          
          UNION ALL
          
          SELECT  MA_NHOM, TEN_NHOM, MA_TIEUNHOM, TEN_TIEUNHOM, MA_MUC, TEN_MUC, MA_TIEUMUC, TEN_TIEUMUC ,TW_PS,TINH_PS, HUYEN_PS,XA_PS FROM 
    (SELECT MA_CAP, 
     (CASE WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'')  THEN TO_CHAR(''CCCC'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_TIEUNHOM)
    END) AS MA_NHOM
    , (CASE 
    WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'') THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.TEN_NHOM)
    END) AS TEN_NHOM
    , (CASE WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'')  THEN TO_CHAR(''CCCC'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_TIEUNHOM)
    END) AS MA_TIEUNHOM
    , (CASE WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'')  THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.TEN_TIEUNHOM)
    END) AS TEN_TIEUNHOM
    , (CASE WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'')  THEN TO_CHAR(''CCCC'')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_TIEUNHOM)
    END) AS MA_MUC
    ,(CASE WHEN (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'') THEN TO_CHAR(''Trả tiền vay đầu tư '')
    ELSE TO_CHAR(PHA_HACHTOAN_CHI.MA_MUC)
    END) AS TEN_MUC
    , MA_TIEUMUC, TEN_TIEUMUC, SUM(GIA_TRI_HACH_TOAN) AS PS, MA_TKTN 
    FROM PHA_HACHTOAN_CHI WHERE 1=1 '||' AND (MA_TKTN LIKE ''36%'' AND MA_TIEUMUC LIKE ''0839'')
                AND NGAY_HIEU_LUC >= TO_DATE ('''|| to_char(TUNGAY_HL,'ddMMyyyy') ||''', ''ddMMyyyy'')
                     AND NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                     and NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'') 
                     and NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                     GROUP BY MA_CAP,  MA_NHOM, TEN_NHOM, MA_TIEUNHOM, TEN_TIEUNHOM, MA_MUC, TEN_MUC, MA_TIEUMUC, TEN_TIEUMUC, MA_TKTN)
                     PIVOT ( sum(PS) as PS
          FOR MA_CAP
          IN (''1'' AS TW, ''2'' AS TINH, ''3'' AS HUYEN, ''4'' AS XA)
          )
          ORDER BY MA_NHOM ';
DBMS_OUTPUT.ENABLE (buffer_size => NULL);
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
END PHA_B5_BAO_CAO_TONG_HOP_CHI;