using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Configuration;

namespace AuToSQLCode
{
    public partial class Index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod()]
        public static string LayCSDL(string csdl) {
            using (SqlConnection con = new SqlConnection(csdl))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(new SqlCommand(@"SELECT name FROM master.dbo.sysdatabases WHERE name NOT IN ('master','model','msdb','tempdb')", con));
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();
                    return JsonConvert.SerializeObject(dt, Formatting.Indented);
                }
                catch (Exception)
                {
                    return null;
                }   
            }
        }
        
        [WebMethod()]
        public static string LayBangTuCSDL(string csdl, string kn)
        {
            using (SqlConnection con = new SqlConnection(kn))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(new SqlCommand(@"use " + csdl + ";SELECT TABLE_NAME as name FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';", con));
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();
                    return JsonConvert.SerializeObject(dt, Formatting.Indented);
                }
                catch (Exception)
                {
                    return null;
                }   
            }
        }

        [WebMethod()]
        public static string LayCotTuBang(object[] csdl, string kn)
        {
            using (SqlConnection con = new SqlConnection(kn))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(new SqlCommand(@"
                    USE " + csdl[0].ToString() + @";
                    SELECT 
	                    TenCot = COLUMN_NAME,
	                    Kieu = (CASE
				                    WHEN 
					                     LOWER(DATA_TYPE)='uniqueidentifier' OR 
					                     LOWER(DATA_TYPE)='int' OR 
					                     LOWER(DATA_TYPE)='bit' 
						                    THEN DATA_TYPE 
				                    WHEN 
					                     LOWER(DATA_TYPE)='char' OR 
				                         LOWER(DATA_TYPE)='nchar' OR
					                     LOWER(DATA_TYPE)='binary'
						                    THEN DATA_TYPE+'('+CONVERT(NVARCHAR(50),CHARACTER_MAXIMUM_LENGTH)+')'
				                    WHEN 
					                     LOWER(DATA_TYPE)='nvarchar' OR 
					                     LOWER(DATA_TYPE)='varchar' THEN DATA_TYPE+'(MAX)'
				                    WHEN 
					                     LOWER(DATA_TYPE)='decimal' OR LOWER(DATA_TYPE)='numeric' THEN DATA_TYPE+'('+(SELECT CONVERT(NVARCHAR(10),i.NUMERIC_PRECISION) FROM INFORMATION_SCHEMA.COLUMNS i WHERE i.COLUMN_NAME = isc.COLUMN_NAME) + ',' + (SELECT CONVERT(NVARCHAR(10),k.NUMERIC_SCALE) FROM INFORMATION_SCHEMA.COLUMNS k WHERE k.COLUMN_NAME = isc.COLUMN_NAME) + ')'
				                    WHEN 
					                     LOWER(DATA_TYPE)='tinyint' OR 
					                     LOWER(DATA_TYPE)='xml' OR 
					                     LOWER(DATA_TYPE)='date' OR
					                     LOWER(DATA_TYPE)='timestamp' OR
					                     LOWER(DATA_TYPE)='text' OR
					                     LOWER(DATA_TYPE)='money' OR
					                     LOWER(DATA_TYPE)='float' OR
					                     LOWER(DATA_TYPE)='bigint' OR
                                         LOWER(DATA_TYPE)='datetime' OR
					                     LOWER(DATA_TYPE)='smalldatetime'
						                    THEN DATA_TYPE
			                    END),
                    KieuThuan = LOWER(DATA_TYPE)
                    FROM INFORMATION_SCHEMA.COLUMNS isc
                    WHERE TABLE_NAME = '" + csdl[1].ToString() + @"';
                    ", con));
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();
                    return JsonConvert.SerializeObject(dt, Formatting.Indented);
                }
                catch (Exception)
                {
                    return null;
                }
            }
        }
    }
}