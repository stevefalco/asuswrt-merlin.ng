﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title><#Web_Title#> - <#menu5_7_5#></title>
<link rel="stylesheet" type="text/css" href="index_style.css"> 
<link rel="stylesheet" type="text/css" href="form_style.css">
<script type="text/javascript" src="/js/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script>
<% get_vserver_array(); %>
<% get_upnp_array(); %>

function initial() {
	show_menu();
	show_vserver();
	show_upnp();
}


function show_upnp() {
	var code, i, line;
	var Hours, Minutes, Seconds;

	code = '<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable_table">';
	code += '<thead><tr><td colspan="6">UPnP IGD &amp; PCP/NAT-PMP IPv4 port forwards</td></tr></thead>';
	code += '<tr><th width="8%">Proto</th>';
	code += '<th width="8%">Ext Port</th>';
	code += '<th width="17%">Local IP</th>';
	code += '<th width="12%">Local Port</th>';
	code += '<th width="13%">Time left</th>';
	code += '<th width="42%">Description</th>';
	code += '</tr>';

	if ("<% nvram_get("wan_upnp_enable"); %>" == "0") {
		code += '<tr><td colspan="6"><span>Service is currently disabled. Can be enabled <a href="Advanced_WAN_Content.asp" style="text-decoration: underline;">here</a>.</span></td></tr>';
	} else {
		if (upnparray.length > 1) {
			for (i = 0; i < upnparray.length-1; ++i) {
				line = upnparray[i];

				code += '<tr>';
				code += '<td>' + line[0] + '</td>';
				code += '<td>' + line[1] + '</td>';
				code += '<td>' + line[2] + '</td>';
				code += '<td>' + line[3] + '</td>';

				if (line[4] != 0) {
					Hours = Math.floor((line[4] / 3600));
					Minutes = Math.floor(line[4] % 3600 / 60);
					Seconds = Math.floor(line[4] % 60);
					code += '<td>' + Hours + "h " + Minutes + "m "+ Seconds + "s" + '</td>';
				} else {
					code += '<td>' + 'N/A' + '</td>';
				}

				code += '<td>' + line[5].shorter(45) + '</td>';
				code += '</tr>';
			}
		} else {
			code += '<tr><td colspan="6"><span>No active port forwards.</span></td></tr>';
		}
	}

	code += '</tr></table>';
	document.getElementById("upnpblock").innerHTML = code;
}


function show_vserver() {
	var code, i, line;

	code = '<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable_table">';
	code += '<thead><tr><td colspan="6">Virtual Servers</td></tr></thead>';
	code += '<tr><th width="20%">Source IP</th>';
	code += '<th width="10%">Proto</th>';
	code += '<th width="15%">Ext Port range</th>';
	code += '<th width="20%">Local IP</th>';
	code += '<th width="15%">Local Port</th>';
	code += '<th width="20%">Chain</th>';
	code += '</tr>';

	if (vserverarray.length > 1) {
		for (i = 0; i < vserverarray.length-1; ++i) {
			line = vserverarray[i];
			code += '<tr>';
			code += '<td>' + line[0] + '</td>';
			code += '<td>' + line[2] + '</td>';
			code += '<td>' + line[3] + '</td>';
			code += '<td>' + line[4] + '</td>';
			code += '<td>' + line[5] + '</td>';
			code += '<td>' + line[6] + '</td>';
			code += '</tr>';
		}
	} else {
		code += '<tr><td colspan="6"><span>No active port forwards.</span></td></tr>';
	}

	code += '</tr></table>';
	document.getElementById("vserverblock").innerHTML = code;
}

</script>
</head>

<body onload="initial();" class="bg">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

<form method="post" name="form" action="apply.cgi" target="hidden_frame">
<input type="hidden" name="current_page" value="Main_IPTStatus_Content.asp">
<input type="hidden" name="next_page" value="Main_IPTStatus_Content">
<input type="hidden" name="group_id" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="action_wait" value="">
<input type="hidden" name="first_time" value="">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">

<table class="content" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="17">&nbsp;</td>
		<td valign="top" width="202">
			<div  id="mainMenu"></div>
			<div  id="subMenu"></div>
		</td>
		<td valign="top">
			<div id="tabMenu" class="submenuBlock"></div>
			<!--===================================Beginning of Main Content===========================================-->
			<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" >          
						<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3"  class="FormTitle" id="FormTitle">
							<tr bgcolor="#4D595D">
								<td valign="top">
									<div>&nbsp;</div>
									<div class="formfonttitle"><#System_Log#> - <#menu5_7_5#></div>
									<div style="margin:10px 0 10px 5px;" class="splitLine"></div>
									<br>

									<div style="margin-top:8px">
										<div id="vserverblock"></div>
									</div>
									<br>
									<div style="margin-top:8px">
										<div id="upnpblock"></div>
									</div>
									<br>

									<div class="apply_gen">
										<input type="button" onClick="location.reload();" value="<#CTL_refresh#>" class="button_gen">
									</div>
								</td>
							</tr>
						</table> 
					</td>
				</tr>
			</table>
			<!--===================================Ending of Main Content===========================================-->
		</td>
		<td width="10" align="center" valign="top">&nbsp;</td>
	</tr>
</table>
<div id="footer"></div>
</form>
</body>
</html>
