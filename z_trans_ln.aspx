<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            aPop = new Array(
				['txtXstraddr', 'lblXstraddr', 'addr2', 'noa,addr', 'txtXstraddr', 'addr2_b.aspx'],
				['txtXendaddr', 'lblXendaddr', 'addr2', 'noa,addr', 'txtXendaddr', 'addr2_b.aspx']
			);
            $(document).ready(function() {
            	$.datepicker.r_len=4;
				$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				
                q_getId();
                q_gf('', 'z_trans_ln');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_trans_ln',
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_trans_ln.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'project',
						value : q_getPara('sys.project').toUpperCase()
					},{
						type : '0', //[4]
						name : 'user',
						value : r_name
					}, {//[5]               1
                        type : '6',
                        name : 'xnoa'
                    }, {//[6]               2
                        type : '6',
                        name : 'xworkno'
                    },{//[7]                3
                        type : '6',
                        name : 'mon'
                    },{//[8][9]                4
                        type : '1',
                        name : 'date'
                    }, {//[10]               5
                        type : '6',
                        name : 'xplanid'
                    },{//[11][12]               6
                        type : '1',
                        name : 'xsel'
                    }, {
						//[13]                 7
						type : '6', name : 'xstraddr'
					}, {
						//[14]                 8
						type : '6', name : 'xendaddr'
					}, {
						//[15][16]              9
						type : '2', name : 'xcardeal', dbf : 'cardeal', index : 'noa,nick', src : 'cardeal_b.aspx'
					},{//[17]                 10
                        type : '8',
                        name : 'xoption',
                        value : "1@新安單價".split(",")
                    }, {
						//[18][19]              11
						type : '2', name : 'xcust', dbf : 'cust', index : 'noa,nick', src : 'cust_b.aspx'
					}, {//[20]              12
                        type : '6',  
                        name : 'xinvoice'
                    }, {
						//[21]                 13  科目
						type : '6', name : 'xtype'
					},{//[22][23]              14
                        type : '1',
                        name : 'ynoa'
                    },{//[24][25]              15
                        type : '1',
                        name : 'xv01'
                    }, {
						//[26]                 16 收入內容
						type : '6', name : 'ytype'
					}, {
						//[27]                 17 科目
						type : '6', name : 'ztype'
					}]
                });
                q_popAssign();
				$('#txtMon').mask(r_picm);
				$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();
				
				
				var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtXnoa').val(t_para.noa);
	            }
	            if(t_para.length==0 || t_para.workno==undefined){
	            }else{
	            	$('#txtXworkno').val(t_para.workno);
	            }
	            if(t_para.length==0 || t_para.planid==undefined){
	            }else{
	            	$('#txtXplanid').val(t_para.planid);
	            }
	            
	            $('#txtXsel1').val(1);
	            $('#txtXsel2').val(999);
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>