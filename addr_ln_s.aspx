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
            aPop = new Array(['txtStraddr', 'lblStraddr', 'addr2', 'noa,addr', 'txtStraddr,txtStraddr', 'addr2_b.aspx']
            	,['txtEndaddr', 'lblEndaddr', 'addr2', 'noa,addr', 'txtEndaddr,txtEndaddr', 'addr2_b.aspx']);
            var q_name = "addr_s";

            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
                $('#txtNoa').focus();
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_addr = $.trim($('#txtAddr').val());
                t_straddr = $.trim($('#txtStraddr').val());
                t_endaddr = $.trim($('#txtEndaddr').val());
				t_memo = $.trim($('#txtMemo').val());
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa);
            	if (t_addr.length > 0)
                    t_where += " and charindex(N'" + t_addr + "',addr)>0";
                if (t_straddr.length > 0)
                    t_where += " and charindex(N'" + t_straddr + "',straddr)>0";
                if (t_endaddr.length > 0)
                    t_where += " and charindex(N'" + t_endaddr + "',endaddr)>0";
                if (t_memo.length > 0){
                	t_where += " and (charindex('" + t_memo + "',memo)>0"
                		+" or exists(select noq from addrs where addrs.noa=addr.noa and  (charindex('" + t_memo + "',addrs.memo)>0)))";
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>科目</a></td>
					<td>
					<input class="txt" id="txtAddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStraddr'></a></td>
					<td>
					<input class="txt" id="txtStraddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEndaddr'></a></td>
					<td>
					<input class="txt" id="txtEndaddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMemo'>備註</a></td>
                    <td>
                    <input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
