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
			//地點代碼對照
			var addr = [{org:'KHH00',name:'63號碼頭',cur:'KHH063'}
				,{org:'KHH01',name:'亞太櫃場',cur:'KHH01'}
				,{org:'KHH02',name:'友聯櫃場',cur:'KHH02'}
				,{org:'KHH03',name:'世新貨櫃',cur:'KHH03'}
				,{org:'KHH04',name:'東亞櫃場',cur:'KHH04'}
				,{org:'KHH06',name:'裕楓(原裕豐)',cur:'KHH06'}
				,{org:'KHH07',name:'海盛櫃場',cur:'KHH07'}
				,{org:'KHH08',name:'高鳳櫃場',cur:'KHH08'}
				,{org:'KHH09',name:'宇竑',cur:'KHH09'}
				,{org:'KHH10',name:'台豐櫃場',cur:'KHH10'}
				,{org:'KHH12',name:'76號碼頭',cur:'KHH076'}
				,{org:'KHH13',name:'79號碼頭',cur:'KHH079'}
				,{org:'KHH14',name:'65號碼頭',cur:'KHH065'}
				,{org:'KHH16',name:'三濮櫃場',cur:'KHH16'}
				,{org:'KHH19',name:'70號碼頭',cur:'KHH070'}
				,{org:'KHH20',name:'海吉櫃場',cur:'KHH20'}
				,{org:'KHH21',name:'116號碼頭',cur:'KHH116'}
				,{org:'KHH22',name:'121碼頭',cur:'KHH121'}
				,{org:'KHH23',name:'120號碼頭',cur:'KHH120'}
				,{org:'KHH25',name:'118號碼頭',cur:'KHH118'}
				,{org:'KHH30',name:'78號碼頭',cur:'KHH078'}
				,{org:'KHH31',name:'75號碼頭',cur:'KHH075'}
				,{org:'KHH36',name:'42號碼頭',cur:'KHH042'}
				,{org:'KHH37',name:'69號碼頭',cur:'KHH069'}
				,{org:'KHH39',name:'108號碼頭',cur:'KHH108'}
				,{org:'KSS72',name:'68號碼頭',cur:'KHH068'}];

			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 't';
			var q_name = "tranorde";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'
				,'textA01','textA02','textA03','textA04','textA05','textA06'];
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
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'] 
				,['txtAddrno_', 'btnAddr_', 'addr2', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr2_b.aspx']
				,['txtAddrno2_', 'btnAddr2_', 'addr2', 'noa,addr', 'txtAddrno2_,txtAddr2_', 'addr2_b.aspx']
				,['txtDriverno_', 'btnDriver_', 'cardeal', 'noa,nick', 'txtDriverno_,txtDriver_', 'cardeal_b.aspx']);

			$(document).ready(function() {
				$.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				
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
				document.title = '派工單';
				bbmMask = new Array(['txtDatea', r_picd],['txtDate1', r_picd],['txtDate2', r_picd]);
				bbtMask = new Array(['txtDatea', r_picd],['txtTimea', '99:99:99']);
				
				q_mask(bbmMask);
				q_cmbParse("cmbStype", " ,本場,外場");
				q_cmbParse("cmbCaseno", " ,20'E,40'E,20'F,40'F","s");
				
				$('#btnFile').change(function(e){
					var files = e.target.files;
					for(var i = 0; i < files.length; i++){
                        file = files[i];
                        if(file){
                        	fr = new FileReader();
                            fr.readAsText(file,'BIG5');
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
								$('#cmbStype').val('');
								var n = 0;
								//bbt
								if(/本場/g.test(e.target.fileName)){
									$('#cmbStype').val('本場');
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
									$('#cmbStype').val('外場');
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
	                            		var t_addr = $.trim(column[4]);
	                            		for(var i=0;i<addr.length;i++){
	                            			if(t_addr==addr[i].org){
	                            				$('#txtStraddr__'+n).val(addr[i].cur);		
	                            				break;
	                            			}
	                            		}
	                            		t_addr = $.trim(column[5]);
	                            		for(var i=0;i<addr.length;i++){
	                            			if(t_addr==addr[i].org){
	                            				$('#txtEndaddr__'+n).val(addr[i].cur);		
	                            				break;
	                            			}
	                            		}
	                            		//$('#txtStraddr__'+n).val($.trim(column[4]));
	                            		//$('#txtEndaddr__'+n).val($.trim(column[5]));
	                            		$('#txtMemo__'+n).val($.trim(column[6]));
	                            		n++;
	                            	}
								}
                            	$('#btnFile').val('');
                            	//bbs
                            	var item = new Array();
								for(var i=0;i<q_bbtCount;i++){
									if($.trim($('#txtContainerno1__'+i).val()).length==0)
										continue;
									casetype = "";
									switch($('#txtCasetype__'+i).val().substring(0,1)){
										case "2":
											casetype = "20'"+(q_float('txtMount__'+i)>0?"F":"E");
											break;
										case "4":
											casetype = "40'"+(q_float('txtMount__'+i)>0?"F":"E");
											break;
										default:
											break;
									}
									straddr = $.trim($("#txtStraddr__"+i).val()); 
									endaddr = $.trim($("#txtEndaddr__"+i).val());
									cardeal = $.trim($("#txtCardeal__"+i).val());
									
									n = -1;//判斷 起點+迄點+車行+櫃型 是否已存在
									for(var j=0;j<item.length;j++){
										if(item[j].straddr==straddr && item[j].endaddr==endaddr && item[j].cardeal==cardeal && item[j].casetype==casetype){
											n=j;
											break;
										}
									}
									if(n==-1){
										item.push({straddr:straddr,endaddr:endaddr,cardeal:cardeal,casetype:casetype,mount:0});
										n = item.length-1;
									}
									item[n].mount++;
								}
								for(var i=0;i<q_bbsCount;i++){
                            		$('#btnMinus_'+i).click();
                            	}
                            	if(item.length>q_bbsCount){
                            		q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', item.length-q_bbsCount);
                            	}	
								for(var i=0;i<item.length;i++){
									$('#cmbCaseno_'+i).val(item[i].casetype);
									$('#txtDriver_'+i).val(item[i].cardeal);
									$('#txtAddrno_'+i).val(item[i].straddr);
									$('#txtAddrno2_'+i).val(item[i].endaddr);
									$('#txtMount_'+i).val(item[i].mount);
								}
								refreshBbs();
								sum();
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
                	$('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
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
                    $('#txtMount_'+i).change(function(e){refreshBbs();});
                    $('#txtLengthb_'+i).change(function(e){refreshBbs();});
                    $('#txtWidth_'+i).change(function(e){refreshBbs();});
                    $('#txtHeight_'+i).change(function(e){refreshBbs();});
                    $('#txtTotal_'+i).change(function(e){refreshBbs();});
                    $('#txtTotal2_'+i).change(function(e){refreshBbs();});
				}
				_bbsAssign();
				refreshBbs();
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
				if (!as['addr']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				
					
				/*var t_weight2 = 0,t_trannumber = 0;
				for(var i=0;i<q_bbtCount;i++){
					if($('#txtDatea__'+i).val().length>0){
						t_weight2 = q_add(t_weight2,q_float('txtWeight2__'+i));
						t_trannumber = q_add(t_trannumber,q_float('txtTrannumber__'+i));
					}
						
				}
				$('#txtTweight2').val(round(t_weight2,2));
				$('#txtTtrannumber').val(round(t_trannumber,2));	*/
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
				q_box('tranorde_ln_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				for(var i=1;i<=5;i++){
					$('#textAddrno'+i).val('');
					$('#textAddr'+i).val('');
				}
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtContract').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				refreshBbs();
				sum();
			}

			function btnPrint() {
				q_box('z_tranorde.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
				refreshBbs();
			}
			function refreshBbs(){
				var t01=0,t02=0,t03=0,t04=0,t05=0,t06=0;
				for(var i=0;i<q_bbsCount;i++){
					t01 = q_add(t01,q_float('txtMount_'+i));
					t02 = q_add(t02,q_float('txtLengthb_'+i));
					t03 = q_add(t03,q_float('txtWidth_'+i));
					t04 = q_add(t04,q_float('txtHeight_'+i));
					t05 = q_add(t05,q_float('txtTotal_'+i));
					t06 = q_add(t06,q_float('txtToalt2_'+i));
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
					$('#txtDate1').datepicker('destroy');
					$('#txtDatea2').datepicker('destroy');
					$('#btnFile').attr('disabled','disabled');
				}else{
					$('#txtDatea').datepicker();
					$('#txtDate1').datepicker();
					$('#txtDate2').datepicker();
					$('#btnFile').removeAttr('disabled');
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
				width: 1600px;
			}
			.dview {
				float: left;
				width: 550px;
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
						<td align="center" style="width:100px; color:black;"><a>PLAN_ID</a></td>
						<td align="center" style="width:100px; color:black;"><a>客戶</a></td>
						<td align="center" style="width:100px; color:black;"><a>作業日期(起)</a></td>
						<td align="center" style="width:100px; color:black;"><a>船名</a></td>
						<td align="center" style="width:100px; color:black;"><a>代表航次</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='contract' style="text-align: center;">~contract</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='date1' style="text-align: center;">~date1</td>
						<td id='boatname' style="text-align: center;">~boatname</td>
						<td id='ship' style="text-align: center;">~ship</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">PLAN_ID</a></td>
						<td><input type="text" id="txtContract" class="txt c1"/></td>
						<td><span> </span><a class="lbl">日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a class="lbl">類型</a></td>
						<td><select id='cmbStype' class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">作業日期(起)</a></td>
						<td><input type="text" id="txtDate1" class="txt c1"/></td>
						<td><span> </span><a class="lbl">作業日期(迄)</a></td>
						<td><input type="text" id="txtDate2" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">船名</a></td>
						<td><input type="text" id="txtBoatname" class="txt c1"/></td>
						<td><span> </span><a class="lbl">代表航次</a></td>
						<td><input type="text" id="txtShip" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl" id="lblCust">客戶</a></td>
						<td colspan="2">
							<input type="text" id="txtCustno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtComp" class="txt" style="float:left;width:60%;"/>
							<input type="text" id="txtNick" class="txt" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">備註</a></td>
						<td colspan="5">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">備註(請款憑證)</a></td>
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
						<td><input id="txtNoa" type="text"  class="txt c1"/> </td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5"><input id="btnFile"  type="file" /></td>
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
					<td align="center" colspan="1" rowspan="1" style="width:150px;">
						<input type="text" id="txtContainerno1.*" style="width:95%;"/>
						<input type="text" id="txtContainerno2.*" style="width:95%;display:none;"/>
					</td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><select id="cmbCaseno.*" style="width:95%;"> </select></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><input type="text" id="txtCarno.*" style="width:95%;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;">
						<input type="text" id="txtDriverno.*" style="float:left;width:45%;"/>
						<input type="text" id="txtDriver.*" style="float:left;width:45%;"/>
						<input type="button" id="btnDriver.*" style="display:none;"/>
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
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtMount.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtLengthb.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtWidth.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtHeight.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtTotal.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:70px;"><input type="text" id="txtTotal2.*" style="width:95%;text-align: right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><input type="text" id="txtMemo.*" style="width:95%;"/></td>
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
