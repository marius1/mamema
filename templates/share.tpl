<a href="/reset.php?focus=" TVID="_red"><img border="0" src="images/blank.png" /></a>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr height="115">
		<td valign="center" width="55"><img src="images/{$share_icon}-small.png" /></td>
		<td valign="center"><h1>{$share_name}{if $path neq ""}: <marquee behavior="focus" width="740">{$path|trim:'/'}</marquee>{/if}</h1></td>
		<td align="right" width="120"><h2 id="time"> </h2><span id="date"> </span></td>
	</tr>	
</table>
<div>
	{if $total > $smarty.const.PAGE_SIZE}
		{if $page > 0}{assign var=p value=$page-1}{math assign=i equation="x*y-1" x=$page y=$smarty.const.PAGE_SIZE}{else}{assign var=p value=$pages-1}{assign var=i value=$count}{/if}		
		<a href="javascript:location.replace('/index.php?id={$i}&path={$path|trim:'/'|urlencode}&share={$share_id}&page={$p}');" ONFOCUSLOAD><img border="0" src="images/blank.png" /></a>		
	{else}
		<a href="#" ONFOCUSSET="{$count-1}"><img border="0" src="images/blank.png" /></a>
	{/if}
</div>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr height="25"><td colspan="2">&nbsp;</td></tr>
	<tr>
		<td colspan="2" align="right">
			<img border="0" src="images/down{if $pages == 0 || $page == $pages-1}-inactive{/if}.png" />
			<img border="0" src="images/up{if $pages > 0 && $page == 0}-inactive{/if}.png" />
		</td>
	</tr>
	{foreach from=$directories item=d key=name}
		<tr>
			<td width="30"><img border="0" src="images/folder.png" /></td>
			<td><a name="{$name}" class="link" href="/index.php?path={$d.full_path|urlencode}&share={$share_id}" onclick="location.replace('/index.php?id={$name}&share={$share_id}&path={$path|trim:'/'|urlencode}&page={$page}'); return true;"><marquee behavior="focus" width="1060">{$d.path}</marquee></a></td>
		</tr>
	{/foreach}

	{foreach from=$files item=f key=name}
		<tr>
			<td width="30"><img border="0" src="images/{$f.type}{if $f.played}-played{/if}.png" /></td>
		{if $f.type eq "vod"}
			<td><a name="{$name}" class="link" href="/play.php?pch_file={$f.pch_file|urlencode}&local_file={$f.local_file|urlencode}&share={$share_id}" onclick="location.replace('/index.php?id={$name}&path={$path|trim:'/'|urlencode}&share={$share_id}&page={$page}'); return true;"><marquee behavior="focus" width="1060">{$f.filename}</marquee></a></td>
		{else}
			<td><a name="{$name}" class="link" href="{$f.pch_file}" {$f.type}><marquee behavior="focus" width="1060">{$f.filename}</marquee></a></td>
		{/if}
		</tr>
	{/foreach}
	
	{foreach from=$rest item=r}
	<tr><td height="24" colspan="2">&nbsp;</td></tr>
	{/foreach}
	<tr>
		<td colspan="2" align="right">
			{if $total > $smarty.const.PAGE_SIZE}
				<span class="counter">{math equation="x*y+1" x=$page y=$smarty.const.PAGE_SIZE}-{math equation="((x+1)*y)-(y-z)" z=$count x=$page y=$smarty.const.PAGE_SIZE} [{$total} item{if $total != 1}s{/if}]</span>
			{else}
				<span class="counter">1-{$count} [{$total} item{if $total != 1}s{/if}]</span>
			{/if}
		</td>
	</tr>
</table>
<div>
	{if $total > $smarty.const.PAGE_SIZE}
		{if $page < $pages-1}{assign var=p value=$page+1}{else}{assign var=p value=0}{/if}
		<a href="javascript:location.replace('/index.php?path={$path|trim:'/'|urlencode}&share={$share_id}&page={$p}');" ONFOCUSLOAD><img border="0" src="images/blank.png" /></a>
	{else}
		<a href="#" ONFOCUSSET="0"><img border="0" src="images/blank.png" /></a>
	{/if}
</div>
