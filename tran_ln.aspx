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
			//萬海船邊
			q_tables = 's';
			var q_name = "borr";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'
				,'textA01','textA02','textA03','textA04','textA05','textA06','textA07'
				,'textA08','textA09','textA10','textA11','textA12','textA13','textA14'
				,'textA15','textA16','textA17','textA18','textA19','textA20','textA21'
				,'textA22','textA23'];
			var q_readonlys = ['txtN15'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = [];
			var bbsNum = new Array(['txtN01',10,0],['txtN02',10,0]
				,['txtN03',10,0],['txtN04',10,0],['txtN05',10,0],['txtN06',10,0]
				,['txtN07',10,0],['txtN08',10,0],['txtN09',10,0],['txtN10',10,0]
				,['txtN11',10,0],['txtN12',10,0],['txtN13',10,0],['txtN14',10,0],['txtN15',10,0]
				,['txtInteis',10,0],['txtArrerage',10,0]
				,['txtN16',10,0],['txtN17',10,0],['txtN18',10,0],['txtN19',10,0],['txtN20',10,0]);
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
			q_bbsLen = 10;
			aPop = new Array(['txtAddrno_', 'btnAddr_', 'addr2', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr2_b.aspx']
				,['txtAddrno2_', 'btnAddr2_', 'addr2', 'noa,addr', 'txtAddrno2_,txtAddr2_', 'addr2_b.aspx']
				,['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx']
				,['txtPartno', 'lblPart2', 'cust', 'noa,nick', 'txtPartno,txtPart', 'cust_b.aspx']
				,['txtCardealno_', 'btnCardeal_', 'cardeal', 'noa,nick', 'txtCardealno_,txtCardeal_', 'cardeal_b.aspx']);

			var _status = {bbs:[]};	
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
			}
			//q_bbsShow = -1;
            //q_bbsShowTxt = ['txtCardeal', 'txtCardealno','txtInteis','txtArrerage'];
            
			$(document).ready(function() {
				$.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				
				try{
					t_para = JSON.parse(q_getId()[3]);
					if(t_para.noa!=undefined){
                       q_content = "where=^^ noa='"+t_para.noa+"' and vccno='tran_ln' ^^"; 
                    }else if(t_para.v01!=undefined){
                       q_content = "where=^^ v01='"+t_para.v01+"' and vccno='tran_ln' ^^"; 
                    }
                    
				}catch(e){
					q_content = "where=^^ vccno='tran_ln'^^";
				}
				
				/*if(q_getId()[3].length>0){
					q_content = "where=^^ vccno='tran_ln' and "+q_getId()[3]+"^^";	
				}else{
					q_content = "where=^^ vccno='tran_ln'^^";	
				}*/
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
				bbmMask = new Array(['txtDatea', r_picd],['txtBegindate', r_picd],['txtEnddate',r_picd],['txtV09',r_picd],['txtV10',r_picd],['txtCheckno',r_picd]);
				q_mask(bbmMask);
				document.title = '船邊移櫃作業';
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
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr_'+n).click();
                    });
                    $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr2_'+n).click();
                    });
                    
                    $('#txtN01_'+i).change(function(e){refreshBbs();});
                    $('#txtN02_'+i).change(function(e){refreshBbs();});
                    $('#txtN03_'+i).change(function(e){refreshBbs();});
                    $('#txtN04_'+i).change(function(e){refreshBbs();});
                    $('#txtN05_'+i).change(function(e){refreshBbs();});
                    $('#txtN06_'+i).change(function(e){refreshBbs();});
                    $('#txtN07_'+i).change(function(e){refreshBbs();});
                    $('#txtN08_'+i).change(function(e){refreshBbs();});
                    $('#txtN09_'+i).change(function(e){refreshBbs();});
                    $('#txtN10_'+i).change(function(e){refreshBbs();});
                    $('#txtN11_'+i).change(function(e){refreshBbs();});
                    $('#txtN12_'+i).change(function(e){refreshBbs();});
                    $('#txtN13_'+i).change(function(e){refreshBbs();});
                    $('#txtN14_'+i).change(function(e){refreshBbs();});
                    $('#txtInteis_'+i).change(function(e){refreshBbs();});
                    $('#txtArrerage_'+i).change(function(e){refreshBbs();});
                    $('#txtN16_'+i).change(function(e){refreshBbs();});
                    $('#txtN17_'+i).change(function(e){refreshBbs();});
                    $('#txtN18_'+i).change(function(e){refreshBbs();});
                    $('#txtN19_'+i).change(function(e){refreshBbs();});
                    $('#txtN20_'+i).change(function(e){refreshBbs();});
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
				if (!as['typea']) {
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
				q_box('tran_ln_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtVccno').val('tran_ln');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				_status['bbs'] = new Array();
				for(var i=0;i<q_bbsCount;i++){
					_status['bbs'].push(true);
				}
			}

			function btnPrint() {
				/*q_box('z_trans_ln.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'tran_ln'
		                    ,noa : trim($('#txtNoa').val())
		                    ,workno : trim($('#txtV01').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);*/
               q_box('z_tran_ln5.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'tran_ln5'
		                    ,noa : trim($('#txtNoa').val())
		                    ,workno : trim($('#txtWorker').val())
		                }) + ";" + r_accy + "_" + r_cno, 'tran_ln', "95%", "95%", m_print);
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			function btnOk() {
				Lock(1,{opacity:0.5});
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
				var t_date = trim($('#txtDatea').val());
				t_date = t_date.length == 0 ? q_date() : t_date;
				t_date = t_date.replace(/(\d+)\/(\d+)\/\d+/,'$1$2');
				
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, 'S' + t_date);
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
			}
			
			function refreshBbs(){
				var t01=0,t02=0,t03=0,t04=0,t05=0,t06=0,t07=0
					,t08=0,t09=0,t10=0,t11=0,t12=0,t13=0,t14=0
					,t15=0,t16=0,t17=0,t18=0,t19=0,t20=0,t21=0
					,t22=0,t23=0;
				
				
				for(var i=0;i<q_bbsCount;i++){
					t01 += q_float('txtN01_'+i);
					t02 += q_float('txtN02_'+i);
					t03 += q_float('txtN03_'+i);
					t04 += q_float('txtN04_'+i);
					t05 += q_float('txtN05_'+i);
					t06 += q_float('txtN06_'+i);
					t07 += q_float('txtN07_'+i);
					t08 += q_float('txtN08_'+i);
					t09 += q_float('txtN09_'+i);
					t10 += q_float('txtN10_'+i);
					t11 += q_float('txtN11_'+i);
					t12 += q_float('txtN12_'+i);
					t13 += q_float('txtN13_'+i);
					t14 += q_float('txtN14_'+i);
					t = q_float('txtN01_'+i)+q_float('txtN02_'+i)+q_float('txtN03_'+i)
						+q_float('txtN04_'+i)+q_float('txtN05_'+i)+q_float('txtN06_'+i)
						+q_float('txtN07_'+i)+q_float('txtN08_'+i)+q_float('txtN09_'+i)
						+q_float('txtN10_'+i)+q_float('txtN11_'+i)+q_float('txtN12_'+i)
						+q_float('txtN13_'+i)+q_float('txtN14_'+i);
					t15 += t;
					$('#txtN15_'+i).val(t);
					t16 += q_float('txtInteis_'+i);
					t17 += q_float('txtArrerage_'+i);
					t18 += q_float('txtN16_'+i);
					t19 += q_float('txtN17_'+i);
					t20 += q_float('txtN18_'+i);
					t21 += q_float('txtN19_'+i);
					t22 += q_float('txtN20_'+i);
					t23 += t + q_float('txtInteis_'+i) + q_float('txtArrerage_'+i)
						+q_float('txtN16_'+i)+q_float('txtN17_'+i)+q_float('txtN18_'+i)+q_float('txtN19_'+i)+q_float('txtN20_'+i);
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
				$('#textA15').val(t15);
				$('#textA16').val(t16);
				$('#textA17').val(t17);	
				$('#textA18').val(t18);	
				$('#textA19').val(t19);	
				$('#textA20').val(t20);	
				$('#textA21').val(t21);	
				$('#textA22').val(t22);	
				$('#textA23').val(t23);	
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtBegindate').datepicker('destroy');
					$('#txtEnddate').datepicker('destroy');
					$('#txtV09').datepicker('destroy');
					$('#txtV10').datepicker('destroy');
					$('#txtCheckno').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtBegindate').datepicker();
					$('#txtEnddate').datepicker();
					$('#txtV09').datepicker();
					$('#txtV10').datepicker();
					$('#txtCheckno').datepicker();
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
				width: 410px;
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
						<td align="center" style="width:120px; color:black;"><a>船隻編號</a></td>
						<td align="center" style="width:80px; color:black;"><a>M.V.</a></td>
						<td align="center" style="width:80px; color:black;"><a>VOY NO.</a></td>
						<td align="center" style="width:100px; color:black;"><a>WHARF NO</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='noa' style="text-align: center; display:none;">~noa</td>
						<td id='v01' style="text-align: center;">~v01</td>
						<td id='v02' style="text-align: center;">~v02</td>
						<td id='v03' style="text-align: center;">~v03</td>
						<td id='v06' style="text-align: center;">~v06</td>
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
						<td>
							<a style="float:left;">結</a>
							<input type="checkbox" id="chkEnda" style="float:left;">
							<span> </span><a class="lbl">船隻編號</a>
						</td>
						<td><input type="text" id="txtV01" class="txt c1"/></td>
						<td><span> </span><a class="lbl">作業日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1" title="作業日期"/></td>
						<!--<td><span> </span><a class="lbl">PLAN_ID</a></td>
						<td><input type="text" id="txtV08" class="txt c1"/></td>-->
						<td><span> </span><a class="lbl">發票號碼</a></td>
						<td><input type="text" id="txtAccno" class="txt c1"/></td>
					</tr>
					<tr>
						<!--<td><span> </span><a class="lbl" id="lblSales">車行</a></td>
						<td>
							<input type="text" id="txtSalesno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtSales" class="txt" style="float:left;width:60%;"/>
						</td>-->
						<td><span> </span><a class="lbl" id="lblCust">客戶</a></td>
						<td>
							<input type="text" id="txtCustno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtCust" class="txt" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a class="lbl" id="lblPart2">貨主</a></td>
						<td>
							<input type="text" id="txtPartno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtPart" class="txt" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a class="lbl">發票日期</a></td>
						<td><input type="text" id="txtCheckno" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">M. V.</a></td>
						<td><input type="text" id="txtV02" class="txt c1" title="船名"/></td>
						<td><span> </span><a class="lbl">VOY NO.</a></td>
						<td><input type="text" id="txtV03" class="txt c1" title="航次"/></td>
						<td><span> </span><a class="lbl">PORT.</a></td>
						<td><input type="text" id="txtV04" class="txt c1"/ title="靠泊碼頭"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">ARRIVAL</a></td>
						<td><input type="text" id="txtBegindate" class="txt c1"/></td>
						<td><span> </span><a class="lbl">BERTHED</a></td>
						<td><input type="text" id="txtV05" class="txt c1"/></td>
						<td><span> </span><a class="lbl">WHARF NO</a></td>
						<td><input type="text" id="txtV06" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">DEPARTURE</a></td>
						<td><input type="text" id="txtEnddate" class="txt c1"/></td>
						<td colspan="2"><span> </span><a class="lbl">ETA AT NEXT PORT</a></td>
						<td colspan="2"><input type="text" id="txtV07" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">派車日期</a></td>
						<td><input type="text" id="txtV09" class="txt c1"/></td>
						<td><span> </span><a class="lbl">完工日期</a></td>
						<td><input type="text" id="txtV10" class="txt c1"/></td>
						<td><span> </span><a class="lbl">完工編號</a></td>
						<td><input type="text" id="txtV11" class="txt c1"/></td>
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
						<td>
							<input type="text" id="txtNoa" class="txt c1"/>
							<input type="text" id="txtVccno" style="display:none;"/>
						</td>
					</tr>
				</table>
			</div>
			<img id="img" crossorigin="anonymous" style="float:left;display:none;"/> 
		</div>
		<div style="width: 2120px;">
			<table>
				<tr style='color:white; background:#003366;' > 				
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><a style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><a>GCNO</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:100px;"><a>車行</a></td>
					<td align="center" colspan="4" rowspan="1"><a>LADEN</a></td>
					<td align="center" colspan="4" rowspan="1"><a>EMPTY</a></td>
					<td align="center" colspan="2" rowspan="2"><a>IN<BR>HATCH<BR>SHIFT</a></td>
					<td align="center" colspan="2" rowspan="2"><a>SHIFT</a></td>
					<td align="center" colspan="2" rowspan="2"><a>RELOAD</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:50px;"><a>小計</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>超高<BR>吊架</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>鐳仔桶</a></td>
					<td align="center" colspan="2" rowspan="2"><a>其他</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>補洞</a></td>
					<td align="center" colspan="2" rowspan="2"><a>OOG</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:200px;"><a>備註</a></td>
				</tr>
				<tr style='color:white; background:#003366;' > 	
					<!--  -->
					<!--  -->
					<!-- 車行 -->
					<!-- BAY NO. -->
					<td align="center" colspan="2" rowspan="1"><a>DIS</a></td>
					<td align="center" colspan="2" rowspan="1"><a>LOAD</a></td>
					<td align="center" colspan="2" rowspan="1"><a>DIS</a></td>
					<td align="center" colspan="2" rowspan="1"><a>LOAD</a></td>
					<!-- IN HATCH SHIFT -->
					<!-- SHIFT -->
					<!-- RELOAD -->
					<!-- 小計 -->
					<!-- TIME -->
					<!--  -->
					<!--  -->
					<!-- CASENO -->
					<!-- CASETYPE -->
					<!-- MEMO -->
				</tr>
				<tr style='color:white; background:#003366;' > 	
					<!--  -->
					<!--  -->
					<!-- 車行 -->
					<!-- BAY NO. -->
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="F">20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="F">40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="E">20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="E">40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="E">20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="E">40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="F">20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a title="F">40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>40'</a></td>
					<!--  -->
					<!--  -->
					<!--  -->
					<!--  -->
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>40'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>20'</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>40'</a></td>
					<!-- MEMO -->
				</tr>
			</table>
		</div>
		<div style="width: 2120px;">
			<table>
				<tr style='color:white; background:#003366;' > 	
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>TOTAL</a></td>
					
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA01" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA02" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA03" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA04" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA05" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA06" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA07" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA08" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA09" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA10" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA11" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA12" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA13" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA14" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA15" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA16" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA17" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA18" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA19" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA20" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA21" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><input id="textA22" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><input id="textA23" class="txt" style="width:95%;text-align:right;"/></td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 2120px;">
			<table id="tbbs" class='tbbs'>
				<tr style="color:white; background:#003366;display:none;" >
					<td align="center" style="width:50px;"> </td>
					<td align="center" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a> </a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a> </a></td>
					
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
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a> </a></td>
					<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>超高<BR>吊架</a></td>
					<td align="center" colspan="1" rowspan="3" style="width:60px;"><a>鐳仔桶</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>20'</a></td><!--其他-->
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>40'</a></td><!--其他-->
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>補洞</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>20'</a></td><!--OOG-->
					<td align="center" colspan="1" rowspan="1" style="width:60px;"><a>40'</a></td><!--OOG-->
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>MEMO</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center" style="width:50px">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td style="width:50px"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td style="width:50px"><input type="text" id="txtTypea.*" style="width:95%"/></td>
					<td style="width:100px">
						<input type="text" id="txtCardealno.*" style="float:left;width:35%;"/>
						<input type="text" id="txtCardeal.*" style="float:left;width:55%;"/>
						<input type="button" id="btnCardeal.*" style="display:none;"/>
					</td>
					
					<td style="width:50px;"><input type="text" id="txtN01.*" style="width:95%;text-align: right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN02.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN03.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN04.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN05.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN06.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN07.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN08.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN09.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN10.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN11.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN12.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN13.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN14.*" style="width:95%;text-align:right;"/></td>
					<td style="width:50px;"><input type="text" id="txtN15.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtInteis.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtArrerage.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtN16.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtN17.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtN18.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtN19.*" style="width:95%;text-align:right;"/></td>
					<td style="width:60px;"><input type="text" id="txtN20.*" style="width:95%;text-align:right;"/></td>
					<td style="width:200px;"><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
	</body>
</html>
