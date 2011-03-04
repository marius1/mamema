<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr height="249">
		<td>&nbsp;</td>
		<td	valign="top" align="right" colspan="{$shares|@count+2}"><img src="images/blank.png" height="30" /><h2 id="time">-</h2><span id="date">-</span></td>
	</tr>
	<tr height="75" valign="center">
		<td width="140"><a href="#" ONFOCUSSET="{$shares|@count-1}"><img border="0" src="images/blank.png" /></a></td>
			{foreach from=$shares item=share key=name}
				<td width="200" align="center">
					<a name="{$name}" class="base-link" href="/index.php?share={$name}" onclick="location.replace('/index.php?id={$name}'); return true;"><img border="0" src="images/{$share.icon}-inactive.png" onfocussrc="images/{$share.icon}.png" /></a><br />
					<span class="link">{$share.name}</span>
				</td>
			{/foreach}
		<td width="140"><a href="#" ONFOCUSSET="0"><img border="0" src="images/blank.png" /></a></td>
		</td>
	</tr>
	<tr height="225" valign="bottom">
		<td align="left"><a href="http://127.0.0.1:8883/start.cgi?list"><img border="0" src="images/home-inactive.png" onfocussrc="images/home.png" /></a> 
		<a href="http://127.0.0.1:8883/preferences.htm"><img border="0" src="images/gears-inactive.png" onfocussrc="images/gears.png" /></a></td>
	</tr>
</table>
