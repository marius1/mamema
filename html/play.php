<?php
include("../libs/functions.inc.php");
add_played(urldecode($_GET['local_file']));
?>
<html>
	<body ONLOADSET="play" background="images/background.jpg">
		<a name="play" href="<?=urldecode($_GET['pch_file'])?>" ONFOCUSLOAD ONFOCUSSET="back" vod><img border="0" src="images/blank.png" /></a> 
		<a name="back" href="javascript:history.back();" ONFOCUSLOAD><img border="0" src="images/blank.png" /></a>
	</body>
</html>
