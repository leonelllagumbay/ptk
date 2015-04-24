
<cfoutput><script type="text/javascript" src="#session.domain#scripts/jquery-1.9.1.min.js"></script></cfoutput>
<script type="text/javascript" >
	$(document).ready(function() {
		$(document).bind("contextmenu", function(e) {
			return false;
		});
	});
</script>

<style type="text/css">

.main img {
	-webkit-touch-callout: none;
	
}
body {
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

</style>

<h1>Sorry no right click</h1>