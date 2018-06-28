<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">  
		protected void Page_Load(object sender, EventArgs e)
		{
		    jwcf wcf = new jwcf();
		
		    wcf.q_content("borrg", " (worker=case when CHARINDEX('-',$r_userno)!=0 then SUBSTRING($r_userno,0,CHARINDEX('-',$r_userno)) else $r_userno end) or $r_rank >= 7 ");
		    
		}
	</script>

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
			//外車登帳
			q_tables = 's';
			var q_name = "borrg";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtOrdeno'
				,'textA01','textA02','textA03','textA04','textA05','textA06','textA07'];
			var q_readonlys = ['txtN05'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = [];
			var bbsNum = new Array(['txtN01',10,0],['txtTotal2',10,0]);
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
						q_content = "where=^^ noa='"+t_para.noa+"' and vccno='tran_ln4' ^^";
				}catch(e){
					q_content = "where=^^ vccno='tran_ln4'^^";
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
				bbmMask = new Array(['txtDatea', r_picd],['txtBegindate', r_picd],['txtEnddate',r_picd],['txtCheckno',r_picd]);
				q_mask(bbmMask);
				document.title = '外車登帳(移櫃)';
				
				q_cmbParse("cmbCasetype", " ,20'E,40'E,20'F,40'F","s");
				
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
                    $('#txtCaseno_' + i).change(function(e) {
                    	$(this).val($.trim($(this).val()));
                    	if($(this).val().length>0 && !checkCaseno($(this).val())){
                    		alert('櫃號異常【'+$(this).val()+'】');
                    	}
                    });	
                    /*$('#txtCheckno_' + i).change(function(e) {
                    	//檢查是否可以和派工單的資料對應
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        MatchData(n);
                    });*/	
                    	
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
                    $('#txtTotal2_'+i).change(function(e){refreshBbs();});
                    $('#txtN16_'+i).change(function(e){refreshBbs();});
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
				if (!as['caseno'] && !as['checkno'] ) {
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
				q_box('tran_ln4_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtVccno').val('tran_ln4');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box('z_tran_ln4.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + '' + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}

			function btnOk() {
				if($.trim($('#txtDatea').val()).length==0){
					alert('請輸入日期');
					return;
				}
				refreshBbs();
				sum();
				
				var errmsg = "";
				for(var i=0;i<q_bbsCount;i++){
					caseno = $.trim($('#txtCaseno_' + i).val());
					if(caseno.length>0 && !checkCaseno(caseno)){
                		errmsg += (errmsg.length>0?"\n":"")+caseno; 	
                	}
                	caseno2 = $.trim($('#txtCheckno_' + i).val());
					if(caseno2.length>0 && !checkCaseno(caseno2)){
                		errmsg += (errmsg.length>0?"\n":"")+caseno2; 	
                	}
				}
				if(errmsg.length>0){
					alert('櫃號異常\n'+ errmsg);
				}
				if(q_cur ==1){
					$('#txtWorker').val(r_userno);
				}else{
					$('#txtWorker2').val(r_userno);
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val()).replace(/\//g,'');
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
				//與派工單匹配
				var t_noa = $.trim($('#txtNoa').val());
				q_func('qtxt.query.tranordet_borrgs', 'tranorde_ln.txt,tranordet_borrgs,' + r_userno + ';' + t_noa);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
			}
			
			function refreshBbs(){
				var t01=0,t02=0,t03=0,t04=0,t05=0,t06=0,t07=0;
				for(var i=0;i<q_bbsCount;i++){
					//與派工單可對應就變綠色
					if($.trim($('#txtOrdeno1_'+i).val()).length>0)
						$('#txtCaseno_'+i).css('color','green');
					else
						$('#txtCaseno_'+i).css('color','black');
					if($.trim($('#txtOrdeno2_'+i).val()).length>0)
						$('#txtCheckno_'+i).css('color','green');
					else
						$('#txtCheckno_'+i).css('color','black');
					//------------------------------------------------------------
					t01 = q_add(t01,q_float('txtN01_'+i));
					t06 = q_add(t06,q_float('txtTotal2_'+i));
					t07 = q_add(t07,q_float('txtN16_'+i));
				}
				$('#textA01').val(t01);
				$('#textA02').val(t02);
				$('#textA03').val(t03);
				$('#textA04').val(t04);
				$('#textA05').val(t05);
				$('#textA06').val(t06);
				$('#textA07').val(t07);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtBegindate').datepicker('destroy');
					$('#txtEnddate').datepicker('destroy');
					$('#txtCheckno').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtBegindate').datepicker();
					$('#txtEnddate').datepicker();
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
					case 'qtxt.query.tranordet_borrgs':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].msg.length>0){
								//error msg
								alert(as[0].msg);
								return;
							}else{
								for(var i=0;i<as.length;i++){
									for(var j=0;j<q_bbsCount;j++){
										if($('#txtNoq_'+j).val() == as[i].noq){
											$('#txtOrdeno1_'+j).val(as[i].ordeno1);
											$('#txtOrdeno2_'+j).val(as[i].ordeno2);
											break;
										}	
									}
								}
							}
						}
						refreshBbs();
						break;
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
			
			function MatchData(n){
				//與派工單匹配
				var t_noa = $.trim($('#txtNoa').val());
				var t_noq = $.trim($('#txtNoq_'+n).val());
				var t_caseno1 = $.trim($('#txtCaseno_'+n).val()); 
				var t_caseno2 = $.trim($('#txtCheckno_'+n).val());
				var t_date = $.trim($('#txtDatea').val()); 
				q_func('qtxt.query.tranordet_borrgs_'+n, 'tranorde_ln.txt,tranordet_borrgs,' + t_noa + ';' + t_noq + ';' + t_caseno1 + ';' + t_caseno2+ ';' + t_date);
				
				
				/*$.ajax({
					n : n,
                    url: 'xxxxx.aspx',
                    headers: { },
                    type: 'POST',
                    data: JSON.stringify({ db:q_db
                    	,action:"tmp",table:"workj"
                    	,originImg: '',picno:t_picno
                    	,orgpara:'',para:t_para}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                    	//回傳檔名
                    	var file = JSON.parse(data);
                    	$('#imgPic_'+this.n).attr('src','..\\htm\\htm\\tmp\\'+file.filename+'?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
                    	if($('#txtMemo_'+n).val().substring(0,1)!='*'){
							$('#txtLengthb_'+n).val(file.lengthb);
						}
                    },
                    complete: function(){ 
                    },
                    error: function(jqXHR, exception) {
                    	$('#imgPic_'+this.n).attr('src','');
                        var errmsg = this.url+'資料寫入異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });*/
			}
			function checkCaseno(caseno){
				if(!(/^[A-Z]{4}[0-9]{7}$/.test(caseno))){
					console.log('櫃號格式異常');
					return false;
				}
				var string = "0123456789A_BCDEFGHIJK_LMNOPQRSTU_VWXYZ";
				var n = 0;
				for(var i=0;i<caseno.length-1;i++){
					n += string.indexOf(caseno.substring(i,i+1)) * Math.pow(2,i);
				}
				n = Math.floor((n/11 + 0.09)*10) + '';
				n = n.substring(n.length-1,n.length);
				return caseno.substring(caseno.length-1,caseno.length) == n;
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
						<td align="center" style="width:120px; color:black;"><a>PLAN_ID</a></td>
						<td align="center" style="width:100px; color:black;"><a>進出站時間</a></td>
						<td align="center" style="width:120px; color:black;"><a>代表航次</a></td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">PLAN_ID</a></td>
						<td><input type="text" id="txtV01" class="txt c1"/></td>
						<td><span> </span><a class="lbl">日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a class="lbl">發票號碼</a></td>
						<td><input type="text" id="txtAccno" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">作業日期(起)</a></td>
						<td><input type="text" id="txtTrandate" class="txt c1"/></td>
						<td><span> </span><a class="lbl">作業日期(迄)</a></td>
						<td><input type="text" id="txtTrantime" class="txt c1"/></td>
						<td><span> </span><a class="lbl">發票日期</a></td>
						<td><input type="text" id="txtCheckno" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblV02" class="lbl btn">船名</a></td>
						<td>
							<input type="text" id="txtV02" class="txt c1"/>
							<input type="button" id="btnBoat" style="display:none;" />
						</td>
						<td><span> </span><a class="lbl">代表航次</a></td>
						<td><input type="text" id="txtV03" class="txt c1"/></td>
						<!--<td><span> </span><a class="lbl">派工單號</a></td>
						<td>
							<input type="text" id="txtOrdeaccy" style="display:none;" />
							<input type="text" id="txtOrdeno" class="txt c1"/>
						</td>-->
					</tr>
					<tr>
						<td><span> </span><a class="lbl" id="lblCust">客戶</a></td>
						<td colspan="2">
							<input type="text" id="txtCustno" class="txt" style="float:left;width:40%;"/>
							<input type="text" id="txtCust" class="txt" style="float:left;width:60%;"/>
							<input type="text" id="txtCustnick" class="txt" style="display:none;"/>
						</td>
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
						<td><span> </span><a id="lblMemo" class="lbl">備註</a></td>
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
						<td><span> </span><a id="lblWorker" class="lbl">製單員</a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl">修改人</a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl">電腦編號</a></td>
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
					<!--<td align="center" colspan="1" rowspan="1" style="width:30px;"><a>請<br>款</a></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號(一)</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號(二)</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>櫃型</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車牌</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:120px;"><a>車行</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>起點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>迄點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>數量</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>油桶櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>押運櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>儀檢</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>危標</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>OOG</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>其他</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div style="width: 1700px;">
			<table>
				<tr style='color:white; background:#003366;' > 	
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><span style="display:block;width:50px;height:5px;"> </span></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><span style="display:block;width:50px;height:5px;"> </span></td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:30px;"><span style="display:block;width:30px;height:5px;"> </span></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:120px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>TOTAL</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><input id="textA01" class="txt" style="width:90%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"> </td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><input id="textA06" class="txt" style="width:90%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><input id="textA07" class="txt" style="width:90%;text-align:right;"/></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"> </td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 1700px;">
			<table id="tbbs" class='tbbs'>
				<tr style="color:white; background:#003366;display:none;" >
					<td align="center" style="width:50px;"><span style="display:block;width:50px;height:5px;"> </span></td>
					<td align="center" style="width:50px;"><span style="display:block;width:50px;height:5px;"> </span></td>
					<!--<td align="center" colspan="1" rowspan="1" style="width:30px;"><span style="display:block;width:30px;height:5px;"><a>請<br>款</a></span></td>-->
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號(一)</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:150px;"><a>櫃號(二)</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>櫃型</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:100px;"><a>車牌</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:120px;"><a>車行</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>起點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>迄點</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>數量</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>油桶櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>押運櫃</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>儀檢</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:50px;"><a>危標</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>OOG</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:80px;"><a>其他</a></td>
					<td align="center" colspan="1" rowspan="1" style="width:200px;"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center" style="width:50px">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td style="width:50px"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;width:95%;"> </a></td>
					<!--<td style="width:30px"><input type="checkbox" id="chkChk1.*" style="width:95%;"/></td>-->
					<td style="width:150px;">
						<input type="text" id="txtCaseno.*" style="width:95%;"/>
						<!--對應的派工單-->
						<input type="text" id="txtOrdeno1.*" style="display:none;">
					</td>
					<td style="width:150px;">
						<input type="text" id="txtCheckno.*" style="width:95%;"/>
						<!--對應的派工單-->
						<input type="text" id="txtOrdeno2.*" style="display:none;">
					</td>
					<td style="width:80px;"><select id="cmbCasetype.*" style="width:95%;"> </select></td>
					<td style="width:100px;"><input type="text" id="txtCarno.*" style="width:95%;"/></td>
					<td style="width:120px">
						<input type="text" id="txtCardealno.*" style="float:left;width:35%;"/>
						<input type="text" id="txtCardeal.*" style="float:left;width:55%;"/>
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
					<td style="width:50px"><input type="checkbox" id="chkChk2.*" style="width:95%;"/></td>
					<td style="width:50px"><input type="checkbox" id="chkChk3.*" style="width:95%;"/></td>
					<td style="width:50px"><input type="checkbox" id="chkChk4.*" style="width:95%;"/></td>
					<td style="width:50px"><input type="checkbox" id="chkChk5.*" style="width:95%;"/></td>
					<td style="width:80px;"><input type="text" id="txtTotal2.*" style="width:95%;text-align: right;"/></td>
					<td style="width:80px;"><input type="text" id="txtN16.*" style="width:95%;text-align: right;"/></td>
					<td style="width:200px;"><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
