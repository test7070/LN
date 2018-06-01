<!-- 船邊移櫃 -->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "tran_ln",
                t_content = "where=^^['','')^^",
                bbsKey = ['noa'],
                as;
            var isBott = false;
            var txtfield = [],
                afield,
                t_data,
                t_htm,
                t_bbsTag = 'tbbs';
            brwCount = -1;
            brwCount2 = -1;
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
                try {
                    t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
                    t_content = "where=^^['"+t_para.bdate+"','"+t_para.edate+"')^^";
                } catch(e) {
                }
                brwCount = -1;
                mainBrow(0, t_content);
            }

            function mainPost() {
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();

               /* $('#checkAllCheckbox').click(function(e) {
                    $('.ccheck').prop('checked', $(this).prop('checked'));
                });*/
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                case q_name:
                    abbs = _q_appendData(q_name, "", true);
                    refresh();
                    break;
                }
            }

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:30px;"><!--<input type="checkbox" id="checkAllCheckbox"/>--></th>
					<td align="center" style="width:80px;">船隻編號</td>
					<td align="center" style="width:80px;">作業日期</td>
					<td align="center" style="width:80px;">客戶名稱</td>
					<td align="center" style="width:80px;">貨主</td>
					<td align="center" style="width:80px;">M.V.</td>
					<td align="center" style="width:80px;">VOY NO.</td>
					<td align="center" style="width:80px;">PORT.</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:30px;"> </th>
					<td align="center" style="width:80px;">船隻編號</td>
					<td align="center" style="width:80px;">作業日期</td>
					<td align="center" style="width:80px;">客戶名稱</td>
					<td align="center" style="width:80px;">貨主</td>
					<td align="center" style="width:80px;">M.V.</td>
					<td align="center" style="width:80px;">VOY NO.</td>
					<td align="center" style="width:80px;">PORT.</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:30px;">
					<input type="radio" class="ccheck" id="chkSel.*"/>
						<input id="txtNoa.*" type="text" style="display:none;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--船隻編號-->
						<input id="txtV01.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--作業日期-->
						<input id="txtDatea.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--客戶名稱-->
						<input id="txtCust.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--貨主-->
						<input id="txtPart.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--M.V.-->
						<input id="txtV02.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--VOY NO.-->
						<input id="txtV03.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td align="center" style="width:80px;"><!--PORT.-->
						<input id="txtV04.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

