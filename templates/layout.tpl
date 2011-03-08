<html>
	<head>
		<link rel="StyleSheet" type="text/css" href="A100_Index.css"></link>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<style>	
			.base-link {
				font-family: arial;
				font-size: 14pt;
				font-weight : bold;
				color: #AAAAAA;
			}
			.link {
				font-family: arial;
				font-size: 15pt;
				color: #ffffff;
				text-decoration: none;
			}
			h1 {
				font-family: arial;
				font-weight: normal;
				font-size: 24pt;
				color: #ffffff;
			}
			h2 {
				font-family: arial;
				font-weight: normal;
				font-size: 20pt;
				color: #ffffff;
			}
			#date {
				font-family: arial;
				font-weight: normal;
				font-size: 14pt;
				color: #ffffff;
			}
			.counter {
				font-family: arial;
				font-size: 15pt;
				color: #ffffff;
			}
		</style>
		<script>
		var startTime = function() {
			setTime();
			setInterval('setTime()', 15000);
		};
		var setTime = function() {
			var d = new Date();
			d.setHours(d.getHours()+1);
			var time = document.createTextNode(d.getHours() +':'+((d.getMinutes() < 10) ?'0'+d.getMinutes():d.getMinutes()));
			var date = document.createTextNode(d.toLocaleDateString());
			
			document.getElementById('time').removeChild(document.getElementById('time').lastChild);
			document.getElementById('date').removeChild(document.getElementById('date').lastChild);
			
			document.getElementById('time').appendChild(time);
			document.getElementById('date').appendChild(date);
		};		
		</script>
		<title>JUKEBOX</title>
	</head>
	<body{if isset($id)} ONLOADSET="{$id}"{/if} FOCUSCOLOR="#969696" FOCUSTEXT="#3a3a3a" background="images/background-{$background}.jpg" onload="startTime();">
		{$content}
	</body>
</html>