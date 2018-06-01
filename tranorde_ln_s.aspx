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
            var q_name = "tranorde_ln_s";

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
            	/*t_bdate1 = $.trim($('#txtBdate1').val());
            	t_edate1 = $.trim($('#txtEdate1').val());*/
            	
            	t_noa = $.trim($('#txtNoa').val());
            	t_contract = $.trim($('#txtContract').val());
            	t_boatname = $.trim($('#txtBoatname').val());
            	t_ship = $.trim($('#txtShip').val());
            	t_containerno1 = $.trim($('#txtContainerno1').val());
            			
				var t_where = " 1=1 " 
					+ q_sqlPara2("noa", t_noa)
					+ q_sqlPara2("datea", t_bdate,t_edate);
                if(t_contract.length > 0)
                	t_where += " and charindex('" + t_contract + "',contract)>0";
                if(t_boatname.length > 0)
                	t_where += " and charindex('" + t_boatname + "',boatname)>0";
            	if(t_ship.length > 0)
                	t_where += " and charindex('" + t_ship + "',ship)>0";
                if(t_containerno1.length > 0){
                	t_where += " and exists(select noq from view_tranordet"+r_accy+" where view_tranordet"+r_accy+".noa=view_tranorde"+r_accy+".noa and  (charindex('" + t_containerno1+ "',view_tranordet"+r_accy+".containerno1)>0))";
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
					<td style="width:35%;"><a id='lblDate'>日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:90px; font-size:medium;" />
					</td>
				</tr>
				<!--<tr class='seek_tr'>
					<td style="width:35%;"><a id='lblDate1'>作業日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate1" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate1" type="text" style="width:90px; font-size:medium;" />
					</td>
				</tr>-->
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblContract'>PLAN_ID</a></td>
					<td><input class="txt" id="txtContract" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBoatname'>船名</a></td>
					<td><input class="txt" id="txtBoatname" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblShip'>代表航次</a></td>
					<td><input class="txt" id="txtShip" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>櫃號</a></td>
					<td><input class="txt" id="txtContainerno1" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
