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
                q_gf('', 'z_tran_ln5');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_tran_ln5',
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_tran_ln5.aspx','')
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
						name : 'userno',
						value : r_userno
					},{
						type : '0', //[5]
						name : 'user',
						value : r_name
					},{//[6][7]                1
                        type : '1',
                        name : 'xno'
                    },{//[8][9]              2
                        type : '1',
                        name : 'xdate'
                    }, {
						//[10]                 3
						type : '6', name : 'xv02'
					}, {
						//[11]                 4
						type : '6', name : 'xv03'
					}]
                });
                q_popAssign();
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				
				
				var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }   
	            if(t_para.length==0 || t_para.noa==undefined){
	            }/*else{//2018/06/15 小葉 單號不自動帶入
	            	$('#txtXno1').val(t_para.noa);
	            	$('#txtXno2').val(t_para.noa);
	            }*/
	           
	            $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
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