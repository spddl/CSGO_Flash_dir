function onResize(rm)
{
   rm.ResetPositionByPixel(panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function onUnload(mc)
{
   _global.CreditsMovie = null;
   _global.CreditsAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   gameAPI.OnReady();
   if(bFirstTimeSkipToEnd == false)
   {
      panel.Panel.gotoAndPlay(135);
      bFirstTimeSkipToEnd = true;
   }
}
function dismissAnimation(inCertMode)
{
   gotoAndStop("StartHide");
   play();
}
function playAudio(trackNum)
{
   if(trackNum == -1)
   {
      gameAPI.PlayAudio();
   }
   else if(trackNum == 0)
   {
      gameAPI.PlayAudio("music/002/gamestartup.mp3");
   }
}
function finishAnimation()
{
   _global.CreditsMovie.gameAPI.AnimationCompleted();
}
function DisplayCatagoryName(cat)
{
   panel.Catagory.CatagoryText.Text.htmlText = cat;
   panel.Catagory.gotoAndPlay("StartFadeIn");
}
function CleanArrayAndSort()
{
}
function DisplayNamesBlock()
{
   if(whatSectionToDisplay == 0)
   {
      whatArrayToUse = credits;
      whatNumberToUse = numberOfNames;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 2)
   {
      whatArrayToUse = hiddenPath;
      whatNumberToUse = numberOfHiddenPath;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      CleanArrayAndSort();
      panel.ValveLogo.gotoAndPlay("ValveFadeOut");
      DisplayCatagoryName(catagory[0]);
   }
   if(whatSectionToDisplay == 4)
   {
      whatArrayToUse = hiddenPathInc;
      whatNumberToUse = numberOfHiddenPathInc;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[1]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 6)
   {
      whatArrayToUse = bigFish;
      whatNumberToUse = numberOfBigFish;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[2]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 8)
   {
      whatArrayToUse = sugar;
      whatNumberToUse = numberOfSugar;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[3]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 10)
   {
      whatArrayToUse = mocap;
      whatNumberToUse = numberOfMocap;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[4]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 12)
   {
      whatArrayToUse = dC5Talent;
      whatNumberToUse = numberOfDC5Talent;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[5]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 14)
   {
      whatArrayToUse = artBully;
      whatNumberToUse = numberOfArtBully;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[6]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 16)
   {
      whatArrayToUse = liquid;
      whatNumberToUse = numberOfLiquid;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[7]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 18)
   {
      whatArrayToUse = gunGame;
      whatNumberToUse = numberOfGunGame;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[8]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 20)
   {
      whatArrayToUse = specialThanks;
      whatNumberToUse = numberOfSpecialThanks;
      howManyTimesToFade = Math.floor(whatNumberToUse / sliceNumEnd);
      whatSectionToDisplay++;
      DisplayCatagoryName(catagory[9]);
      CleanArrayAndSort();
   }
   if(whatSectionToDisplay == 22)
   {
      panel.Panel._visible = false;
      panel.Catagory._visible = false;
      panel.logo.gotoAndPlay("fadeBright");
   }
}
function IncrementNamesBlock()
{
   DisplayNamesBlock();
   if(numberTimesUpdatedNamesBlock <= howManyTimesToFade)
   {
      var _loc1_ = whatArrayToUse.slice(sliceNumStart,sliceNumEnd);
      var _loc2_ = _loc1_.join("<br>");
      panel.Panel.CreditBody.Text.htmlText = _loc2_;
      sliceNumStart = sliceNumStart + numberOfNamesInBlock;
      sliceNumEnd = sliceNumEnd + numberOfNamesInBlock;
      numberTimesUpdatedNamesBlock++;
      FadeBg();
   }
   else
   {
      sliceNumStart = 0;
      sliceNumEnd = numberOfNamesInBlock;
      numberTimesUpdatedNamesBlock = 0;
      whatSectionToDisplay++;
      IncrementNamesBlock();
   }
}
function FadeBg()
{
   if(numberOfTimesFadeBg == fadeBgCounter)
   {
      fadeNumber++;
      panel.mc_bg.gotoAndPlay("fade" + fadeNumber);
      fadeBgCounter = 0;
   }
   else
   {
      var _loc1_ = Math.round(Math.random() * 10);
      fadeBgCounter++;
      if(_loc1_ < 4)
      {
         panel.Flash.gotoAndPlay("StartFlash");
      }
   }
}
function EndMovie()
{
   dismissAnimation();
   panel.mc_bg._visible = false;
}
var bFirstTimeSkipToEnd = false;
_global.CreditsMovie = this;
_global.CreditsAPI = gameAPI;
_global.resizeManager.AddListener(this);
var credits = new Array();
var hiddenPath = new Array();
var hiddenPathInc = new Array();
var bigFish = new Array();
var sugar = new Array();
var mocap = new Array();
var dC5Talent = new Array();
var artBully = new Array();
var liquid = new Array();
var gunGame = new Array();
var specialThanks = new Array();
var catagory = new Array();
var creditName = "#SFUI_CreditName";
var creditHiddenPath = "#SFUI_HiddenPath";
var creditHiddenPathInc = "#SFUI_HiddenPathInc";
var creditBigFish = "#SFUI_BigFish";
var creditSugar = "#SFUI_Sugar";
var creditMocap = "#SFUI_Mocap";
var creditDC5Talent = "#SFUI_DC5Talent";
var creditArtBully = "#SFUI_ArtBully";
var creditLiquid = "#SFUI_Liquid";
var creditGunGame = "#SFUI_GunGame";
var creditSpecialThanks = "#SFUI_Special";
var catagoryNames = "#SFUI_CatagoryStrings";
var numberOfNames = 309;
var numberOfHiddenPath = 31;
var numberOfHiddenPathInc = 14;
var numberOfBigFish = 9;
var numberOfSugar = 3;
var numberOfMocap = 2;
var numberOfDC5Talent = 6;
var numberOfArtBully = 3;
var numberOfLiquid = 12;
var numberOfGunGame = 7;
var numberOfSpecialThanks = 8;
var numberOfCatagorys = 10;
var sliceNumStart = 0;
var sliceNumEnd = 17;
var numberOfNamesInBlock = 17;
var numberOfBgFadesAvailible = 6;
var numberOfTimesFadeBg = Math.floor(Math.floor(Math.floor(numberOfNames + numberOfHiddenPath + numberOfHiddenPathInc + numberOfBigFish + numberOfSugar + numberOfMocap + numberOfDC5Talent + numberOfArtBully + numberOfLiquid + numberOfSpecialThanks) / sliceNumEnd) / numberOfBgFadesAvailible);
var fadeBgCounter = 0;
var howManyTimesToFade = 0;
var bgFadeIncrenmentAdd = bgFadeIncrenment;
var fadeNumber = 0;
var numberTimesUpdatedNamesBlock = 0;
var whatSectionToDisplay = 0;
var whatArrayToUse = new Array();
var whatCatagoryToUse = new Array();
var whatNumberToUse = 0;
i = 0;
while(i < numberOfNames)
{
   credits.push(_global.GameInterface.Translate(creditName + i));
   i++;
}
i = 0;
while(i < numberOfHiddenPath)
{
   hiddenPath.push(_global.GameInterface.Translate(creditHiddenPath + i));
   i++;
}
i = 0;
while(i < numberOfHiddenPathInc)
{
   hiddenPathInc.push(_global.GameInterface.Translate(creditHiddenPathInc + i));
   i++;
}
i = 0;
while(i < numberOfBigFish)
{
   bigFish.push(_global.GameInterface.Translate(creditBigFish + i));
   i++;
}
i = 0;
while(i < numberOfSugar)
{
   sugar.push(_global.GameInterface.Translate(creditSugar + i));
   i++;
}
i = 0;
while(i < numberOfMocap)
{
   mocap.push(_global.GameInterface.Translate(creditMocap + i));
   i++;
}
i = 0;
while(i < numberOfDC5Talent)
{
   dC5Talent.push(_global.GameInterface.Translate(creditDC5Talent + i));
   i++;
}
i = 0;
while(i < numberOfArtBully)
{
   artBully.push(_global.GameInterface.Translate(creditArtBully + i));
   i++;
}
i = 0;
while(i < numberOfLiquid)
{
   liquid.push(_global.GameInterface.Translate(creditLiquid + i));
   i++;
}
i = 0;
while(i < numberOfGunGame)
{
   gunGame.push(_global.GameInterface.Translate(creditGunGame + i));
   i++;
}
i = 0;
while(i < numberOfSpecialThanks)
{
   specialThanks.push(_global.GameInterface.Translate(creditSpecialThanks + i));
   i++;
}
i = 0;
while(i < numberOfCatagorys)
{
   catagory.push(_global.GameInterface.Translate(catagoryNames + i));
   i++;
}
stop();
