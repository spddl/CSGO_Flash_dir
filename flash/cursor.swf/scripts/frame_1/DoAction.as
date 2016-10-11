var gCursorMouseListener = new Object();
gCursorMouseListener.onMouseMove = function()
{
   _global.theCursor._x = _xmouse;
   _global.theCursor._y = _ymouse;
   updateAfterEvent();
};
Mouse.addListener(gCursorMouseListener);
Mouse.setCursorType = function(cursorType)
{
};
ASSetPropFlags(Mouse,"show,hide",0,7);
Mouse.show = function()
{
   _global.theCursor._visible = true;
};
Mouse.hide = function()
{
   _global.theCursor._visible = false;
};
Mouse.hide();
_global.Show = function()
{
   Mouse.show();
};
_global.Hide = function()
{
   Mouse.hide();
};
_global.SetCursorShape = function(shapeIndex)
{
   if(shapeIndex == 0)
   {
      _global.theCursor = gCursor;
   }
   else
   {
      _global.theCursor = null;
   }
};
_global.SetCursorShape(0);
