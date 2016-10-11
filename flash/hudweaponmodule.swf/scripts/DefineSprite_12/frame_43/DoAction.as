if(loopNum != undefined)
{
   if(loopNum < 5)
   {
      gotoAndStop("Highlight");
      play();
      loopNum++;
   }
   else
   {
      loopNum = 0;
      this._visible = false;
      stop();
   }
}
