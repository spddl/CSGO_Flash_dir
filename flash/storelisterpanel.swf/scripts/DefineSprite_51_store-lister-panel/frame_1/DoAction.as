function ShowPanel(bShowCoupons, aCoupons)
{
   this._visible = true;
   HideCratePreviewPanel();
   FadeListerUp(this);
   SetUpStorePanel(bShowCoupons,aCoupons);
   BlogDisableEnable(false);
}
function ShowOnlyPreview(IdForCrate)
{
   this._visible = true;
   BlogDisableEnable(false);
   TournamentLayout._visible = false;
   FourLayout._visible = false;
   ShowCratePreviewPanel(IdForCrate,true);
}
function BlogDisableEnable(bEnableInput)
{
   _global.MainMenuMovie.Panel.Blog.EnableInput(bEnableInput);
}
function HidePanel()
{
   delete Close.onEnterFrame;
   delete this.onEnterFrame;
   ShowHideStoreListerToolTip(null,false,null);
   this._visible = false;
   BlogDisableEnable(true);
}
function SetUpStorePanel(bShowCoupons, aCoupons)
{
   SetUpTitlePanel(bShowCoupons,aCoupons[0].itemid);
   if(!bShowCoupons)
   {
      onPlayerStickers();
   }
   else
   {
      SetUpTiles(bShowCoupons,aCoupons);
   }
   Close.dialog = this;
   Close.Action = function()
   {
      HidePanel();
   };
}
function SetUpTitlePanel(bShowCoupons, ItemID)
{
   var _loc3_ = "images/ui_icons/";
   TitlePanel.CouponTimer._visible = false;
   TitlePanel.Desc._visible = false;
   TitlePanel._visible = bShowCoupons;
   TournamentTitle._visible = !bShowCoupons;
   TournamentInfo._visible = !bShowCoupons;
   if(bShowCoupons)
   {
      TitlePanel.Title.htmlText = "#SFUI_Store_Your_Offers";
      TitlePanel.CouponTimer._visible = true;
      TitlePanel.CouponTimer.SetCouponExpirationTime(ItemID);
   }
   else
   {
      TournamentInfo.BtnLink.dialog = this;
      TournamentInfo.BtnLink.SetText("#CSGO_PickEm_Store_About");
      TournamentInfo.BtnLink.ButtonText.Text.autoSize = "left";
      TournamentInfo.BtnLink.ButtonText.Text._x = 20;
      TournamentInfo.BtnLink.Action = function()
      {
         _global.CScaleformComponent_SteamOverlay.OpenURL("http://www.counter-strike.net/pickem/cologne2016");
      };
      LoadImage(_loc3_ + "info.png",TournamentInfo.BtnLink.ImageHolder,28,28,false);
      TournamentTitle.BtnTeam.dialog = this;
      TournamentTitle.BtnTeam.SetText("#CSGO_PickEm_Store_Team_Title");
      TournamentTitle.BtnTeam.ButtonText.Text.autoSize = "left";
      TournamentTitle.BtnTeam.ButtonText.Text._x = 20;
      TournamentTitle.BtnTeam.Action = function()
      {
         this.dialog.onTeamStickers();
      };
      TournamentTitle.BtnTeam.Selected._visible = false;
      LoadImage(_loc3_ + "team.png",TournamentTitle.BtnTeam.ImageHolder,28,28,false);
      TournamentTitle.BtnPlayer.dialog = this;
      TournamentTitle.BtnPlayer.SetText("#CSGO_PickEm_Store_Player_Title");
      TournamentTitle.BtnPlayer.ButtonText.Text.autoSize = "left";
      TournamentTitle.BtnPlayer.ButtonText.Text._x = 20;
      TournamentTitle.BtnPlayer.Action = function()
      {
         this.dialog.onPlayerStickers();
      };
      TournamentTitle.BtnPlayer.Selected._visible = false;
      LoadImage(_loc3_ + "signature.png",TournamentTitle.BtnPlayer.ImageHolder,28,28,false);
   }
}
function LoadImage(imagePath, objImage, numWidth, numHeight, bCenterImage)
{
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc4_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objImage.Image);
   if(bCenterImage)
   {
      objImage._x = (objImage._parent._width - numWidth) * 0.5;
   }
}
function onTeamStickers()
{
   SetUpTiles(false,GetTeamItems());
   TournamentTitle.BtnPlayer.Selected._visible = false;
   TournamentTitle.BtnTeam.Selected._visible = true;
}
function onPlayerStickers()
{
   SetUpTiles(false,GetPlayerItems());
   TournamentTitle.BtnPlayer.Selected._visible = true;
   TournamentTitle.BtnTeam.Selected._visible = false;
}
function ShowCratePreviewPanel(IdForCrate, bOnlyPreview)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,IdForCrate);
   var _loc8_ = 18;
   if(_loc6_ < 2)
   {
      return undefined;
   }
   var _loc3_ = 0;
   while(_loc3_ < _loc8_)
   {
      var _loc4_ = CrateItemsPanel["Tile" + _loc3_];
      if(_loc3_ >= _loc6_)
      {
         _loc4_._visible = false;
      }
      else
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,IdForCrate,_loc3_);
         _loc4_.SetItemInfoHideEquippedStatus(_loc5_,m_PlayerXuid);
         _loc4_._visible = true;
      }
      _loc3_ = _loc3_ + 1;
   }
   var _loc10_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,IdForCrate));
   var _loc9_ = _global.GameInterface.Translate("#SFUI_InvUse_Header_decodable");
   _loc9_ = _global.ConstructString(_loc9_,_loc10_);
   CrateItemsPanel.Title.htmlText = _loc9_;
   CrateItemsPanel._visible = true;
   FadeListerUp(CrateItemsPanel);
   CrateItemsPanel.Close.dialog = this;
   if(bOnlyPreview)
   {
      CrateItemsPanel.Close.Action = function()
      {
         HidePanel();
      };
   }
   else
   {
      CrateItemsPanel.Close.Action = function()
      {
         HideCratePreviewPanel();
      };
   }
}
function HideCratePreviewPanel()
{
   CrateItemsPanel._visible = false;
}
function SetUpTiles(bShowCoupons, aCoupons)
{
   var _loc9_ = 0;
   var _loc8_ = 0;
   _loc9_ = aCoupons.length;
   TournamentLayout._visible = false;
   FourLayout._visible = false;
   if(!bShowCoupons)
   {
      this.gotoAndStop("TournamentLayout");
      var _loc10_ = this.TournamentLayout;
      TournamentLayout._visible = true;
      _loc8_ = 20;
   }
   else
   {
      this.gotoAndStop("FourLayout");
      aCoupons.sort(RandomizeArray());
      _loc10_ = this.FourLayout;
      FourLayout._visible = true;
      _loc8_ = 4;
   }
   var _loc4_ = 0;
   while(_loc4_ < _loc8_)
   {
      var _loc3_ = _loc10_["Tile" + _loc4_];
      _loc3_._alpha = 0;
      if(_loc4_ > _loc9_ - 1 || aCoupons[_loc4_].itemid == -1)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
         var _loc5_ = aCoupons[_loc4_].itemid;
         if(!bShowCoupons)
         {
            _loc5_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc5_,0);
            _loc3_.SetTournamentStickerData(_loc5_,m_PlayerXuid);
            SetUpToolTips(_loc3_);
         }
         else
         {
            _loc3_.SetCouponDataSingle(_loc5_,m_PlayerXuid);
            var _loc6_ = _global.CScaleformComponent_Inventory.GetRawDefinitionKey(_loc5_,"will_produce_stattrak");
            if(_loc6_ == 1)
            {
               SetUpToolTips(_loc3_,GetMusicKitStatTrakDescAddition());
            }
            else
            {
               SetUpToolTips(_loc3_,"");
            }
         }
      }
      _loc4_ = _loc4_ + 1;
   }
   RevealItems(_loc10_,_loc8_);
}
function GetMusicKitStatTrakDescAddition()
{
   var _loc2_ = _global.GameInterface.Translate("#Attrib_KillEater");
   var _loc3_ = _global.GameInterface.Translate("#KillEaterDescriptionNotice_OCMVPs");
   _loc2_ = "<font color=\'#98cbfe\'>" + _loc2_ + "\n\n" + "</font><font color=\'#ce6a32\'>" + _loc3_ + "</font>" + "\n\n";
   return _loc2_;
}
function RandomizeArray()
{
   var _loc1_ = Math.round(Math.random() * 2) - 1;
   return _loc1_;
}
function RandomSeed()
{
   seed = seed ^ seed << 21;
   seed = seed ^ seed >>> 35;
   seed = seed ^ seed << 4;
   if(seed < 0)
   {
      seed = (- seed) / 2;
   }
   return seed * MAX_RATIO;
}
function ShuffleTeamIdOrder()
{
   var _loc3_ = new Array();
   var _loc1_ = Math.floor(RandomSeed() * (m_aDreamhack2014Items.length - 1 + 0)) + 0;
   var _loc2_ = m_aDreamhack2014Items[_loc1_];
   m_aDreamhack2014Items.splice(_loc1_,1);
   return _loc2_;
}
function GetDreamhackStoreItems(bGetStrickers)
{
   var _loc6_ = _global.CScaleformComponent_Store.GetBannerEntryCount();
   var _loc5_ = [];
   var _loc3_ = 0;
   while(_loc3_ < _loc6_)
   {
      var _loc4_ = _global.CScaleformComponent_Store.GetBannerEntryDefIdx(_loc3_);
      var _loc2_ = _global.CScaleformComponent_Store.GetBannerEntryCustomFormatString(_loc3_);
      if(bGetStrickers)
      {
         if(_loc2_ != "single" && _loc2_ != "double" && _loc2_ != "triple" && _loc2_ != "dreamhack")
         {
            _loc5_.push(_loc4_);
         }
      }
      else if(_loc2_ == "dreamhack")
      {
         _loc5_.push(_loc4_);
      }
      _loc3_ = _loc3_ + 1;
   }
   return _loc5_;
}
function SetUpDreamhackTiles()
{
   var _loc6_ = GetDreamhackStoreItems(false);
   var _loc4_ = 0;
   while(_loc4_ < m_numTiles)
   {
      var _loc3_ = this["Tile" + (_loc4_ + 16)];
      _loc3_._alpha = 0;
      if(_loc4_ > _loc6_.length - 1)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
         var _loc5_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc6_[_loc4_],0);
         _loc3_.SetItemData(_loc5_,m_PlayerXuid,false,true);
         _loc3_.New._visible = false;
         _loc3_._ItemID = _loc5_;
      }
      SetUpToolTips(_loc3_);
      _loc4_ = _loc4_ + 1;
   }
}
function SetUpToolTips(objTile, strDescAddition)
{
   objTile.dialog = this;
   objTile.Hitbox.onRollOver = function()
   {
      ShowHideStoreListerToolTip(this._parent,true,this._parent._parent,strDescAddition);
   };
   objTile.Hitbox.onRollOut = function()
   {
      ShowHideStoreListerToolTip(this._parent,false,this._parent._parent);
   };
}
function ShowHideStoreListerToolTip(objTargetTile, bShow, objLocation, strDescAddition)
{
   if(objTargetTile != null && bShow)
   {
      var _loc3_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
      var _loc4_ = _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,objTargetTile._ItemID);
      if(_loc4_ > 1)
      {
         var _loc5_ = objTargetTile._ItemID;
      }
      else
      {
         _loc5_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,objTargetTile._ItemID,0);
      }
      objLocation.localToGlobal(_loc3_);
      _global.MainMenuMovie.Panel.TooltipItem._parent.globalToLocal(_loc3_);
      _global.MainMenuMovie.Panel.TooltipItem.TooltipItemGetInfo(m_PlayerXuid,_loc5_,"",strDescAddition);
      _global.MainMenuMovie.Panel.TooltipItem.TooltipItemLayout(_loc3_.x,_loc3_.y,objTargetTile._width);
   }
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(bShow);
}
function RevealItems(objLayout, numMaxTiles)
{
   var numLoop = 0;
   var numTile = 0;
   var _loc2_ = this;
   Close.onEnterFrame = function()
   {
      if(numLoop == 1)
      {
         FadeListerUp(objLayout["Tile" + numTile]);
         if(numTile >= numMaxTiles)
         {
            delete Close.onEnterFrame;
         }
         numTile++;
         numLoop = 0;
      }
      numLoop++;
   };
}
function FadeListerUp(TargetMc)
{
   TargetMc._alpha = 0;
   TargetMc.onEnterFrame = function()
   {
      if(TargetMc._alpha < 100)
      {
         TargetMc._alpha = TargetMc._alpha + 20;
      }
      else
      {
         delete TargetMc.onEnterFrame;
      }
   };
}
function GetStoreIdForTeamsInActiveTournament(strTeamTag, numTournamentId)
{
   if(numTournamentId == _global.CScaleformComponent_News.GetActiveTournamentEventID())
   {
      var _loc2_ = 0;
      while(_loc2_ < m_aTeamIdItems.length)
      {
         if(m_aTeamIdItems[_loc2_].teamid == strTeamTag)
         {
            return m_aTeamIdItems[_loc2_].itemid;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   return null;
}
function GetTeamItems()
{
   return m_aTeamIdItems;
}
function GetPlayerItems()
{
   return m_aTeamIdPlayers;
}
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
Black.onRollOver = function()
{
};
CrateItemsPanel.Black.onRollOver = function()
{
};
var m_aDreamhack2014Items = new Array();
var m_seed;
var MAX_RATIO = 2.3283064370807974e-10;
TournamentTitle.BtnTeam.Selected._width = TournamentTitle.BtnTeam._width / 1.17 + 10;
TournamentTitle.BtnPlayer.Selected._width = TournamentTitle.BtnPlayer._width / 1.17 + 10;
TournamentTitle.BtnTeam._x = TournamentTitle.BtnPlayer._x + TournamentTitle.BtnPlayer._width;
TournamentTitle._x = (this._width - TournamentTitle._width) / 2;
var m_aTeamIdItems = new Array({itemid:4253,teamid:"esl"},{itemid:4254,teamid:"legends"},{itemid:4255,teamid:"challengers"},{itemid:-1,teamid:""},{itemid:4246,teamid:"sk"},{itemid:4244,teamid:"navi"},{itemid:4242,teamid:"liq"},{itemid:4249,teamid:"astr"},{itemid:4245,teamid:"vp"},{itemid:4239,teamid:"clg"},{itemid:4251,teamid:"fntc"},{itemid:4237,teamid:"nip"},{itemid:4250,teamid:"nv"},{itemid:4241,teamid:"flip"},{itemid:4238,teamid:"optc"},{itemid:4243,teamid:"mss"},{itemid:4248,teamid:"faze"},{itemid:4252,teamid:"dig"},{itemid:4240,teamid:"gamb"},{itemid:4247,teamid:"g2"});
var m_aTeamIdPlayers = new Array({itemid:-1,teamid:""},{itemid:4257,teamid:"group2"},{itemid:4256,teamid:"group1"},{itemid:-1,teamid:""},{itemid:4267,teamid:""},{itemid:4265,teamid:""},{itemid:4263,teamid:""},{itemid:4270,teamid:""},{itemid:4266,teamid:""},{itemid:4260,teamid:""},{itemid:4272,teamid:""},{itemid:4258,teamid:""},{itemid:4271,teamid:""},{itemid:4262,teamid:""},{itemid:4259,teamid:""},{itemid:4264,teamid:""},{itemid:4269,teamid:""},{itemid:4273,teamid:""},{itemid:4261,teamid:""},{itemid:4268,teamid:""});
stop();
