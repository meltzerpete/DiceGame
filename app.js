var params = {
  filename: "dice.ggb",
  "prerelease":false,
  "width":600,
  "height":450,
  "showToolBar":false,
  "borderColor":null,
  "showMenuBar":false,
  "showAlgebraInput":false,
  "showResetIcon":false,
  "enableLabelDrags":false,
  "enableShiftDragZoom":false,
  "enableRightClick":false,
  "capturingThreshold":null,
  "showToolBarHelp":false,
  "errorDialogsActive":false,
  "useBrowserForJS":true,
  "showLogging": false,
  capturingThreshold: 0
}
var applet = new GGBApplet(params, true);
applet.setHTML5Codebase('https://app.geogebra.org/5.0/web3d/');

window.onload = function() {
  applet.inject('applet_container', 'preferHTML5');
}

function ggbOnInit() {
	// register add, remove, rename and update listeners
  var applet = document.ggbApplet;
	console.log("here now");
  // applet.evalCommand("A = Rotate[A, 3.14, xAxis]\n B = Rotate[B, 3.14, xAxis]");
  applet.evalCommand("nums = true");
}
