﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BTS.SP.API.ENTITY.Models.Bc.PHB.BIEU2CP1
{
    [Table("PHB_BIEU2CP1_DETAIL")]
    public class PHB_BIEU2CP1_DETAIL : DataInfoEntity
    {
        [Column("PHB_BIEU2CP1_REFID")]
        [Required]
        [Description("Guid ID trong  PHB_BIEU2CP1")]
        [StringLength(50)]
        public string PHB_BIEU2CP1_REFID { get; set; }

        [Column("MA_CHI_TIEU")]       
        [Description("Mã chỉ tiêu báo cáo")]
        [StringLength(15)]
        public string MA_CHI_TIEU { get; set; }        

        [Column("TEN_CHI_TIEU")]
        [Description("Tên chỉ tiêu báo cáo")]
        [StringLength(250)]
        public string TEN_CHI_TIEU { get; set; }

        [Column("STT_CHI_TIEU")]
        [Description("STT chỉ tiêu báo cáo")]
        [StringLength(15)]
        public string STT_CHI_TIEU { get; set; }

        [Column("SAP_XEP")]
        [Description("Sắp xếp")]
        [Required]
        public int SAP_XEP { get; set; }        

        [Column("MA_LOAI")]
        [StringLength(10)]
        public string MA_LOAI { get; set; }

        [Column("MA_KHOAN")]
        [StringLength(10)]
        public string MA_KHOAN { get; set; }

        [Column("GIA_TRI")]
        public decimal GIA_TRI { get; set; }
        
    }
}
