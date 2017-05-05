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
			q_tables = 's';
			var q_name = "tran";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'
				,'textA01','textA02','textA03','textA04','textA05','textA06','textA07'
				,'textA08','textA09','textA10','textA11','textA12','textA13','textA14'];
			var q_readonlys = ['txtOrdeno','txtNo2'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = new Array(['txtDatea', '999/99/99'],['txtTrandate', '999/99/99'],['txtDeparture','999/99/99']);
			var bbsNum = new Array(['txtInmount',10,0],['txtOutmount',10,0]
				,['txtPton',10,0],['txtPton2',10,0],['txtPlus',10,0],['txtMinus',10,0]
				,['txtOverw',10,0],['txtOverh',10,0],['txtCommission',10,0],['txtCommission2',10,0]
				,['txtBmiles',10,0],['txtEmiles',10,0],['txtWeight2',10,0],['txtWeight3',10,0]);
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
			brwCount2 = 7;
			aPop = new Array(['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']);
	
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
			}
			
			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
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
				q_mask(bbmMask);
			}
            
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                    });
                    $('#txtEndaddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                    });
                    
                    $('#txtInmount_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtOutmount_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtPton_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtPton2_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtPlus_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtMinus_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtOverw_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtOverh_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtCommission_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtCommission2_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtBmiles_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtEmiles_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtWeight2_'+i).change(function(e){
                    	refreshBbs();
                    });
                    $('#txtWeight3_'+i).change(function(e){
                    	refreshBbs();
                    });
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
				if (!as['status']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['trandate'] = abbm2['trandate'];
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
				q_box('tran_ln_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
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
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}

			function btnOk() {
				/*$('#txtTrandate').val($.trim($('#txtTrandate').val()));
				if ($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())) {
                    alert(q_getMsg('lblTrandate') + '錯誤。');
                    Unlock(1);
                    return;
                }*/
                
				sum();
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtTrandate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
				var t01=0,t02=0,t03=0,t04=0,t05=0,t06=0,t07=0
					,t08=0,t09=0,t10=0,t11=0,t12=0,t13=0,t14=0;
				for(var i=0;i<q_bbsCount;i++){
					t01 += q_float('txtInmount_'+i);
					t02 += q_float('txtOutmount_'+i);
					t03 += q_float('txtPton_'+i);
					t04 += q_float('txtPton2_'+i);
					t05 += q_float('txtPlus_'+i);
					t06 += q_float('txtMinus_'+i);
					t07 += q_float('txtOverw_'+i);
					t08 += q_float('txtOverh_'+i);
					t09 += q_float('txtCommission_'+i);
					t10 += q_float('txtCommission2_'+i);
					t11 += q_float('txtBmiles_'+i);
					t12 += q_float('txtEmiles_'+i);
					t13 += q_float('txtWeight2_'+i);
					t14 += q_float('txtWeight3_'+i);
				}
				$('#textA01').val(t01);
				$('#textA02').val(t02);
				$('#textA03').val(t03);
				$('#textA04').val(t04);
				$('#textA05').val(t05);
				$('#textA06').val(t06);
				$('#textA07').val(t07);
				$('#textA08').val(t08);
				$('#textA09').val(t09);
				$('#textA10').val(t10);
				$('#textA11').val(t11);				
				$('#textA12').val(t12);
				$('#textA13').val(t13);
				$('#textA14').val(t14);	
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtTrandate').datepicker('destroy');
					$('#txtDeparture').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtTrandate').datepicker();
					$('#txtDeparture').datepicker();
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
					case 'txtProductno_':
						var n = b_seq;
						refreshWV(n);
						break;
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
				width: 800px;
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
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
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
						<td align="center" style="width:80px; color:black;"><a>M.V.</a></td>
						<td align="center" style="width:80px; color:black;"><a>VOY NO.</a></td>
						<td align="center" style="width:80px; color:black;"><a>ARRIVAL</a></td>
						<td align="center" style="width:80px; color:black;"><a>WHARF NO</a></td>
						<td align="center" style="width:80px; color:black;"><a>DEPARTURE</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='trandate' style="text-align: center;">~trandate</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='total' style="text-align: right;">~total</td>
						<td id='total3' style="text-align: right;">~total3</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">工作單號</a></td>
						<td><input type="text" id="txtWorkno" class="txt c1"/></td>
						<td><span> </span><a class="lbl">作業日期</a></td>
						<td><input type="text" id="txtTrandate" class="txt c1" title="作業日期"/></td>
					</tr>
					<tr style="display:none;"><!-- 由BBS的決定 -->
						<td><span> </span><a class="lbl">開工時間</a></td>
						<td><input type="text" id="txtBtime" class="txt c1"/></td>
						<td><span> </span><a class="lbl">完工時間</a></td>
						<td><input type="text" id="txtEtime" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">M. V.</a></td>
						<td><input type="text" id="txtVessel" class="txt c1" title="船名"/></td>
						<td><span> </span><a class="lbl">VOY NO.</a></td>
						<td><input type="text" id="txtVoyage" class="txt c1" title="航次"/></td>
						<td><span> </span><a class="lbl">PORT.</a></td>
						<td><input type="text" id="txtPort" class="txt c1"/ title="靠泊碼頭"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">ARRIVAL</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a class="lbl">BERTHED</a></td>
						<td><input type="text" id="txtBerthed" class="txt c1"/></td>
						<td><span> </span><a class="lbl">WHARF NO</a></td>
						<td><input type="text" id="txtAddr" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">DEPARTURE</a></td>
						<td><input type="text" id="txtDeparture" class="txt c1"/></td>
						<td colspan="2"><span> </span><a class="lbl">ETA AT NEXT PORT</a></td>
						<td colspan="2"><input type="text" id="txtPort2" class="txt c1"/></td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input type="text" id="txtNoa" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<img id="img" crossorigin="anonymous" style="float:left;display:none;"/> 
		</div>
		<div style="width: 1550px;">
			<table>
				<tr style='color:white; background:#003366;' > 				
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><a style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td align="center" colspan="1" rowspan="3" style="width:80px;"><a>BAY<BR>NO.</a></td>
					<td align="center" colspan="4" rowspan="1"><a>LADEN</a></td>
					<td align="center" colspan="4" rowspan="1"><a>EMPTY</a></td>
					<td align="center" colspan="2" rowspan="2"><a>IN<BR>HATCH<BR>SHIFT</a></td>
					<td align="center" colspan="2" rowspan="2"><a>SHIFT</a></td>
					<td align="center" colspan="2" rowspan="2"><a>RELOAD</a></td>
					<td align="center" colspan="2" rowspan="2"><a>TIME</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:200px;"><a>起迄點</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:200px;"><a>備註</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><a>請款</a></td>
				</tr>
				<tr style='color:white; background:#003366;' > 	
					<!--  -->
					<!--  -->
					<!-- BAY NO. -->
					<td align="center" colspan="2" rowspan="1"><a>DIS</a></td>
					<td align="center" colspan="2" rowspan="1"><a>LOAD</a></td>
					<td align="center" colspan="2" rowspan="1"><a>DIS</a></td>
					<td align="center" colspan="2" rowspan="1"><a>LOAD</a></td>
					<!-- IN HATCH SHIFT -->
					<!-- SHIFT -->
					<!-- RELOAD -->
					<!-- TIME -->
					<!-- ADDR -->
					<!-- MEMO -->
					<!-- CHK1 -->
				</tr>
				<tr style='color:white; background:#003366;' > 	
					<!--  -->
					<!--  -->
					<!-- BAY NO. -->
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>FROM</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>TO</a></td>
					<!-- ADDR -->
					<!-- MEMO -->
					<!-- CHK1 -->
				</tr>
			</table>
		</div>
		
		<div class='dbbs' style="width: 1550px;">
			<table id="tbbs" class='tbbs'>
				<tr style="color:white; background:#003366;display:none;" >
					<td align="center" style="width:50px"> </td>
					<td align="center" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a> </a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>FROM</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>TO</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a> </a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>MEMO</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a> </a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center" style="width:50px">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td style="width:50px"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td style="width:80px"><input type="text" id="txtStatus.*" style="width:95%;"/></td>
					<td style="width:50px;"><input type="text" id="txtInmount.*" style="width:95%;text-align: right;"/></td>
					<td style="width:50px;"><input type="text" id="txtOutmount.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtPton.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtPton2.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtPlus.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtMinus.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtOverw.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtOverh.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtCommission.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtCommission2.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtBmiles.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtEmiles.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtWeight2.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtWeight3.*" style="width:95%;text-align:right;"/></td>
					<td style="width:100px;"><input type="text" id="txtStime.*" style="width:95%;"/></td>
					<td style="width:100px;"><input type="text" id="txtDtime.*" style="width:95%;"/></td>
					<td style="width:200px">
						<input type="text" id="txtStraddrno.*" style="float:left;width:35%;"/>
						<input type="text" id="txtStraddr.*" style="float:left;width:55%;"/>
						<input type="button" id="btnStraddr" style="display:none;"/>
					</td>
					<td style="width:200px;"><input type="text" id="txtMemo.*" style="width:95%;"/></td>
					<td style="width:50px"><input type="checkbox" id="chkChk1.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<div style="width: 1550px;">
			<table>
				<tr style='color:white; background:#003366;' > 	
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>TOTAL</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA01" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA02" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA03" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA04" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA05" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA06" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA07" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA08" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA09" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA10" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA11" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA12" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA13" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA14" class="txt" style="width:95%;float:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
