function enterHighlight()
{
   _global.ControlsMovie.IsGlyphControl = true;
}
function exitHighlight()
{
   _global.ControlsMovie.IsGlyphControl = false;
}
Lib.Controls.SFButton.InitAsStandardSFButton(this);
stop();
