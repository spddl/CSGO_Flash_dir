function ShowNextError()
{
   if(!showingError && errorList.length > 0)
   {
      AnimatedErrorBar.ErrorText.htmlText = errorList.pop();
      this.gotoAndPlay("StartShow");
   }
}
function AddError(err)
{
   errorList.unshift(err);
   ShowNextError();
}
function RemovePendingErrors()
{
   while(errorList.length != 0)
   {
      errorList.pop();
   }
}
function ForceHide()
{
   RemovePendingErrors();
   if(showingError)
   {
      this.gotoAndPlay("StartHide");
   }
}
function onLoaded()
{
   showingError = false;
   loopCount = 0;
   this.gotoAndStop("Hide");
}
function onUnload()
{
   RemovePendingErrors();
}
var errorList = new Array();
var loopCount = 0;
var showingError = false;
this.stop();
