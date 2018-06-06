<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			//萬海移櫃
			q_tables = 's';
			var q_name = "borr";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtOrdeno'
				,'textA01','textA02','textA03','textA04','textA05','textA06'];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = [];
			var bbsNum = new Array(['txtN01',10,0],['txtN02',10,0],['txtN03',10,0],['txtN04',10,0],['txtN05',10,0],['txtN06',10,0]);
			var bbsMask = new Array();
			var bbtNum  = new Array(); 
			var bbtMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			brwCount2 = 10;
			aPop = new Array(['txtAddrno_', 'btnAddr_', 'addr2', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr2_b.aspx']
				,['txtAddrno2_', 'btnAddr2_', 'addr2', 'noa,addr', 'txtAddrno2_,txtAddr2_', 'addr2_b.aspx']
				,['txtCardealno_', 'btnCardeal_', 'cardeal', 'noa,nick', 'txtCardealno_,txtCardeal_', 'cardeal_b.aspx']
				,['txtV02', 'btnBoat', 'boat', 'noa,boat,conn', 'txtV02', 'boat_b.aspx']
				,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtCustnick', 'cust_b.aspx']);
			
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
			}
			
			$(document).ready(function() {
				$.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				
				try{
					t_para = JSON.parse(q_getId()[3]);
					if(t_para.noa.length>0)
						q_content = "where=^^ noa='"+t_para.noa+"' and vccno='tran_ln3'^^";
				}catch(e){
					q_content = "where=^^ vccno='tran_ln3'^^";
				}
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = new Array(['txtDatea', r_picd],['txtBegindate', r_picd],['txtEnddate',r_picd],['txtCheckno',r_picd],['txtV14',r_picd]);
				q_mask(bbmMask);
				document.title = '場外移櫃作業';
				
				var item = " ,20'E,40'E,20'F,40'F";
                item += ",21-1,21-2,21-3,21-4,21-5,21-6,21-7,21-8";
                item += ",22-1,22-2,22-3,22-4,22-5,22-6,22-7,22-8";
                item += ",23-1,23-2,23-3,23-4,23-5,23-6,23-7,23-8";
                item += ",24-1,24-2,24-3,24-4,24-5,24-6,24-7,24-8";
                item += ",25-1,25-2,25-3,25-4,25-5,25-6,25-7,25-8";
                item += ",26-1,26-2,26-3,26-4,26-5,26-6,26-7,26-8";
                item += ",41-1,41-2,41-3,41-4,41-5,41-6,41-7,41-8";
                item += ",42-1,42-2,42-3,42-4,42-5,42-6,42-7,42-8";
                item += ",43-1,43-2,43-3,43-4,43-5,43-6,43-7,43-8";
                item += ",44-1,44-2,44-3,44-4,44-5,44-6,44-7,44-8";
                item += ",45-1,45-2,45-3,45-4,45-5,45-6,45-7,45-8";
                item += ",46-1,46-2,46-3,46-4,46-5,46-6,46-7,46-8";
                
				q_cmbParse("cmbCasetype", item,"s");
				
				$('#lblV02').click(function(e){
					q_box('boat.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + "" + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
				});
				$('#txtV02').bind('contextmenu', function(e) {
                    /*滑鼠右鍵*/
                    e.preventDefault();
                    $('#btnBoat').click();
                });	
				
			}
            
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#txtCardealno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCardeal_'+n).click();
                    });
                    $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        //20171019 按右鍵重新選擇
                        $(this).val('');
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr_'+n).click();
                    });
                    $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        //20171019 按右鍵重新選擇
                        $(this).val('');
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr2_'+n).click();
                    });
                    
                    $('#txtN01_'+i).change(function(e){refreshBbs();});
                    $('#txtN02_'+i).change(function(e){refreshBbs();});
                    $('#txtN03_'+i).change(function(e){refreshBbs();});
                    $('#txtN04_'+i).change(function(e){refreshBbs();});
                    $('#txtN05_'+i).change(function(e){refreshBbs();});
                    $('#txtN06_'+i).change(function(e){refreshBbs();});
				}
				_bbsAssign();
				$('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
				refreshBbs();
			}

			function bbsSave(as) {
				if (!as['addr']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}
			function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }

		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tran_ln3_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtVccno').val('tran_ln3');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box('z_trans_ln.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'tran_ln'
		                    ,noa : trim($('#txtNoa').val())
		                    ,planid : trim($('#txtV01').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}

			function btnOk() {
				if($.trim($('#txtDatea').val()).length==0){
					alert('請輸入日期');
					return;
				}
				refreshBbs();
				sum();
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val()).replace(/\//g,'');
				//t_date = t_date.length == 0 ? q_date() : t_date;
				//t_date = t_date.replace(/(\d+)\/(\d+)\/\d+/,'$1$2');
				
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, 'Y' + t_date);
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
			}
			
			function refreshBbs(){
				var t01=0,t02=0,t03=0,t04=0,t05=0,t06=0;
				for(var i=0;i<q_bbsCount;i++){
					//櫃型  casetype :  OOG的不要算,即 21-1、21-2.....都不算
					if($('#cmbCasetype_'+i).val().indexOf('-')<0)
						t01 += q_float('txtN01_'+i);
					t02 += q_float('txtN02_'+i);
					t03 += q_float('txtN03_'+i);
					t04 += q_float('txtN04_'+i);
					t05 += q_float('txtN05_'+i);
					t06 += q_float('txtN06_'+i);
				}
				$('#textA01').val(t01);
				$('#textA02').val(t02);
				$('#textA03').val(t03);
				$('#textA04').val(t04);
				$('#textA05').val(t05);
				$('#textA06').val(t06);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtBegindate').datepicker('destroy');
					$('#txtEnddate').datepicker('destroy');
					$('#txtCheckno').datepicker('destroy');
					$('#txtV14').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtBegindate').datepicker();
					$('#txtEnddate').datepicker();
					$('#txtCheckno').datepicker();
					$('#txtV14').datepicker();
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id){
					default:
						break;
				}
			}
			
		</script>
		
		<style type="text/css">
			#dmain {
				overflow: auto;
				width: 1600px;
			}
			.dview {
				float: left;
				width: 500px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 950px;
				/*margin: -1px;
				 border: 1px black solid;*/
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 12%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			
		</style>
	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a>電腦編號</a></td>
						<td align="center" style="width:100px; color:black;"><a>PLAN_ID</a></td>
						<td align="center" style="width:100px; color:black;"><a>進出站時間</a></td>
						<td align="center" style="width:100px; color:black;"><a>代表航次</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='v01' style="text-align: center;">~v01</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='v02' style="text-align: center;">~v02</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">PLAN_ID</a></td>
						<td><input type="text" id="txtV01" class="txt c1"/></td>
						<td><span> </span><a class="lbl">日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						
						<td><span> </span><a class="lbl">發票號碼</a></td>
						<td><input type="text" id="txtAccno" class="txt c1"/></td>
						<td><span> </span><a class="lbl">發票號碼#</a></td>
						<td><input type="text" id="txtV13" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">作業日期(起)</a></td>
						<td><input type="text" id="txtBegindate" class="txt c1"/></td>
						<td><span> </span><a class="lbl">作業日期(迄)</a></td>
						<td><input type="text" id="txtEnddate" class="txt c1"/></td>
						<td><span> </span><a class="lbl">發票日期</a></td>
						<td><input type="text" id="txtCheckno" class="txt c1"/></td>
						<td><span> </span><a class="lbl">發票日期#</a></td>
						<td><input type="text" id="txtV14" class="txt c1"/></td>
						
					</tr>
					<tr>
						<td><span> </span><a id="lblV02" class="lbl btn">船名</a></td>
						<td>
							<input type="text" id="txtV02" class="txt c1"/>
							<input type="button" id="btnBoat" style="display:none;" />
						</td>
						<td><span> </span><a class="lbl">代表航次</a></td>
						<td><input type="text" id="txtV03" class="txt c1"/></td>
						<td><span> </span><a class="lbl">買方發票統編</a></td>
						<td><input type="text" id="txtV10" class="txt c1"/></td>
						<td><span> </span><a class="lbl">買方發票統編#</a></td>
						<td><input type="text" id="txtV15" class="txt c1"/></td>
						
					</tr>
					<tr>
						<td><span> </span><a class="lbl" id="lblCust">客戶</a></td>
						<td colspan="2">
							<input type="text" id="txtCustno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtCust" class="txt" style="float:left;width:60%;"/>
							<input type="text" id="txtCustnick" class="txt" style="display:none;"/>
						</td>
						<td>
							<a class="lbl" style="float:right;">鎖單</a>
							<span> </span>
							<input id="chkIsnointe" type="checkbox" style="float:right;"/>
						</td>
						
						<td><span> </span><a class="lbl">賣方發票統編</a></td>
						<td><input type="text" id="txtV12" class="txt c1"/></td>
						<td><span> </span><a class="lbl">賣方發票統編#</a></td>
						<td><input type="text" id="txtV16" class="txt c1"/></td>
						<!--<td><span> </span><a class="lbl">發票金額</a></td>
						<td><input type="text" id="txtTotal2" class="txt c1 num"/></td>-->
						
					</tr>
					<!--<tr>
						<td><span> </span><a class="lbl">抵達碼頭航次</a></td>
						<td><input type="text" id="txtV04" class="txt c1"/></td>
						<td><span> </span><a class="lbl">離開碼頭航次</a></td>
						<td><input type="text" id="txtV05" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">進出站</a></td>
						<td><input type="text" id="txtV06" class="txt c1"/></td>
						<td><span> </span><a class="lbl">進出口別</a></td>
						<td><input type="text" id="txtV07" class="txt c1"/></td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2" class="lbl">備註(請款憑證)</a></td>
						<td colspan="5">
							<textarea id="txtMemo2" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input type="text" id="txtNoa" class="txt c1"/>
							<input type="text" id="txtVccno" style="display:none;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="width: 1700px;">
			<table>
				<tr style='color:white; background:#003366;' > 				
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<!--<td align="center" colspan="1" rowspan="3" style="width:50px;"><a>請款</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號</a></td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>E/F</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>櫃型</a></td>
					<!--<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>油桶櫃</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車牌</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車行</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>起點*</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>迄點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>數量</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>油桶櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>押運</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>超重</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>危標</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>其他</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div style="width: 1700px;">
			<table>
				<tr style='color:white; background:#003366;' > 	
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<!--<td align="center" colspan="1" rowspan="3" style="width:50px;"> </td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"> </td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>-->
					<td align="center" colspan="1" rowspan="1" style="width:80px;"> </td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:60px;"> </td>-->
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>TOTAL</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA01" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA02" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA03" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA04" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA05" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA06" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 1700px;">
			<table id="tbbs" class='tbbs'>
				<tr style="color:white; background:#003366;display:none;" >
					<td align="center" style="width:50px;"> </td>
					<td align="center" style="width:50px;"> </td>
					<!--<td align="center" colspan="1" rowspan="3" style="width:50px;"><a>請款</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號</a></td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>E/F</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>櫃型</a></td>
					<!--<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>油桶櫃</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車牌</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車行</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>起點*</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>迄點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>數量</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>油桶櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>押運</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>超重</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>危標</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>其他</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>備註</a></td>
				</tr>

				<tr class="data" style='background:#cad3ff;'>
					<td align="center" style="width:50px">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td style="width:50px"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<!--<td style="width:50px"><input type="checkbox" id="chkChk1.*" style="width:95%;"/></td>-->
					<td style="width:150px;"><input type="text" id="txtCaseno.*" style="width:95%;"/></td>
					<td style="width:80px;"><select id="cmbCasetype.*" style="width:95%;"> </select></td>
					<!--<td style="width:60px"><input type="checkbox" id="chkChk2.*" style="width:95%;"/></td>-->
					<td style="width:100px;"><input type="text" id="txtCarno.*" style="width:95%;"/></td>
					<td style="width:100px">
						<input type="text" id="txtCardealno.*" style="float:left;width:45%;"/>
						<input type="text" id="txtCardeal.*" style="float:left;width:45%;"/>
						<input type="button" id="btnCardeal.*" style="display:none;"/>
					</td>
					<td style="width:200px">
						<input type="text" id="txtAddrno.*" style="float:left;width:35%;"/>
						<input type="text" id="txtAddr.*" style="float:left;width:55%;"/>
						<input type="button" id="btnAddr.*" style="display:none;"/>
					</td>
					<td style="width:200px">
						<input type="text" id="txtAddrno2.*" style="float:left;width:35%;"/>
						<input type="text" id="txtAddr2.*" style="float:left;width:55%;"/>
						<input type="button" id="btnAddr2.*" style="display:none;"/>
					</td>
					<td style="width:50px;"><input type="text" id="txtN01.*" style="width:95%;text-align: right;"/></td>
					<td style="width:70px;"><input type="text" id="txtN02.*" style="width:95%;text-align: right;"/></td>
					<td style="width:70px;"><input type="text" id="txtN03.*" style="width:95%;text-align: right;"/></td>
					<td style="width:70px;"><input type="text" id="txtN04.*" style="width:95%;text-align: right;"/></td>
					<td style="width:70px;"><input type="text" id="txtN05.*" style="width:95%;text-align: right;"/></td>
					<td style="width:70px;"><input type="text" id="txtN06.*" style="width:95%;text-align: right;"/></td>
					<td style="width:200px;"><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
