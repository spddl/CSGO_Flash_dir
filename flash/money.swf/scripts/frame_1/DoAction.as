function onLoaded()
{
   MoneyPanel.InnerMoneyPanel.CashContainer.AddCash.gotoAndPlay("Hide");
   MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCash.gotoAndPlay("Hide");
   MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCashFlash.gotoAndPlay("Hide");
   MoneyPanel.InnerMoneyPanel.CashContainer.Cash.SetText("");
   gameAPI.OnReady();
   setYPositionFromRadar();
}
function onUnload(mc)
{
   delete _global.MoneyPanel;
   _global.tintManager.DeregisterAll(this);
   _global.resizeManager.RemoveListener(this);
   return true;
}
function showPanel()
{
   if(!isShown)
   {
      MoneyPanel._visible = true;
      MoneyPanel.gotoAndPlay("StartShow");
      isShown = true;
   }
   setColorText();
   setYPositionFromRadar();
}
function hidePanel()
{
   if(isShown)
   {
      MoneyPanel.gotoAndPlay("StartHide");
      isShown = false;
   }
}
function onResize(rm)
{
   m_nDefaultShiftX = -1;
   rm.ResetPositionByPixel(MoneyPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   setYPositionFromRadar();
}
function DoneAnimatingSubtract()
{
   m_bIsAnimatingSubtract = false;
   m_nTotalSubtract = 0;
}
function DoneAnimatingAdd()
{
   m_bIsAnimatingAdd = false;
   m_nTotalAdd = 0;
}
function setYPositionFromRadar()
{
   var _loc3_ = _global.SFRadar;
   var _loc4_ = _global.BuyMenu;
   if(_loc3_ != undefined && _loc3_ != null)
   {
      if(m_nDefaultShiftX == -1)
      {
         m_nDefaultShiftX = MoneyPanel._x;
      }
      MoneyPanel.InnerMoneyPanel.BGPanelClassic._visible = true;
      if(_loc4_ != null && m_nShiftState == 2)
      {
         MoneyPanel._y = _loc4_.GetShiftedMoneyPositionY();
         MoneyPanel._x = _loc4_.GetShiftedMoneyPositionX();
         MoneyPanel.InnerMoneyPanel.BGPanelClassic._visible = false;
      }
      else if(m_nShiftState == 1)
      {
         MoneyPanel._y = _loc3_.GetShiftedMoneyPosition();
         MoneyPanel._x = m_nDefaultShiftX;
      }
      else
      {
         MoneyPanel._y = _loc3_.GetMoneyPosition();
         MoneyPanel._x = m_nDefaultShiftX;
      }
      trace("setYPositionFromRadar: MoneyPanel._y = " + MoneyPanel._y + ", MoneyPanel._x = " + MoneyPanel._x);
   }
   var _loc5_ = _global.VotePanel;
   if(_loc5_)
   {
      _loc5_.setYPositionFromMoney();
   }
   var _loc2_ = _level40;
   if(_loc2_.AlertsMissionPanel._visible)
   {
      if(m_nShiftState == 2)
      {
         _loc2_.AlertsMissionPanel._alpha = 0;
      }
      else
      {
         _loc2_.AlertsMissionPanel._alpha = 100;
         _loc2_.setYPositionForAlert();
      }
   }
   setColorText();
}
function SetShift(nShiftState)
{
   if(m_nShiftState != nShiftState)
   {
      m_nShiftState = nShiftState;
   }
   setYPositionFromRadar();
}
function DisplayMoneyAdjustment(moneyDelta)
{
   if(moneyDelta > 0)
   {
      m_nTotalAdd = m_nTotalAdd + moneyDelta;
      MoneyPanel.InnerMoneyPanel.CashContainer.AddCash.AddText.SetText("+$" + m_nTotalAdd);
      MoneyPanel.InnerMoneyPanel.CashContainer.AddCash.AddTextGrow.SetText("+$" + Math.abs(moneyDelta));
      MoneyPanel.InnerMoneyPanel.CashContainer.AddCashFlash.AddTextFlash.SetText("+$" + Math.abs(moneyDelta));
      MoneyPanel.InnerMoneyPanel.CashContainer.AddCashFlash.AddTextFlashGrow.SetText("+$" + Math.abs(moneyDelta));
      if(m_bIsAnimatingAdd)
      {
         MoneyPanel.InnerMoneyPanel.CashContainer.AddCash.gotoAndPlay("ShowHold");
         MoneyPanel.InnerMoneyPanel.CashContainer.AddCashFlash.gotoAndPlay("Flash");
      }
      else
      {
         MoneyPanel.InnerMoneyPanel.CashContainer.AddCash.gotoAndPlay("Show");
      }
      m_bIsAnimatingAdd = true;
   }
   else if(moneyDelta < 0)
   {
      m_nTotalSubtract = m_nTotalSubtract + moneyDelta;
      MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCash.RemoveText.SetText("-$" + Math.abs(m_nTotalSubtract));
      MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCashFlash.RemoveTextFlash.SetText("-$" + Math.abs(moneyDelta));
      if(m_bIsAnimatingSubtract)
      {
         MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCash.gotoAndPlay("ShowHold");
         MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCashFlash.gotoAndPlay("Flash");
      }
      else
      {
         MoneyPanel.InnerMoneyPanel.CashContainer.RemoveCash.gotoAndPlay("Show");
      }
      m_bIsAnimatingSubtract = true;
   }
}
function GetVotePosition()
{
   return MoneyPanel.scaledHeight + MoneyPanel._y - MoneyPanel.scaledHeight / 2.1;
}
function setColorText()
{
   var _loc2_ = 13887384;
   if(_global.SFRadar)
   {
      _loc2_ = _global.SFRadar.GetHudTextHexColor();
   }
   MoneyPanel.InnerMoneyPanel.CashContainer.Cash.TextBox.textColor = _loc2_;
}
_global.MoneyPanel = this;
var timerInterval;
var m_nShiftState = 0;
var m_nDefaultShiftX = -1;
var MONEY_SHIFT_DEFAULT = 0;
var MONEY_SHIFT_BOMB = 1;
var MONEY_SHIFT_BUYMENU = 2;
var isShown = true;
var m_bIsAnimatingSubtract = false;
var m_bIsAnimatingAdd = false;
var m_nTotalSubtract = 0;
var m_nTotalAdd = 0;
_global.resizeManager.AddListener(this);
stop();
