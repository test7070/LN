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
            var q_name = "tran_ln2_s";

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
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker();
            }

            function q_seekStr() {
            	t_bdate = $('#txtBdate').val();
            	t_edate = $('#txtBdate').val();
                t_noa = $.trim($('#txtNoa').val());
                t_carno = $.trim($('#txtCarno').val());
                t_driverno = $.trim($('#txtDriverno').val());
				t_memo = $.trim($('#txtMemo').val());
				
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa)
                	+ q_sqlPara2("datea", t_bdate,t_edate);
                if (t_carno.length > 0)
                    t_where += " and charindex('" + t_carno + "',carno)>0";
                if (t_driverno.length > 0)
                    t_where += " and ( charindex('" + t_driverno + "',driverno)>0 or charindex('" + t_driverno + "',driver)>0)";
                if (t_memo.length > 0){
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
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;"><a id='lblDate'>日期</a></td>
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
					<td class='seek'  style="width:20%;"><a>車牌</a></td>
					<td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>司機</a></td>
					<td><input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>備註</a></td>
					<td><input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
