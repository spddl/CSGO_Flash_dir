function SetUpPage(numSeason, CoinId, CampaignIndex, bIsRightPage)
{
   AttachCampaignPage(CampaignIndex,bIsRightPage);
   SetMissionsState(numSeason,CampaignIndex);
   UpdateMissionInfoPanel(numSeason,CampaignIndex,CoinId);
}
function AttachCampaignPage(CampaignIndex, bIsRightPage)
{
   if(CampaignIndex != 0)
   {
      var _loc3_ = {_x:0,_y:0};
      if(bIsRightPage)
      {
         _loc3_ = {_x:- Mask._width,_y:0};
      }
      var _loc4_ = this.attachMovie("journal-page-campaign-" + CampaignIndex,"Campaign" + CampaignIndex,this.getNextHighestDepth(),_loc3_);
      _loc4_.setMask(Mask);
   }
   LoadCampaignMapArt(CampaignIndex);
   SetCampaignInfoPanel(CampaignIndex);
}
function LoadCampaignMapArt(CampaignIndex)
{
   var _loc2_ = this["Campaign" + CampaignIndex];
   var _loc3_ = "images/journal/campaign/map_" + CampaignIndex + ".png";
   LoadImage(_loc2_.Bg.MapImage,_loc3_,800,550);
   _loc2_.Bg.MapImage._alpha = 80;
   if(CampaignIndex < 5)
   {
      _loc3_ = "images/journal/campaign/writing_desc_" + CampaignIndex + ".png";
      LoadImage(_loc2_.Bg.Desc,_loc3_,256,64);
      _loc2_.Bg.Desc._alpha = 70;
   }
}
function SetCampaignInfoPanel(CampaignIndex)
{
   var _loc3_ = this["Campaign" + CampaignIndex];
   var _loc2_ = "images/journal/campaign/logo_" + CampaignIndex + ".png";
   LoadImage(_loc3_.Bg.InfoPanel.LogoImage,_loc2_,200,72.7);
}
function LoadImage(objMap, ImagePath, numWidth, numHeight)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = ImagePath;
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,objMap);
}
function SetMissionsState(numSeason, CampaignIndex)
{
   var numNodeCount = _global.CScaleformComponent_Inventory.GetCampaignNodeCount(CampaignIndex);
   var bOwnCampaign = _global.CScaleformComponent_Inventory.CheckCampaignOwnership(CampaignIndex);
   var objCampaign = this["Campaign" + CampaignIndex];
   var numLastCompletedQuestID = _global.CScaleformComponent_Inventory.GetLastCompletedNodeIDForCampaign(CampaignIndex);
   var i = 0;
   objCampaign.Spinner.Text.htmlText = "#SFUI_LOADING";
   var _loc3_ = 0;
   while(_loc3_ < numNodeCount)
   {
      var _loc4_ = objCampaign["Mission" + _loc3_];
      _loc4_._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   objCampaign.onEnterFrame = function()
   {
      var _loc2_ = 0;
      while(_loc2_ < 2)
      {
         var _loc3_ = objCampaign["Mission" + i];
         var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignNodeIDbyIndex(CampaignIndex,i);
         if(_loc3_ == undefined)
         {
            trace("ERROR: Missing tile for mission " + i + " in campaign number " + CampaignIndex);
         }
         else
         {
            SetNodeData(_loc3_,CampaignIndex,_loc4_);
            SetDefaultNodeState(_loc3_,objCampaign,numSeason);
            _loc3_.Name.htmlText = SetNodeName(_loc3_);
            _loc3_.Name.autoSize = "center";
            if(bOwnCampaign)
            {
               _loc3_._State = _global.CScaleformComponent_Inventory.GetCampaignNodeState(CampaignIndex,_loc3_._NodeID);
            }
            else
            {
               _loc3_._State = "locked";
            }
            SetNodeCurretState(_loc3_);
            if(_loc3_._Points != 0 && _loc3_._Points != undefined && _loc3_._Points != null && !_loc3_._IsComicNode)
            {
               SetIconsAndColorForStarNode(_loc3_);
            }
            else
            {
               SetIconsAndColorForNode(_loc3_,numLastCompletedQuestID);
            }
            if(numSeason != _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue())
            {
               _loc3_.Highlight._visible = false;
               _loc3_.Active._visible = false;
               _loc3_.Accessible._visible = false;
               _loc3_.Locked._visible = true;
            }
            if(CampaignIndex < 5)
            {
               LoadNotesImages(_loc3_,CampaignIndex,i);
            }
            if(i == numNodeCount - 1)
            {
               DrawCampaignPath(numNodeCount,CampaignIndex);
               objCampaign.Spinner._visible = false;
               _loc2_ = 0;
               while(_loc2_ < numNodeCount)
               {
                  _loc3_ = objCampaign["Mission" + _loc2_];
                  _loc3_._alpha = 100;
                  _loc3_._visible = true;
                  _loc2_ = _loc2_ + 1;
               }
               delete objCampaign.onEnterFrame;
            }
            i++;
         }
         _loc2_ = _loc2_ + 1;
      }
   };
}
function HasMapSpecified(strMap)
{
   if(strMap == "" || strMap == undefined || strMap == null || strMap == " ")
   {
      return false;
   }
   return true;
}
function SetNodeData(objMission, CampaignIndex, numNodeId)
{
   var _loc7_ = _global.CScaleformComponent_Inventory.GetCampaignNodeContentFile(CampaignIndex,numNodeId);
   objMission._NodeID = numNodeId;
   objMission._ItemID = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(CampaignIndex,Number(numNodeId));
   objMission._CampaignID = CampaignIndex;
   objMission._IsComicNode = false;
   objMission._HasAudio = false;
   if(_loc7_ != "" && _loc7_ != undefined && _loc7_ != null)
   {
      var _loc6_ = new Object();
      var _loc5_ = _loc7_.split(",");
      var _loc2_ = 0;
      while(_loc2_ < _loc5_.length)
      {
         var _loc3_ = _loc5_[_loc2_].split(":");
         _loc6_[_loc3_[0]] = _loc3_[1];
         _loc2_ = _loc2_ + 1;
      }
      if(_loc6_.type == "audio")
      {
         objMission._HasAudio = true;
      }
      if(_loc6_.type == "comic")
      {
         objMission._IsComicNode = true;
         objMission._ComicSection = _loc6_.section;
         objMission._ComicPages = _loc6_.numpages;
      }
      objMission._File = _loc6_.file;
   }
   if(!objMission._IsComicNode)
   {
      objMission._Difficulty = _global.CScaleformComponent_Inventory.GetCampaignNodeDifficulty(CampaignIndex,objMission._NodeID);
      objMission._Points = _global.CScaleformComponent_Inventory.GetCampaignNodeOperationalPoints(CampaignIndex,objMission._NodeID);
      objMission._GameMode = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,objMission._ItemID);
      objMission._MapGroup = _global.CScaleformComponent_Inventory.GetQuestMapGroup(m_PlayerXuid,objMission._ItemID);
      objMission._Map = _global.CScaleformComponent_Inventory.GetQuestMap(m_PlayerXuid,objMission._ItemID);
   }
}
function SetDefaultNodeState(objMission, objCampaign, numSeason)
{
   if(!objMission._IsComicNode)
   {
      objMission.Node._visible = true;
      objMission.Active._visible = false;
      objMission.Complete._visible = false;
      objMission.Accessible._visible = false;
      objMission.Locked._visible = false;
      objMission.Locked.LockedCircle._visible = false;
      objMission.Locked.Locked._visible = false;
      objMission.NodeIcon._visible = false;
      objMission.Node.NodeCircle._visible = false;
      objMission.Node.Node._visible = false;
      objMission.Highlight.NodeCircle._visible = false;
      objMission.Highlight.Node._visible = false;
      objMission.Flare._visible = false;
      objMission.Node.Node.transform.colorTransform = this[GetDifficultyColor(objMission._Difficulty) + "Dark"];
      objMission.Node.NodeCircle.transform.colorTransform = this[GetDifficultyColor(objMission._Difficulty) + "Dark"];
      objMission.Node.onRollOver = function()
      {
         ShowHideToolTip(this._parent,true,objCampaign,numSeason);
      };
      objMission.Node.onRollOut = function()
      {
         ShowHideToolTip(this._parent,false,objCampaign,numSeason);
      };
      objMission.Name.textColor = "0x333333";
      objMission.Node._alpha = 100;
      objMission.Highlight._visible = false;
   }
   else
   {
      objMission.Accessible._visible = false;
      objMission.NodeIcon._visible = false;
      objMission.onRollOver = function()
      {
         ShowHideToolTip(this,true,objCampaign,numSeason);
      };
      objMission.onRollOut = function()
      {
         ShowHideToolTip(this,false,objCampaign,numSeason);
      };
      objMission.Name.textColor = "0x333333";
   }
}
function SetNodeCurretState(objMission)
{
   if(!objMission._IsComicNode)
   {
      switch(objMission._State)
      {
         case "locked":
            objMission.Locked._visible = true;
            objMission.Name.textColor = "0x666666";
            break;
         case "active":
            objMission.Active._visible = true;
            objMission.Highlight._visible = true;
            objMission.Highlight.Node._visible = true;
            objMission.Highlight.Node.transform.colorTransform = this.white;
            FadeUp(objMission.Highlight);
            objMission.Active.Active.transform.colorTransform = this[GetDifficultyColor(objMission._Difficulty)];
            break;
         case "complete":
            objMission.Complete._visible = true;
            objMission.Complete.Complete.transform.colorTransform = this[GetDifficultyColor(objMission._Difficulty)];
            objMission.Node.Node.transform.colorTransform = this.grey;
            objMission.Node.NodeCircle.transform.colorTransform = this.grey;
            break;
         case "accessible":
            objMission.Accessible._visible = true;
            objMission.Highlight._visible = true;
            objMission.Highlight.Node._visible = true;
            objMission.Highlight.Node.transform.colorTransform = this.white;
            FadeUp(objMission.Highlight);
      }
   }
   else
   {
      switch(objMission._State)
      {
         case "locked":
            objMission.NodeIcon._visible = true;
            objMission.NodeIcon._alpha = 65;
            objMission.Name.textColor = "0x666666";
            break;
         case "accessible":
            objMission.Accessible._visible = true;
      }
   }
}
function SetIconsAndColorForStarNode(objMission)
{
   objMission.Complete._visible = false;
   objMission.Node.NodeCircle._visible = true;
   objMission.Locked.LockedCircle._visible = true;
   var _loc3_ = "";
   if(objMission._GameMode == "coopmission")
   {
      _loc3_ = "images/journal/campaign/difficulty_" + objMission._Points + "_strike.png";
   }
   else
   {
      _loc3_ = "images/journal/campaign/difficulty_" + objMission._Points + ".png";
   }
   if(objMission._State == "complete")
   {
      _loc3_ = "images/journal/campaign/difficulty_complete_" + objMission._Points + ".png";
      objMission.NodeIcon._alpha = 100;
      FlareScale(objMission.Flare);
   }
   else if(objMission._State == "active" || objMission._State == "accessible")
   {
      objMission.Highlight._visible = true;
      objMission.Highlight.NodeCircle._visible = true;
      objMission.Highlight.Node._visible = false;
      objMission.Highlight.NodeCircle.transform.colorTransform = this.white;
      objMission.NodeIcon._alpha = 100;
   }
   else
   {
      objMission.NodeIcon._alpha = 100;
   }
   LoadImage(objMission.NodeIcon,_loc3_,42,42);
   objMission.NodeIcon._x = -21;
   objMission.NodeIcon._y = -21;
}
function SetIconsAndColorForNode(objMission, numLastCompletedQuestID)
{
   if(!objMission._IsComicNode)
   {
      objMission.Node.Node._visible = true;
      objMission.Locked.Locked._visible = true;
      var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestIcon(m_PlayerXuid,objMission._ItemID);
      if(_loc4_ == "" || _loc4_ == undefined)
      {
         if(objMission._GameMode == "casual" || objMission._GameMode == "competitive")
         {
            _loc4_ = "bomb";
         }
         else
         {
            _loc4_ = objMission._GameMode;
         }
      }
      objMission.Node.attachMovie("icon-" + _loc4_,"missionicon",1000000);
      var _loc5_ = objMission.Node.Node._width - 8;
      if(objMission.Node.missionicon._height > objMission.Node.missionicon._width)
      {
         var _loc9_ = objMission.Node.missionicon._height / objMission.Node.missionicon._width;
         objMission.Node.missionicon._width = _loc5_ / _loc9_;
         objMission.Node.missionicon._height = _loc5_;
      }
      else
      {
         _loc9_ = objMission.Node.missionicon._width / objMission.Node.missionicon._height;
         objMission.Node.missionicon._width = _loc5_;
         objMission.Node.missionicon._height = _loc5_ / _loc9_;
      }
      objMission.Node.missionicon._x = objMission.Node.missionicon._x - _loc5_ / 2;
      objMission.Node.missionicon._y = objMission.Node.missionicon._y - objMission.Node.missionicon._height / 2;
      objMission.Node.missionicon._alpha = 20;
      if(objMission._State == "complete")
      {
         objMission.Node.missionicon.transform.colorTransform = this.darkgrey;
      }
      else
      {
         objMission.Node.missionicon.transform.colorTransform = this[GetDifficultyColor(objMission._Difficulty)];
      }
      if(numLastCompletedQuestID > 0 && numLastCompletedQuestID != null && numLastCompletedQuestID != undefined)
      {
         var _loc8_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(numLastCompletedQuestID);
         var _loc7_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(numLastCompletedQuestID);
         if(_loc8_ == objMission._NodeID && _loc7_ == objMission._CampaignID)
         {
            AnimScrollUp(objMission.Complete,50);
         }
      }
   }
   else
   {
      objMission.NodeIcon._visible = true;
      var _loc10_ = objMission._File;
      LoadImage(objMission.NodeIcon.Image,_loc10_,48,48);
   }
}
function SetNodeName(objMission)
{
   var _loc3_ = "";
   if(!HasMapSpecified(objMission._Map) && !objMission._IsComicNode)
   {
      _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(objMission._MapGroup,"nameID"));
   }
   else if(!objMission._IsComicNode)
   {
      _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + objMission._Map,"nameID"));
   }
   else
   {
      _loc3_ = "#cp" + objMission._CampaignID + "_comicsection_title_" + objMission._ComicSection;
   }
   return _loc3_;
}
function LoadNotesImages(objMission, CampaignIndex, Index)
{
   if(objMission._State == "complete")
   {
      if(Index % 2 == 0)
      {
         var _loc2_ = "images/journal/campaign/writing_" + CampaignIndex + "_" + Index + ".png";
         LoadImage(objMission.imgNotes,_loc2_,64,46.5);
         objMission.imgNotes._alpha = 80;
      }
   }
}
function DrawCampaignPath(numNodeCount, CampaignIndex)
{
   var _loc12_ = this["Campaign" + CampaignIndex];
   var _loc11_ = this["Campaign" + CampaignIndex].DrawLines;
   _loc11_.clear();
   trace("------------numNodeCount: " + numNodeCount);
   var _loc6_ = 0;
   while(_loc6_ < numNodeCount)
   {
      var _loc4_ = _loc12_["Mission" + _loc6_];
      var _loc9_ = _global.CScaleformComponent_Inventory.GetCampaignNodeSuccessors(CampaignIndex,_loc4_._NodeID);
      var _loc7_ = _loc9_.split(",");
      if(_loc6_ == 28 && CampaignIndex == 7)
      {
         trace("------------CampaignIndex: " + CampaignIndex + "-objMission._NodeID: " + _loc4_ + "-strNodeLinks: " + _loc9_);
      }
      var _loc5_ = 0;
      while(_loc5_ < _loc7_.length)
      {
         var _loc3_ = FindLinkedNode(_loc7_[_loc5_],CampaignIndex,numNodeCount);
         if(_loc3_ != null && _loc3_ != undefined)
         {
            DrawLines(_loc4_._x,_loc4_._y,_loc3_._x,_loc3_._y,_loc11_,GetDifficultyColor(_loc3_._Difficulty),_loc4_._State);
         }
         _loc5_ = _loc5_ + 1;
      }
      _loc6_ = _loc6_ + 1;
   }
}
function FindLinkedNode(NodeID, CampaignIndex, numNodeCount)
{
   var _loc6_ = this["Campaign" + CampaignIndex];
   var _loc4_ = Number(NodeID);
   var _loc2_ = 0;
   while(_loc2_ <= numNodeCount)
   {
      var _loc3_ = _loc6_["Mission" + _loc2_];
      if(_loc2_ == 29 && CampaignIndex == 7)
      {
         trace("--FindLinkedNode-CampaignIndex: " + CampaignIndex + "-numNodeCount: " + _loc2_ + "-objMission._NodeID: " + _loc3_._NodeID + "-numNodeId: " + _loc4_);
      }
      if(_loc3_._NodeID == _loc4_)
      {
         return _loc3_;
      }
      _loc2_ = _loc2_ + 1;
   }
   return null;
}
function GetDifficultyColor(numDifficulty)
{
   switch(numDifficulty)
   {
      case 1:
         return "Bronze";
      case 2:
         return "Silver";
      case 3:
         return "Gold";
      default:
         return "Bronze";
   }
}
function SeperateName(strName)
{
   if(strName.indexOf("|  ") != -1)
   {
      var _loc2_ = strName.split("|  ",2);
   }
   else if(strName.indexOf("| ") != -1)
   {
      _loc2_ = strName.split("| ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   if(_loc2_.length == 1)
   {
      return _loc2_[0];
   }
   return _loc2_[1];
}
function ShowHideToolTip(objTargetTile, bShow, objLocation, numSeason)
{
   var _loc4_ = _global.MainMenuMovie.Panel.TooltipCampaign;
   var _loc5_ = {x:objTargetTile._x,y:objTargetTile._y};
   objLocation.localToGlobal(_loc5_);
   var _loc6_ = false;
   if(numSeason >= 5)
   {
      _loc6_ = true;
   }
   _loc4_.TooltipItemShowHide(bShow);
   _loc4_._parent.globalToLocal(_loc5_);
   if(bShow)
   {
      if(objTargetTile._State == "active" && _global.CScaleformComponent_Inventory.DoesUserOwnQuest(objTargetTile._CampaignID,objTargetTile._NodeID))
      {
         var _loc8_ = SetActiveQuestID();
         _loc4_.TooltipCampaignMissionInfo(m_PlayerXuid,_loc8_,objTargetTile._CampaignID,objTargetTile._NodeID,numSeason,objTargetTile._IsComicNode,objTargetTile._File,objTargetTile._ComicSection);
      }
      else
      {
         _loc4_.TooltipCampaignMissionInfo(m_PlayerXuid,objTargetTile._ItemID,objTargetTile._CampaignID,objTargetTile._NodeID,numSeason,objTargetTile._IsComicNode,objTargetTile._File,objTargetTile._ComicSection);
      }
      _loc4_.TooltipCampaignMissionLayout(_loc5_.x,_loc5_.y,this[GetDifficultyColor(objTargetTile._Difficulty)],true);
   }
}
function SetActiveQuestID()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,_loc3_,"quest id");
   var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(_loc2_);
   var _loc5_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(_loc2_);
   var _loc6_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc5_,_loc4_);
   return _loc6_;
}
function DrawLines(mX, mY, dX, dY, LinesMovie, strDifficulty, strState)
{
   var _loc10_ = Math.sqrt(Math.pow(mX - dX,2) + Math.pow(mY - dY,2));
   var _loc14_ = (mX + dX) / 2;
   var _loc13_ = (mY + dY) / 2;
   var _loc12_ = dX - mX;
   var _loc11_ = dY - mY;
   var _loc7_ = Math.atan2(_loc11_,_loc12_) * 180 / 3.141592653589793;
   var _loc2_ = LinesMovie.attachMovie("journal-direction-line","DirLine" + mX,LinesMovie.getNextHighestDepth(),Pos);
   var _loc3_ = LinesMovie.attachMovie("journal-direction-arrow","DirArrow" + mX,LinesMovie.getNextHighestDepth(),Pos);
   _loc2_._x = mX;
   _loc2_._y = mY;
   _loc2_._width = _loc10_ - 30;
   _loc2_._rotation = _loc7_;
   _loc3_._x = dX;
   _loc3_._y = dY;
   _loc3_._rotation = _loc7_;
   _loc2_.Rect.transform.colorTransform = this[strDifficulty];
   _loc3_.Rect.transform.colorTransform = this[strDifficulty];
   if(strState == "locked")
   {
      _loc2_._alpha = 30;
      _loc3_._alpha = 30;
   }
   else
   {
      _loc2_._alpha = 80;
      _loc3_._alpha = 80;
   }
}
function DrawDashedLines(mX, mY, dX, dY, LinesMovie, strDifficulty, bIsComplete)
{
   var _loc17_ = undefined;
   var _loc16_ = undefined;
   var _loc14_ = mX;
   var _loc13_ = mY;
   var _loc15_ = 0;
   var _loc26_ = 10;
   var _loc25_ = Math.sqrt(Math.pow(mX - dX,2) + Math.pow(mY - dY,2));
   var _loc6_ = Math.floor(_loc25_ / _loc26_);
   var _loc2_ = 1;
   while(_loc2_ <= _loc6_)
   {
      _loc17_ = mX + _loc2_ / _loc6_ * (dX - mX);
      _loc16_ = mY + _loc2_ / _loc6_ * (dY - mY);
      if(_loc15_ % 2 == 0)
      {
         var _loc19_ = (mX + dX) / 2;
         var _loc18_ = (mY + dY) / 2;
         var _loc12_ = dX - mX;
         var _loc11_ = dY - mY;
         var _loc10_ = Math.atan2(_loc11_,_loc12_) * 180 / 3.141592653589793;
         var _loc9_ = {_x:_loc14_,_y:_loc13_};
         var _loc3_ = LinesMovie.attachMovie("journal-direction-arrow","DirArrow" + mX,LinesMovie.getNextHighestDepth(),_loc9_);
         _loc3_._rotation = _loc10_;
         _loc3_.transform.colorTransform = this[strDifficulty];
         if(bIsComplete)
         {
            _loc3_._alpha = 200;
         }
         else
         {
            _loc3_._alpha = 200;
         }
      }
      _loc14_ = _loc17_;
      _loc13_ = _loc16_;
      _loc15_ = _loc15_ + 1;
      _loc2_ = _loc2_ + 1;
   }
}
function UpdateMissionInfoPanel(numSeason, CampaignIndex, CoinId)
{
   var _loc14_ = _global.CScaleformComponent_Inventory.CheckCampaignOwnership(CampaignIndex);
   var _loc11_ = _global.CScaleformComponent_Inventory.GetMissionBacklog();
   var _loc15_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,CoinId) + ".png";
   var _loc3_ = this["Campaign" + CampaignIndex];
   var _loc13_ = _global.CScaleformComponent_Inventory.GetSecondsUntilNextMission();
   var _loc4_ = "";
   if(_global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue() != numSeason)
   {
      _loc3_.Bg.InfoPanel.InactivePanel._visible = true;
   }
   else
   {
      _loc3_.Bg.InfoPanel.InactivePanel._visible = false;
   }
   StopUpdateCountdownTimer(_loc3_);
   if(!_loc14_)
   {
      var CampaignItemID = 0;
      var _loc9_ = 0;
      if(CampaignIndex == 3)
      {
         _loc9_ = 1320;
         CampaignItemID = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc9_,0);
      }
      else if(CampaignIndex == 1)
      {
         _loc9_ = 1321;
         CampaignItemID = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc9_,0);
      }
      var _loc6_ = _global.CScaleformComponent_Store.GetStoreItemSalePrice(CampaignItemID,1);
      if(_loc6_ == 0 || _loc6_ == null || _loc6_ == undefined || _loc6_ == "")
      {
         _loc3_.Bg.InfoPanel.BuyPanel.btnBuy._visible = false;
         _loc3_.Bg.InfoPanel.BuyPanel.Price.htmlText = "";
         _loc3_.Bg.InfoPanel.BuyPanel.Desc.htmlText = "#campaign_no_price";
      }
      else
      {
         _loc3_.Bg.InfoPanel.BuyPanel.btnBuy._visible = true;
         _loc3_.Bg.InfoPanel.BuyPanel.btnBuy.dialog = this;
         _loc3_.Bg.InfoPanel.BuyPanel.btnBuy.ButtonText.Text.htmlText = "#SFUI_Campaign_Buy";
         _loc3_.Bg.InfoPanel.BuyPanel.btnBuy.Action = function()
         {
            this.dialog.Purchase(CampaignItemID);
         };
         _loc3_.Bg.InfoPanel.BuyPanel.Price.htmlText = _global.CScaleformComponent_Store.GetStoreItemSalePrice(CampaignItemID,1);
         _loc3_.Bg.InfoPanel.BuyPanel.Desc.htmlText = "#campaign_add_explained";
      }
      _loc3_.Bg.InfoPanel.BuyPanel._visible = true;
      _loc3_.Bg.InfoPanel.InfoPanel._visible = false;
      return undefined;
   }
   _loc3_.Bg.InfoPanel.BuyPanel._visible = false;
   _loc3_.Bg.InfoPanel.InfoPanel._visible = true;
   if(_loc13_ > 0)
   {
      NextMissionTimer(_loc3_,numSeason,CampaignIndex,CoinId,12);
   }
   else
   {
      if(_loc11_ >= 1)
      {
         _loc4_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Backlog_Count_multi");
         _loc4_ = _global.ConstructString(_loc4_,_loc11_);
      }
      else
      {
         _loc4_ = "";
      }
      _loc3_.Bg.InfoPanel.InfoPanel.AvailableStatus.htmlText = _loc4_;
   }
   _loc3_.Bg.InfoPanel.InfoPanel.AvailableStatus._visible = true;
   var _loc5_ = _global.CScaleformComponent_Inventory.GetMyCoinTotalPoints(m_PlayerXuid,CoinId);
   var _loc7_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,CoinId,"upgrade threshold");
   if(_loc5_ == undefined || _loc5_ == null)
   {
      _loc5_ = 0;
   }
   var _loc8_ = _global.GameInterface.Translate("#CSGO_Journal_Coin_Status");
   _loc3_.Bg.InfoPanel.InfoPanel.ProgressText._visible = true;
   _loc3_.Bg.InfoPanel.InfoPanel.Score._visible = true;
   _loc3_.Bg.InfoPanel.InfoPanel.Title._visible = true;
   _loc3_.Bg.InfoPanel.InfoPanel.Score.htmlText = _loc5_;
   _loc3_.Bg.InfoPanel.InfoPanel.Medal._alpha = 100;
   _global.AutosizeTextDown(_loc3_.Bg.InfoPanel.InfoPanel.Title,6);
   _loc3_.Bg.InfoPanel.InfoPanel.Title.autoSize = "left";
   _loc3_.Bg.InfoPanel.InfoPanel.Score._x = _loc3_.Bg.InfoPanel.InfoPanel.Title._x + _loc3_.Bg.InfoPanel.InfoPanel.Title._width;
   if(_loc7_ != 0 && _loc7_ != undefined && _loc7_ != null)
   {
      _loc8_ = _global.ConstructString(_loc8_,_loc7_ - _loc5_);
   }
   else
   {
      _loc8_ = "#CSGO_PickEm_Trophy_Status_Gold";
   }
   _loc3_.Bg.InfoPanel.InfoPanel.ProgressText.htmlText = _loc8_;
   LoadImage(_loc3_.Bg.InfoPanel.InfoPanel.Medal,_loc15_,60,45);
   _loc3_.Bg.InfoPanel.InfoPanel.Medal._visible = true;
}
function NextMissionTimer(objCampaign, numSeason, CampaignIndex, CoinId, numTimeForLoop)
{
   var numCount = 0;
   UpdateCountdownTimer();
   objCampaign.Bg.InfoPanel.InfoPanel.onEnterFrame = function()
   {
      var _loc1_ = MissionsPanel.Global;
      if(numCount == numTimeForLoop)
      {
         UpdateCountdownTimer(objCampaign,numSeason,CampaignIndex,CoinId);
         numCount = 0;
      }
      numCount++;
   };
}
function UpdateCountdownTimer(objCampaign, numSeason, CampaignIndex, CoinId)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetSecondsUntilNextMission();
   var _loc2_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Timer_hr");
   if(_loc3_ <= 0)
   {
      StopUpdateCountdownTimer(objCampaign);
      UpdateMissionInfoPanel(numSeason,CampaignIndex,CoinId);
      SetMissionsState(numSeason,CampaignIndex);
   }
   else
   {
      _loc2_ = _global.ConstructString(_loc2_,_global.FormatSecondsToDaysHourString(_loc3_,true,true));
      objCampaign.Bg.InfoPanel.InfoPanel.AvailableStatus.htmlText = _loc2_;
   }
}
function StopUpdateCountdownTimer(objCampaign)
{
   delete objCampaign.Bg.InfoPanel.InfoPanel.onEnterFrame;
}
function CampaignHasActiveMission(objCampaign, CampaignIndex)
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignNodeCount(CampaignIndex);
   var _loc2_ = 0;
   while(_loc2_ < _loc4_)
   {
      var _loc3_ = objCampaign["Mission" + _loc2_];
      if(_loc3_._State = "active")
      {
         return true;
      }
      _loc2_ = _loc2_ + 1;
   }
   return false;
}
function Purchase(IdToPurchase)
{
   _global.CScaleformComponent_Store.StoreItemPurchase(IdToPurchase);
}
function FormatDays(numSec)
{
   var _loc4_ = numSec;
   var _loc2_ = 86400;
   var _loc1_ = 0;
   if(numSec > _loc2_)
   {
      _loc1_ = numSec / _loc2_;
   }
   if(_loc1_ < 1)
   {
      _loc1_ = 1;
   }
   else
   {
      _loc1_ = Math.ceil(_loc1_);
   }
   return _loc1_;
}
function ShowDaysCounter(numBanSec)
{
   var _loc7_ = 0;
   var _loc2_ = 0;
   var _loc4_ = 0;
   var _loc5_ = "00";
   var _loc3_ = "00";
   if(numBanSec > 60)
   {
      _loc7_ = numBanSec / 60;
   }
   if(_loc7_ > 60)
   {
      _loc2_ = _loc7_ / 60;
   }
   if(_loc2_ > 24)
   {
      _loc4_ = _loc2_ / 24;
   }
   _loc4_ = Math.floor(_loc4_);
   _loc2_ = Math.floor(_loc2_ - _loc4_ * 24);
   if(_loc2_ <= 0 && _loc3_ <= 0)
   {
      _loc2_ = 1;
   }
   _loc3_ = _loc4_.toString();
   _loc5_ = _loc2_.toString();
   if(_loc3_ > 1 || _loc3_ == 0)
   {
      var _loc9_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_days");
   }
   if(_loc3_ == 1)
   {
      _loc9_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_day");
   }
   if(_loc5_ > 1 || _loc3_ == 0)
   {
      var _loc8_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_hours");
   }
   if(_loc5_ == 1)
   {
      _loc8_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_hour");
   }
   var _loc6_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Timer_day_hr");
   _loc6_ = _global.ConstructString(_loc6_,_loc3_,_loc9_,_loc5_,_loc8_);
   return _loc6_;
}
function AnimScrollUp(objAnim, numStartOffsetY)
{
   var Speed = 0.15;
   var StopPosition = objAnim._y;
   var numLoop = 0;
   objAnim.onEnterFrame = function()
   {
      if(numLoop == 5)
      {
         objAnim._y = objAnim._y + numStartOffsetY;
      }
      if(numLoop > 5)
      {
         objAnim._y = objAnim._y + (StopPosition - objAnim._y) * Speed;
         if(objAnim._y == StopPosition)
         {
            delete objAnim.onEnterFrame;
         }
      }
      numLoop++;
   };
}
function ScaleDown(objAnim)
{
   var Speed = 0.5;
   var BaseWidth = objAnim._width;
   var BaseHieght = objAnim._height;
   var numLoop = 0;
   objAnim._width = objAnim._width * 2;
   objAnim._height = objAnim._height * 2;
   objAnim.onEnterFrame = function()
   {
      if(numLoop > 5)
      {
         objAnim._width = objAnim._width + (BaseWidth - objAnim._width) * Speed;
         objAnim._height = objAnim._height + (BaseHieght - objAnim._height) * Speed;
         if(objAnim._width + 60 >= BaseWidth)
         {
            FlareScale(objAnim.Flare);
         }
         if(objAnim._width == BaseWidth)
         {
            objAnim._width = BaseWidth;
            objAnim._height = BaseHieght;
            numLoop = 0;
            delete objAnim.onEnterFrame;
         }
      }
      numLoop++;
   };
}
function FlareScale(objAnim)
{
   var numLoop = 0;
   objAnim._visible = true;
   objAnim._alpha = 0;
   objAnim.onEnterFrame = function()
   {
      if(objAnim._alpha <= 100 && numLoop == 0)
      {
         objAnim._alpha = objAnim._alpha + 12;
      }
      else if(objAnim._alpha >= 100)
      {
         numLoop = 1;
      }
      if(objAnim._alpha >= 0 && numLoop == 1)
      {
         objAnim._alpha = objAnim._alpha - 15;
      }
      else if(objAnim._alpha <= 0)
      {
         delete objAnim.onEnterFrame;
      }
   };
}
function FadeUp(objAnim)
{
   var numLoop = 0;
   objAnim._visible = true;
   objAnim._alpha = 0;
   objAnim.onEnterFrame = function()
   {
      if(objAnim._alpha <= 100 && numLoop > 12)
      {
         objAnim._alpha = objAnim._alpha + 10;
      }
      else if(objAnim._alpha >= 100)
      {
         delete objAnim.onEnterFrame;
      }
      numLoop++;
   };
}
stop();
var m_FilterLineGlow = new flash.filters.GlowFilter(0,1,2,2,10,3,false,false);
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var strColorBronze = "0x88C962";
var strColorSilver = "0xDBC457";
var strColorGold = "0xCC8757";
var strColorBronzeDark = "0x598540";
var strColorSilverDark = "0x96863C";
var strColorGoldDark = "0x875A39";
var strColorBlue = "0x417CA9";
var strColorGreen = "0x2A7A54";
var strColorWhite = "0xFFFFFFF";
var strColorGrey = "0x666666";
var strColorDarkGrey = "0x555555";
var Bronze = new flash.geom.ColorTransform();
Bronze.rgb = parseInt(strColorBronze);
var Silver = new flash.geom.ColorTransform();
Silver.rgb = parseInt(strColorSilver);
var Gold = new flash.geom.ColorTransform();
Gold.rgb = parseInt(strColorGold);
var BronzeDark = new flash.geom.ColorTransform();
BronzeDark.rgb = parseInt(strColorBronzeDark);
var SilverDark = new flash.geom.ColorTransform();
SilverDark.rgb = parseInt(strColorSilverDark);
var GoldDark = new flash.geom.ColorTransform();
GoldDark.rgb = parseInt(strColorGoldDark);
var Blue = new flash.geom.ColorTransform();
Blue.rgb = parseInt(strColorBlue);
var Green = new flash.geom.ColorTransform();
Green.rgb = parseInt(strColorGreen);
var white = new flash.geom.ColorTransform();
white.rgb = parseInt(strColorWhite);
var grey = new flash.geom.ColorTransform();
grey.rgb = parseInt(strColorGrey);
var darkgrey = new flash.geom.ColorTransform();
darkgrey.rgb = parseInt(strColorDarkGrey);
