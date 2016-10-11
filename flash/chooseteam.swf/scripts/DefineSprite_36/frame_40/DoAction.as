var maxloops;
if(errorList.length == 0)
{
   maxloops = _global.TeamSelectMovie.bSecondsToHoldLastError;
}
else
{
   maxloops = _global.TeamSelectMovie.bSecondsToHoldErrorWhenOthersArePending;
}
loopCount = loopCount + 1;
if(loopCount < maxloops)
{
   gotoAndStop("Show");
   play();
}
