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
                bbmMask = [['txtDate', r_picd]];
                q_mask(bbmMask);
                $('#txtNoa').focus();
                
                $.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                $('#txtDate').datepicker();
            }

            function q_seekStr() {
            	t_date = $.trim($('#txtDate').val());
            	t_noa = $.trim($('#txtNoa').val());
            	t_v01 = $.trim($('#txtV01').val());
            	t_v02 = $.trim($('#txtV02').val());
            	t_v03 = $.trim($('#txtV03').val());
            	t_memo = $.trim($('#txtMemo').val());
            			
				var t_where = " 1=1 and vccno='Y'" + q_sqlPara2("noa", t_noa);
                
                if(t_date.length>0)
					t_where += " and ('" + t_date + "' between begindate and enddate)";                	
                if(t_v01.length > 0)
                	t_where += " and charindex('" + t_v01 + "',v01)>0";
                if(t_v02.length > 0)
                    t_where += " and charindex('" + t_v02 + "',v02)>0";
                if(t_v03.length > 0)
                    t_where += " and charindex('" + t_v03 + "',v03)>0";
                if(t_memo.length > 0){
                	t_where += " and (charindex('" + t_memo + "',memo)>0"
                		+" or exists(select noq from borrs where borrs.noa=borr.noa and  (charindex('" + t_memo + "',borrs.memo)>0)))";
                }    
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblV01'>PLAN_ID</a></td>
					<td><input class="txt" id="txtV01" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblV02'>船名</a></td>
					<td><input class="txt" id="txtV02" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblV03'>航次</a></td>
					<td><input class="txt" id="txtV03" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDate'>作業日期</a></td>
					<td><input class="txt" id="txtDate" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
