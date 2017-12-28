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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 't';
			var q_name = "tranorde";
			var q_readonly = ['txtNoa'];
			var q_readonlys = [];
			var bbsNum = [];
			var bbsMask = new Array();
			var bbtMask = new Array();
			var bbmNum = new Array();
			var bbmMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 10;
		/*	aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], 
			['txtComp', 'lblCust', 'cust', 'comp,noa,nick', '0txtComp,txtCustno,txtNick', 'cust_b.aspx'],
			['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],	
			['txtDeliveryno', 'lblDeliveryno', 'trando', 'deliveryno,po', 'txtDeliveryno,txtPo', 'trando_b.aspx'],
			['txtCasepackaddr', 'lblCasepackaddr', 'addrcase', 'addr,noa', 'txtCasepackaddr', 'addrcase_b.aspx'],
			['txtCaseopenaddr', 'lblCaseopenaddr', 'addrcase', 'addr,noa', 'txtCaseopenaddr', 'addrcase_b.aspx'], 
			['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
			['textAddrno1', 'btnAddr1', 'addr', 'noa,addr', 'textAddrno1,textAddr1', 'addr_b.aspx'],
			['textAddrno2', 'btnAddr2', 'addr', 'noa,addr', 'textAddrno2,textAddr2', 'addr_b.aspx'],
			['textAddrno3', 'btnAddr3', 'addr', 'noa,addr', 'textAddrno3,textAddr3', 'addr_b.aspx'],
			['textAddrno4', 'btnAddr4', 'addr', 'noa,addr', 'textAddrno4,textAddr4', 'addr_b.aspx'],
			['textAddrno5', 'btnAddr5', 'addr', 'noa,addr', 'textAddrno5,textAddr5', 'addr_b.aspx']);
		*/

			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
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

			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						break;
				}
			}

			function mainPost() {
				bbmMask = new Array(['txtDatea', r_picd], ['txtCldate', r_picd], ['txtDldate', r_picd]);
				
				q_mask(bbmMask);
				
				$('#btnFile').change(function(e){
					var files = e.target.files;
					for(var i = 0; i < files.length; i++){
                        file = files[i];
                        if(file){
                        	fr = new FileReader();
                            fr.readAsText(file,'BIG5');
                            //fr.readAsText(file,'ANSI');
                            fr.fileName = file.name;
                            fr.onload=function(e){
                            	var row = fr.result.split(/\r\n/);
                            	for(var i=0;i<q_bbtCount;i++){
                            		$('#btnMinut__'+i).click();
                            	}
                            	if(row.length>q_bbtCount){
                            		q_gridAddRow(bbtHtm, 'tbbt', 'txtNoq', row.length-q_bbtCount);
                            	}
                            	
								console.log(e.target.fileName);
								var n = 0;
								if(/本場/g.test(e.target.fileName)){
									for(var i=0;i<row.length;i++){
	                            		if(row[i].length == 0)
	                            			continue;
	                            		var column = row[i].split(',');
	                            		var date = new Date(Date.parse(column[4]));
	                            		//日期沒有問題才存入
	                            		if(!(date instanceof Date) || isNaN(date.getMonth()))
	                            			continue;
	                            		var yy = date.getFullYear()+"";
	                            		var mm = date.getMonth()+"";
	                            		var dd = date.getDate()+"";
	                            		mm = (mm.length==1?"0":"") + mm;
	                            		dd = (dd.length==1?"0":"") + dd;
	                            		var HH = date.getHours()+"";
	                            		var MM = date.getMinutes()+"";
	                            		var SS = date.getSeconds()+"";
	                            		HH = (HH.length==1?"0":"") + HH;
	                            		MM = (MM.length==1?"0":"") + MM;
	                            		SS = (SS.length==1?"0":"") + SS;
	                            		
	                            		$('#txtDatea__'+n).val(yy+'/'+mm+'/'+dd);
	                            		$('#txtTimea__'+n).val(HH+':'+MM+':'+SS);
	                            		$('#txtCasetype__'+n).val($.trim(column[5]));
	                            		$('#txtContainerno1__'+n).val($.trim(column[3]));
	                            		$('#txtMount__'+n).val($.trim(column[9]));
	                            		$('#txtStraddr__'+n).val($.trim(column[10]));
	                            		$('#txtEndaddr__'+n).val($.trim(column[11]));
	                            		$('#txtCardeal__'+n).val($.trim(column[13]));
	                            		$('#txtCarno__'+n).val($.trim(column[14]));
	                            		$('#txtMemo__'+n).val($.trim(column[2]));
	                            		n++;
	                            	}
								}else if(/外場/g.test(e.target.fileName)){
									for(var i=0;i<row.length;i++){
	                            		if(row[i].length == 0)
	                            			continue;
	                            		var column = row[i].split(',');
	                            		var date = new Date(Date.parse(column[2]));
	                            		//日期沒有問題才存入
	                            		if(!(date instanceof Date) || isNaN(date.getMonth()))
	                            			continue;
	                            		var yy = date.getFullYear()+"";
	                            		var mm = date.getMonth()+"";
	                            		var dd = date.getDate()+"";
	                            		mm = (mm.length==1?"0":"") + mm;
	                            		dd = (dd.length==1?"0":"") + dd;
	                            		var HH = date.getHours()+"";
	                            		var MM = date.getMinutes()+"";
	                            		var SS = date.getSeconds()+"";
	                            		HH = (HH.length==1?"0":"") + HH;
	                            		MM = (MM.length==1?"0":"") + MM;
	                            		SS = (SS.length==1?"0":"") + SS;
	                            		
	                            		$('#txtDatea__'+n).val(yy+'/'+mm+'/'+dd);
	                            		$('#txtTimea__'+n).val(HH+':'+MM+':'+SS);
	                            		$('#txtCasetype__'+n).val($.trim(column[1]));
	                            		$('#txtContainerno1__'+n).val($.trim(column[0]));
	                            		$('#txtStraddr__'+n).val($.trim(column[4]));
	                            		$('#txtEndaddr__'+n).val($.trim(column[5]));
	                            		$('#txtMemo__'+n).val($.trim(column[6]));
	                            		n++;
	                            	}
								}
                            	
                            	
                            	$('#btnFile').val('');
                            };
                        }
                   }
				});
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if ($('#btnMinus_' + i).hasClass('isAssign')) 
                    	continue;
				}
				_bbsAssign();
			}
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if ($('#btnMinut__' + i).hasClass('isAssign'))
                    	continue;
                    	/*$('#txtWeight__'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtTrannumber__'+i).change(function(e){
                    		sum();
                    	});*/
                    
                }
                _bbtAssign();
            }

			function bbsSave(as) {
				if (!as['containerno1']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_weight2 = 0,t_trannumber = 0;
				for(var i=0;i<q_bbtCount;i++){
					if($('#txtDatea__'+i).val().length>0){
						t_weight2 = q_add(t_weight2,q_float('txtWeight2__'+i));
						t_trannumber = q_add(t_trannumber,q_float('txtTrannumber__'+i));
					}
						
				}
				$('#txtTweight2').val(round(t_weight2,2));
				$('#txtTtrannumber').val(round(t_trannumber,2));	
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'trando3':
						var as = _q_appendData("trandos", "", true);
						q_gridAddRow(bbsHtm, 'tbbs', 'txtCaseno,txtTranno,txtTrannoq', as.length, as, 'caseno,tranno,trannoq', '', '');
						$('#btnDeliveryno').val("匯入櫃號 ");
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tranorde_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				for(var i=1;i<=5;i++){
					$('#textAddrno'+i).val('');
					$('#textAddr'+i).val('');
				}
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#chkEnda').prop('checked',false);
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_tranorde.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段)
				TranOrdetNextFields(0);
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段)
				if ($('#txtDldate').val().length == 0 && $('#txtCldate').val().length > 0)
					$('#txtDldate').val($('#txtCldate').val());
				if ($('#txtDldate').val().length == 0 && $('#txtMadate').val().length > 0)
					$('#txtDldate').val($('#txtMadate').val());
				if($('#txtNick').val().length==0)	
				   $('#txtNick').val($('#txtComp').val().substring(0,4)); 
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if (checkId($('#txtDatea').val()) == 0) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				$('#txtCaddr').val();
				var t_addr='',t_caddr = '',t_item,t_str;
				for(var i=1;i<=5;i++){
				    if($('#textAddr'+i).val().length>0){
                        t_addr += (t_addr.length>0?'<br>':'')+$('#textAddr'+i).val();
                    }
					if($.trim($('#textAddr'+i).val()).length==0){
						$('#textAddrno'+i).val('');
						$('#textAddr'+i).val('');
					}
					t_str = $.trim($('#textAddrno'+i).val());
					t_item = '';
					for(var j=0;j<t_str.length;j++){
						t_item += (t_item.length==0?'':' ') + t_str.substring(j,j+1).charCodeAt(0);
					}
					t_caddr += (i==1?'':',')+t_item;

					t_str = $.trim($('#textAddr'+i).val());
					t_item = '';
					for(var j=0;j<t_str.length;j++){
						t_item += (t_item.length==0?'':' ') + t_str.substring(j,j+1).charCodeAt(0);
					}
					t_caddr += ','+t_item;
				}
				$('#txtCaddr').val(t_caddr);
				$('#txtAddr').val(t_addr);
				sum();
				$('#txtTranordeta').val(SaveTranOrdetStr());
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
				if(q_cur!=1){
					for(var i=0;i<q_bbsCount;i++){
						$('#textAddrno'+i).val('');
						$('#textAddr'+i).val('');
					}
					//var t_caddr = $('#txtCaddr').val().split(',');
					if(abbm[recno]!=undefined){
						var t_caddr = abbm[recno].caddr.split(',');
						var t_item,t_str;
						for(var i=0;i<t_caddr.length;i++){
							t_item = t_caddr[i].split(' ');
							t_str='';
							for(var j=0;t_caddr[i].length>0 && j<t_item.length;j++){
								t_str+=String.fromCharCode(parseInt(t_item[j]));
							}
							if(i%2==0)
								$('#textAddrno'+(Math.floor(i/2)+1)).val(t_str);
							else
								$('#textAddr'+(Math.floor(i/2)+1)).val(t_str);
						}	
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur==1 || q_cur==2){
					$('#btnFile').removeAttr('disabled');
				}else{
					$('#btnFile').attr('disabled','disabled');
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

			function q_popPost(id) {
				switch(id){
					case 'txtCustno':
						var t_carno = $.trim($('#txtCustno').val());
						if(q_cur==1 && t_carno.length>0){
							for(var i=1;i<=5;i++)
								if($.trim($('#textAddr'+i).val()).length==0)
									$('#textAddrno'+i).val(t_carno+'-');
						}
						break;
				}
			}

		</script>
		<style type="text/css">
			#dmain {
				overflow: auto;
			}
			.dview {
				float: left;
				width: 400px;
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
			.tbbm .trX {
				background-color: #FFEC8B;
			}
			.tbbm .trY {
				background-color: pink;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
			.dbbs {
				width: 1200px;
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
			.font1 {
				font-family: "細明體", Arial, sans-serif;
			}
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCust'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td><input type="text" id="txtCaddr" style="display:none;"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtNoa" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDatea" class="txt c1"/>
						</td>
						<td>
						<input type="button" id="btnPrintorde" />
						</td>
						<td>
						<input type="button" id="btnPrinttrand" />
						</td>
						<td>
						<input type="checkbox" id="chkEnda">手動結案</input>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStrdate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtStrdate" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDldate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDldate" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCtype" class="lbl"> </a></td>
						<td>
						<select id="cmbCtype" class="txt c1"> </select>
						</td>
						<td><input type="button" id="btnUnpresent" value="未出車"/> </td>
						<td><input type="button" id="btnTransvcce" value="派車明細"/></td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
						<input type="text" id="txtMemo" class="txt c1"/>
						</td>
						<td><select id="combMemo" style="float:left;width:20px;"> </select><span> </span><a id="lblCancel" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCancel" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2" class="lbl"> </a></td>
						<td colspan="5">
							<textarea rows="5" id="txtMemo2" class="txt c1"> </textarea>
						</td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
							<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td>
							<input id="txtWorker2" type="text"  class="txt c1"/>
							<input id="txtTranordeta" type="hidden">
						</td>
					</tr>
					<tr>
						<td><input id="btnFile"  type="file" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div style="width: 1600px;">
			<table>
				<tr style='color:white; background:#003366;' > 				
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>櫃型</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車牌</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車行</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>起點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>迄點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>數量</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>油桶櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>押運</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>儀檢</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>DG</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><a>OOG</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div style="width: 1600px;">
			<table>
				<tr style='color:white; background:#003366;' > 	
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>TOTAL</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA01" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA02" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA03" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA04" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA05" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input id="textA06" class="txt" style="width:95%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 1600px;">
			<table id="tbbs" class='tbbs' >
				<tr style='display:none;' >
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="width:50px;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td style="width:50px;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><input type="text" id="txtContainerno1.*" style="width:95%;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><select id="cmbCasetype.*" style="width:95%;"> </select></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><input type="text" id="txtCarno.*" style="width:95%;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;">
						<input type="text" id="txtCardealno.*" style="float:left;width:45%;"/>
						<input type="text" id="txtCardeal.*" style="float:left;width:45%;"/>
						<input type="button" id="btnCardeal.*" style="display:none;"/>
					</td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;">
						<input type="text" id="txtAddrno.*" style="float:left;width:35%;"/>
						<input type="text" id="txtAddr.*" style="float:left;width:55%;"/>
						<input type="button" id="btnAddr.*" style="display:none;"/>
					</td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;">
						<input type="text" id="txtAddrno2.*" style="float:left;width:35%;"/>
						<input type="text" id="txtAddr2.*" style="float:left;width:55%;"/>
						<input type="button" id="btnAddr2.*" style="display:none;"/>
					</td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
				</tr>

			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="width:1100px;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:100px; text-align: center;">日期</td>
						<td style="width:100px; text-align: center;">時間</td>
						<td style="width:100px; text-align: center;">櫃型</td>
						<td style="width:130px; text-align: center;">櫃號</td>
						<td style="width:100px; text-align: center;">重量</td>
						<td style="width:100px; text-align: center;">起點</td>
						<td style="width:100px; text-align: center;">迄點</td>
						<td style="width:100px; text-align: center;">車行</td>
						<td style="width:100px; text-align: center;">車牌</td>
						<td style="width:100px; text-align: center;">備註</td>
					</tr>
					<tr class="detail">
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt" id="txtDatea..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtTimea..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtCasetype..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtContainerno1..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtStraddr..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtEndaddr..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtCardeal..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtCarno..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
