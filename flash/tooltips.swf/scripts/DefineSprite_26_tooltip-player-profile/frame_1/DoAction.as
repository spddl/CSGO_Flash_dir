function TooltipPlayerProfileShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
      this.swapDepths(_root.getNextHighestDepth());
      new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeIn,0,100,0.25,true);
   }
   else
   {
      this._visible = false;
   }
   trace("------------------------bShow" + bShow);
}
function TooltipPlayerProfileLayout(ToolTipText, objToolTipLoc)
{
   Desc.Text.htmlText = ToolTipText;
   Desc.Text.autoSize = true;
   Desc.Text.autoSize = "left";
   Background._height = Desc.Text.textHeight + 20;
   Background._width = Desc.Text.textWidth + 30;
   LeftArrow._x = Background._x + 10;
   Desc.Text._y = (Background._height - Desc.Text._height) / 2 - 5;
   this._x = objToolTipLoc.x;
   this._y = objToolTipLoc.y;
   Background.onRollOver = function()
   {
   };
}
stop();
