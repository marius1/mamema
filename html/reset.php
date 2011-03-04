<?php
include("../libs/functions.inc.php");
remove_played(urldecode($_GET['local_file']));
?>
<html>
	<body ONLOADSET="back" background="images/background.jpg">		
		<a name="back" href="javascript:history.back();" ONFOCUSLOAD><img border="0" src="images/blank.png" /></a>
	</body>
</html>