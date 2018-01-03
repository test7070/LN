<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            aPop = new Array();
            var q_name = "tran_ln3_s";

            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtNoa').focus();
                
                $.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker();
            }

            function q_seekStr() {
            	t_bdate = $.trim($('#txtBdate').val());
            	t_edate = $.trim($('#txtEdate').val());
            	t_noa = $.trim($('#txtNoa').val());
            	t_v01 = $.trim($('#txtV01').val());
            	t_voyage = $.trim($('#txtVoyage').val());
            	t_caseno = $.trim($('#txtCaseno').val());
            	t_accno = $.trim($('#txtAccno').val());
            	t_ordeno = $.trim($('#txtOrdeno').val());
            			
				var t_where = " 1=1 and vccno='tran_ln3'" 
					+ q_sqlPara2("noa", t_noa)
					+ q_sqlPara2("datea", t_bdate,t_edate);;
                if(t_v01.length > 0)
                	t_where += " and charindex('" + t_v01 + "',v01)>0";
                if(t_voyage.length > 0)
                	t_where += " and (charindex('" + t_voyage + "',v03)>0 or charindex('" + t_voyage + "',v04)>0 or charindex('" + t_voyage + "',v05)>0)";
                if(t_caseno.length > 0){
                	t_where += " and exists(select noq from borrs where borrs.noa=borr.noa and  (charindex('" + t_caseno + "',borrs.caseno)>0))";
                }   
                if (t_accno.length > 0)
                    t_where += " and charindex('" + t_accno + "',accno)>0";
                if (t_ordeno.length > 0)
                    t_where += " and charindex('" + t_ordeno + "',ordeno)>0";      
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;"><a id='lblDate'>進出站時間</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:90px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblV01'>PLAN_ID</a></td>
					<td><input class="txt" id="txtV01" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblVoyage'>航次</a></td>
					<td><input class="txt" id="txtVoyage" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCaseno'>櫃號</a></td>
					<td><input class="txt" id="txtCaseno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>發票號碼</a></td>
					<td><input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>派工單號</a></td>
					<td><input class="txt" id="txtOrdeno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
