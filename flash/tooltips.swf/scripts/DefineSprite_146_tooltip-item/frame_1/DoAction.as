function TooltipItemShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
      this.gotoAndPlay("StartShow");
   }
   else
   {
      this._visible = false;
   }
}
function TooltipItemGetInfo(PlayerXuid, strId, ItemType, strDescAddition)
{
   var _loc31_ = _global.CScaleformComponent_Inventory.GetItemName(PlayerXuid,strId);
   var _loc30_ = _global.CScaleformComponent_Inventory.GetItemType(PlayerXuid,strId);
   var _loc19_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,strId);
   var _loc11_ = _global.CScaleformComponent_Inventory.GetItemTeam(PlayerXuid,strId);
   var _loc15_ = _global.CScaleformComponent_Inventory.GetSlot(PlayerXuid,strId);
   var _loc28_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(PlayerXuid,strId);
   var _loc16_ = _global.CScaleformComponent_Inventory.GetSet(PlayerXuid,strId);
   var _loc17_ = _global.CScaleformComponent_Inventory.GetWear(PlayerXuid,strId);
   var _loc21_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(PlayerXuid,strId,0);
   var _loc23_ = _global.CScaleformComponent_Inventory.IsTool(PlayerXuid,strId);
   var _loc7_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(PlayerXuid,strId);
   var _loc24_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(PlayerXuid,strId,"quest");
   var _loc20_ = _global.CScaleformComponent_Inventory.ItemHasScorecardValues(PlayerXuid,strId,"competitive");
   var _loc37_ = _global.CScaleformComponent_Inventory.ItemHasScorecardValues(PlayerXuid,strId,"operation");
   var _loc18_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,strId,"season access");
   var _loc34_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(PlayerXuid,strId,"sticker");
   var _loc29_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(PlayerXuid,strId,"spray");
   var _loc26_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(PlayerXuid,strId,"spraypaint");
   var _loc12_ = 20;
   if(strDescAddition != "" && strDescAddition != undefined && strDescAddition != null)
   {
      _loc19_ = strDescAddition + _loc19_;
   }
   if(_loc23_ || _loc21_ == "decodable")
   {
      if(_loc34_)
      {
         Content.econToolUsageBlock.Text.htmlText = "#SFUI_InvTooltip_Consumable";
      }
      else if(_loc29_)
      {
         Content.econToolUsageBlock.Text.htmlText = "#SFUI_InvTooltip_ConsumableSpray";
      }
      else if(_loc26_)
      {
         var _loc32_ = _global.GameInterface.Translate("#SFUI_spray_hint") + "\n" + _global.GameInterface.Translate("#SFUI_InvTooltip_ConsumableSprayPaint");
         Content.econToolUsageBlock.Text.htmlText = _loc32_;
      }
      else if(_loc23_ && !_global.CScaleformComponent_Inventory.IsItemDefault(PlayerXuid,strId))
      {
         Content.econToolUsageBlock.Text.htmlText = "#SFUI_InvTooltip_Consumable";
      }
      else if(_loc21_ == "decodable")
      {
         var _loc13_ = _global.CScaleformComponent_Inventory.GetAssociatedItemsCount(PlayerXuid,strId);
         if(_loc13_ == 0 || _loc13_ == undefined || _loc13_ == null)
         {
            Content.econToolUsageBlock.Text.htmlText = "#SFUI_InvTooltip_Keyless_Case";
         }
         else if(_loc13_ > 0)
         {
            var _loc33_ = _global.CScaleformComponent_Inventory.GetAssociatedItemIdByIndex(PlayerXuid,strId,0);
            var _loc35_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(PlayerXuid,_loc33_));
            var _loc14_ = _global.GameInterface.Translate("#SFUI_InvTooltip_Crate");
            _loc14_ = _global.ConstructString(_loc14_,_loc35_);
            Content.econToolUsageBlock.Text.htmlText = _loc14_;
         }
      }
      else
      {
         Content.econToolUsageBlock.Text.htmlText = "#SFUI_InvTooltip_Default_Tool";
      }
      objText._y = (objBounds._height - objText._height) * 0.5;
      _global.AutosizeTextDown(Content.econToolUsageBlock.Text,7);
      Content.econToolUsageBlock.Text.autoSize = "left";
      Content.econToolUsageBlock.Text._y = (Content.econToolUsageBlock.Bg._height - Content.econToolUsageBlock.Text._height) * 0.5;
      Content.econToolUsageBlock._visible = true;
      Content.econItemUsageBlock._visible = false;
   }
   else if(_loc24_)
   {
      Content.econToolUsageBlock._visible = false;
      Content.econItemUsageBlock._visible = false;
   }
   else
   {
      Content.econToolUsageBlock._visible = false;
      Content.econItemUsageBlock._visible = true;
      var _loc8_ = "";
      var _loc9_ = "";
      var _loc36_ = "";
      if(_loc16_ != "" && _loc16_ != undefined)
      {
         Content.econItemUsageBlock.DynamicItemImage._visible = true;
      }
      else
      {
         Content.econItemUsageBlock.DynamicItemImage._visible = false;
      }
      if(_loc11_ != "" && _loc11_ != undefined)
      {
         _loc9_ = _loc9_ + _global.GameInterface.Translate(_loc11_) + "\n";
         _loc8_ = _loc8_ + _global.GameInterface.Translate("#SFUI_InvTooltip_Team") + "\n";
      }
      if(_loc15_ != "" && _loc15_ != undefined)
      {
         var _loc27_ = _global.GameInterface.Translate("#SFUI_InvTooltip_" + _loc15_);
         _loc9_ = _loc9_ + _loc27_ + "\n";
         _loc8_ = _loc8_ + _global.GameInterface.Translate("#SFUI_InvTooltip_WeaponType") + "\n";
      }
      if(_loc17_ != undefined && _loc17_ >= 0)
      {
         _loc9_ = _loc9_ + _global.GameInterface.Translate("#SFUI_InvTooltip_Wear_Amount_" + _loc17_.toString());
         _loc8_ = _loc8_ + _global.GameInterface.Translate("#SFUI_InvTooltip_Wear") + "\n";
      }
      Content.econItemUsageBlock.AnyPatch._visible = false;
      Content.econItemUsageBlock.CTPatch._visible = false;
      Content.econItemUsageBlock.TPatch._visible = false;
      LoadSetImage(_loc16_);
      if(_loc11_ == "#CSGO_Inventory_Team_Any")
      {
         Content.econItemUsageBlock.AnyPatch._visible = true;
      }
      if(_loc11_ == "#CSGO_Inventory_Team_CT")
      {
         Content.econItemUsageBlock.CTPatch._visible = true;
      }
      if(_loc11_ == "#CSGO_Inventory_Team_T")
      {
         Content.econItemUsageBlock.TPatch._visible = true;
      }
      Info_height = Content.econItemUsageBlock.ItemInfo._height;
      Title_height = Content.econItemUsageBlock.Title._height;
      Content.econItemUsageBlock.ItemInfo.htmlText = _loc9_;
      Content.econItemUsageBlock.Title.htmlText = _loc8_;
      Content.econItemUsageBlock.ItemInfo.autoSize = "center";
      Content.econItemUsageBlock.Title.autoSize = "center";
      Content.econItemUsageBlock.ItemInfo._y = 0;
      Content.econItemUsageBlock.Title._y = 0;
      Content.econItemUsageBlock.ItemInfo._y = Content.econItemUsageBlock.ItemInfo._y + (Content.econItemUsageBlock.Bg._height - Content.econItemUsageBlock.ItemInfo._height) / 2;
      Content.econItemUsageBlock.Title._y = Content.econItemUsageBlock.ItemInfo._y;
   }
   if(_loc7_ > 0)
   {
      var _loc10_ = 5;
      if(_loc7_ < 4)
      {
         Content.Stickers.gotoAndStop("Default");
      }
      else
      {
         Content.Stickers.gotoAndStop("Five");
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc10_)
      {
         var _loc3_ = Content.Stickers["Tile" + _loc2_];
         if(_loc2_ >= _loc7_)
         {
            _loc3_._visible = false;
         }
         else
         {
            var _loc6_ = _global.CScaleformComponent_Inventory.GetItemStickerImageByIndex(PlayerXuid,strId,_loc2_);
            trace("----------------------------------------strStickerImagePath: " + _loc6_);
            trace("----------------------------------------strStickerName: " + strStickerName);
            _loc3_._visible = true;
            LoadStickerImage(_loc3_,_loc6_,strStickerName);
         }
         _loc2_ = _loc2_ + 1;
      }
      Content.Stickers._visible = true;
   }
   else
   {
      Content.Stickers._visible = false;
   }
   SetColor(_loc28_);
   Content.econItemName.htmlText = _loc31_;
   Content.econItemType.htmlText = _loc30_;
   Content.econAttributes.htmlText = _loc19_;
   if(Content.econAttributes._height > 500)
   {
      var _loc25_ = new TextFormat();
      _loc25_.size = 7.5;
      Content.econAttributes.setTextFormat(_loc25_);
      _loc12_ = 10;
   }
   _global.AutosizeTextDown(Content.econItemName,8);
   Content.econAttributes.autoSize = true;
   if(Content.Stickers._visible)
   {
      Content.econAttributes._y = Content.Stickers._y + Content.Stickers._height;
      Content.Background._height = Content.econAttributes.textHeight + Content.Stickers._height + (Content.Stickers._y - Content._y) + _loc12_;
   }
   else
   {
      if(_loc24_)
      {
         Content.econAttributes._y = Content.econToolUsageBlock._y + _loc12_ / 2;
      }
      else
      {
         Content.econAttributes._y = Content.Stickers._y;
      }
      Content.Background._height = Content.econAttributes.textHeight + (Content.econAttributes._y - Content._y) + _loc12_;
   }
   if(_loc20_ == -1 || _loc18_ >= 3)
   {
      Content.Scorecard._visible = false;
   }
   else if(_loc20_ == 0)
   {
      ScorecardLayout(PlayerXuid,strId,_loc18_,false);
   }
   else if(_loc20_ >= 1)
   {
      ScorecardLayout(PlayerXuid,strId,_loc18_,true);
   }
}
function ScorecardLayout(PlayerXuid, strId, numSeason, bShowStats)
{
   var _loc6_ = 12;
   var _loc16_ = 15;
   var _loc8_ = 10;
   Content.Scorecard.Title.htmlText = "#CSGO_Operation_Scorecard_Title";
   Content.Scorecard.Title.autoSize = "center";
   if(bShowStats)
   {
      var _loc3_ = [];
      var _loc17_ = _global.CScaleformComponent_Inventory.GetScorecardAttributes(PlayerXuid,strId,"competitive");
      _loc3_ = _loc17_.split(",");
      var _loc7_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,strId,_loc3_[0]);
      var _loc15_ = math.floor(_loc7_ / 60);
      var _loc11_ = _global.GameInterface.Translate("#CSGO_competitive_Time_Played");
      if(_loc7_ > 60)
      {
         _loc15_ = Math.floor(_loc7_ / 60);
         _loc7_ = Math.ceil(_loc7_ - _loc15_ * 60);
         _loc11_ = _global.ConstructString(_loc11_,_loc15_,_loc7_);
      }
      else
      {
         _loc11_ = _global.ConstructString(_loc11_,"0",_loc7_);
      }
      Content.Scorecard.Time.Time.htmlText = _loc11_;
      Content.Scorecard.Time._visible = true;
      Content.Scorecard.Desc.htmlText = "#CSGO_Operation_Scorecard_Desc";
      Content.Scorecard.Desc.autoSize = "center";
      Content.Scorecard.Private._visible = true;
      if(Content.Scorecard.OperationLogo != undefined)
      {
         Content.Scorecard.OperationLogo.unloadMovie();
      }
      var _loc13_ = new Object();
      _loc13_.onLoadInit = function(target_mc)
      {
         target_mc._width = 256;
         target_mc._height = 200;
         target_mc.forceSmoothing = true;
      };
      var _loc18_ = "econ/season_icons/season_" + numSeason + ".png";
      var _loc12_ = new MovieClipLoader();
      _loc12_.addListener(_loc13_);
      _loc12_.loadClip(_loc18_,Content.Scorecard.OperationLogo);
      Content.Scorecard.OperationLogo._visible = true;
      var _loc2_ = 1;
      while(_loc2_ <= _loc6_)
      {
         var _loc5_ = Content.Scorecard.Rows["Row" + _loc2_];
         if(_loc2_ >= _loc3_.length)
         {
            _loc5_._visible = false;
         }
         else
         {
            var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,strId,_loc3_[_loc2_]);
            _loc5_.Attribute.htmlText = "#CSGO_" + _loc3_[_loc2_];
            if(_loc3_[_loc2_] == "competitive_hsp")
            {
               _loc5_.Value.htmlText = Math.floor(_loc4_) + "%";
            }
            else
            {
               _loc5_.Value.htmlText = Math.floor(_loc4_);
            }
            _loc5_._visible = true;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc14_ = Content.Scorecard.Rows.Row1._height * _loc3_.length;
      Content.Scorecard.Desc._y = Content.Scorecard.Title._y + Content.Scorecard.Title._height + _loc8_;
      Content.Scorecard.Time._y = Content.Scorecard.Desc._y + Content.Scorecard.Desc._height + _loc8_;
      Content.Scorecard.Rows._y = Content.Scorecard.Time._y + Content.Scorecard.Time._height + _loc8_;
      Content.Scorecard.Private._y = Content.Scorecard.Rows._y + (_loc14_ - Content.Scorecard.Rows.Row1._height);
      Content.Scorecard.Bg._height = _loc16_ + Content.Scorecard.Title._height + Content.Scorecard.Desc._height + Content.Scorecard.Time._height + _loc14_ + _loc8_ * 4;
   }
   else
   {
      Content.Scorecard.Desc.htmlText = "#CSGO_Operation_Scorecard_NotActive";
      Content.Scorecard.Desc.autoSize = "center";
      _loc2_ = 1;
      while(_loc2_ <= _loc6_)
      {
         _loc5_ = Content.Scorecard.Rows["Row" + _loc2_];
         _loc5_._visible = false;
         _loc2_ = _loc2_ + 1;
      }
      Content.Scorecard.Private._visible = false;
      Content.Scorecard.Time._visible = false;
      Content.Scorecard.OperationLogo._visible = false;
      Content.Scorecard.Desc._y = Content.Scorecard.Title._y + Content.Scorecard.Title._height + _loc8_;
      Content.Scorecard.Bg._height = _loc16_ + Content.Scorecard.Title._height + Content.Scorecard.Desc._height + _loc8_ * 3;
   }
   Content.Scorecard._y = Content.Background._y + Content.Background._height;
   Content.Scorecard._visible = true;
}
function TooltipItemLayout(PositionX, PositionY, TileWidth)
{
   var _loc5_ = {x:PositionX,y:PositionY};
   _root.localToGlobal(_loc5_);
   var _loc6_ = false;
   Arrows.RightArrow._y = 0;
   Arrows.LeftArrow._y = 0;
   this._x = PositionX;
   this._y = PositionY;
   if(_global.CheckOverRightScreenBounds(_loc5_,this))
   {
      this._x = this._x - 12 - (TileWidth + Content._width);
      _loc6_ = true;
   }
   else
   {
      this._x = this._x + 12;
   }
   var _loc4_ = Content.Background._height;
   if(Content.Scorecard._visible == true)
   {
      _loc4_ = _loc4_ + Content.Scorecard.Bg._height;
   }
   if(_global.CheckOverBottomScreenBounds(_loc5_,_loc4_,this))
   {
      this._y = this._y - (_loc5_.y + _loc4_ - 720);
      Arrows.LeftArrow._y = Arrows.LeftArrow._y + (_loc5_.y + _loc4_ - 720);
      Arrows.RightArrow._y = Arrows.LeftArrow._y;
   }
   Arrows.LeftArrow._visible = !_loc6_;
   Arrows.RightArrow._visible = _loc6_;
}
function SetColor(strColor)
{
   strColor = strColor.substring(1,strColor.length);
   strColor = "0x" + strColor;
   parsedRGB = parseInt(strColor);
   var _loc2_ = new Color("Content.RarityColor");
   _loc2_.setRGB(parsedRGB);
}
function LoadSetImage(srtSet)
{
   if(srtSet != "0" && srtSet != undefined)
   {
      Content.econItemUsageBlock.DefaultItemImage._visible = false;
      Content.econItemUsageBlock.DynamicItemImage._visible = true;
      if(Content.econItemUsageBlock.DynamicItemImage.Image != undefined)
      {
         Content.econItemUsageBlock.DynamicItemImage.Image.unloadMovie();
      }
      var _loc1_ = new Object();
      _loc1_.onLoadInit = function(target_mc)
      {
         target_mc._width = 60;
         target_mc._height = 44;
         target_mc.forceSmoothing = true;
      };
      _loc1_.onLoadError = function(target_mc, errorCode, status)
      {
         trace("LoadSetImage: Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
      };
      var _loc4_ = "econ/set_icons/" + srtSet + "_small.png";
      var _loc2_ = new MovieClipLoader();
      _loc2_.addListener(_loc1_);
      _loc2_.loadClip(_loc4_,Content.econItemUsageBlock.DynamicItemImage.Image);
   }
   else
   {
      Content.econItemUsageBlock.DynamicItemImage._visible = false;
   }
}
function LoadStickerImage(objTile, Path, Name)
{
   if(objTile.Image != undefined)
   {
      objTile.Image.unloadMovie();
   }
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 50;
      target_mc._height = 38;
      target_mc.forceSmoothing = true;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("LoadSetImage: Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
   };
   var _loc4_ = Path + ".png";
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objTile.Image);
   objTile.Text.htmlText = Name;
}
stop();
