function SetMaxLocalItemTiles(nMaxLocalItemTiles)
{
   m_nMaxLocalItemTiles = nMaxLocalItemTiles;
}
function SetMaxVisibleItemTiles(nMaxVisibleItemTiles)
{
   m_nMaxVisibleItemTiles = nMaxVisibleItemTiles;
}
function SetExtraTileSlot(nExtraTileSlot)
{
   m_nExtraTileSlot = nExtraTileSlot;
   trace("------------ SetExtraTileSlot : m_nExtraTileSlot = " + m_nExtraTileSlot);
}
function HideAllItems()
{
   i = 0;
   while(i <= 10)
   {
      var _loc4_ = "ItemDropLocal" + i;
      var _loc2_ = this[_loc4_];
      if(_loc2_)
      {
         _loc2_._visible = false;
      }
      var _loc5_ = "ItemDrop" + i;
      var _loc3_ = this[_loc5_];
      if(_loc3_)
      {
         _loc3_._visible = false;
      }
      i++;
   }
   m_nItemDropIndex = 0;
   m_nLocalItemsVisible = 0;
   m_nLocalItemsStacked = 0;
}
function ShowItem(nTrueIndex, nItemDropErrorOffset, bShow, nTotal, strId, fauxItemId, PlayerXuid, bIsLocalPlayerItem, nTeam, dropReason)
{
   var _loc13_ = nTrueIndex - nItemDropErrorOffset;
   if(_loc13_ == 0)
   {
      HideAllItems();
   }
   if(bIsLocalPlayerItem)
   {
      m_localPlayerXUID = PlayerXuid;
      m_nLocalItemsVisible++;
   }
   if(m_nItemDropIndex > m_nExtraTileSlot)
   {
      m_nItemDropIndex = m_nExtraTileSlot;
   }
   var _loc18_ = "";
   if(bShow)
   {
      _loc18_ = "show";
   }
   else
   {
      _loc18_ = "hideimmediate";
   }
   if(_loc13_ > m_nExtraTileSlot)
   {
      var _loc4_ = 1;
      while(_loc4_ <= m_nExtraTileSlot)
      {
         var _loc12_ = "ItemDrop" + _loc4_;
         var _loc5_ = this[_loc12_];
         if(_loc5_)
         {
            var _loc2_ = _loc4_ - 1;
            var _loc15_ = "ItemDrop" + _loc2_;
            var _loc10_ = this[_loc15_];
            if(_loc10_)
            {
               var _loc6_ = "";
               var _loc7_ = _loc5_.ItemPanel.GetItemId();
               var _loc9_ = _loc5_.ItemPanel.GetFauxId();
               var _loc3_ = _loc5_.ItemPanel.GetOwnerXuid();
               var _loc8_ = _loc5_.storedTeam;
               var _loc16_ = "ItemDropLocal" + _loc2_;
               var _loc11_ = this[_loc16_];
               if(_loc2_ == m_nLocalItemsStacked && _loc11_ && m_localPlayerXUID == _loc3_ && m_nExtraTileSlot > -1)
               {
                  m_nLocalItemsStacked++;
                  trace("------------ SetItemData (START TRANSFER ITEM " + _loc4_ + " TO " + _loc2_ + "): id = " + _loc7_ + ", xuid = " + _loc3_ + ", IS LOCAL ITEM!!, (displaySlide == " + _loc6_ + ") ");
                  SetItemData(_loc11_,"show",_loc13_,_loc7_,_loc9_,_loc3_,true,_loc8_,true,dropReason);
               }
               else
               {
                  if(_loc2_ < m_nLocalItemsStacked || _loc2_ <= m_nLocalItemsStacked && m_localPlayerXUID == _loc3_)
                  {
                     _loc6_ = "hideimmediate";
                  }
                  else if(_loc2_ == m_nLocalItemsStacked)
                  {
                     _loc6_ = "hide";
                  }
                  var _loc14_ = m_localPlayerXUID == _loc3_;
                  trace("------------ SetItemData (START TRANSFER ITEM " + _loc4_ + " TO " + _loc2_ + "): id = " + _loc7_ + ", xuid = " + _loc3_ + ", m_localPlayerXUID = " + m_localPlayerXUID + ", (displaySlide == " + _loc6_ + ") ");
                  SetItemData(_loc10_,_loc6_,_loc13_,_loc7_,_loc9_,_loc3_,_loc14_,_loc8_,true,dropReason);
               }
            }
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   var _loc22_ = "ItemDropLocal" + m_nItemDropIndex;
   var _loc20_ = this[_loc22_];
   var _loc24_ = "ItemDrop" + m_nItemDropIndex;
   var _loc25_ = this[_loc24_];
   if(_loc20_ && bIsLocalPlayerItem == true && m_nExtraTileSlot > -1 && m_nItemDropIndex == m_nLocalItemsStacked)
   {
      m_nLocalItemsStacked++;
      SetItemData(_loc20_,_loc18_,_loc13_,strId,fauxItemId,PlayerXuid,true,nTeam,false,dropReason);
      trace("---------------- SetItemData (LOCAL) [localItem](INDEX = " + Index + "): strId = " + strId + ", PlayerXuid = " + PlayerXuid);
   }
   else
   {
      SetItemData(_loc25_,_loc18_,_loc13_,strId,fauxItemId,PlayerXuid,bIsLocalPlayerItem,nTeam,false,dropReason);
      trace("---------------- SetItemData [item](INDEX = " + Index + "): strId = " + strId + ", PlayerXuid = " + PlayerXuid);
   }
   m_nItemDropIndex++;
}
function SetItemData(item, display, nTotalSoFar, strId, fauxItemId, PlayerXuid, bIsLocalPlayerItem, nTeam, bShowQuick, dropReason)
{
   trace(">>>>>>>------------------- SetItemData : (display == " + display + ") ");
   trace("------(match-item-drops-reveal.as)---------- SetItemData: moviename = " + item.name + ", strId = " + strId + ", PlayerXuid = " + PlayerXuid + ", fauxItemId = " + fauxItemId);
   if(item == null || item == undefined)
   {
      trace("---------------- SetItemData (CANNOT FIND item!!!!): strId = " + strId + ", PlayerXuid = " + PlayerXuid);
   }
   var _loc4_ = item.NameText.AvatarContainer;
   avatarWidth = _loc4_.DynamicAvatar._width;
   avatarHeight = _loc4_.DynamicAvatar._height;
   var _loc11_ = "img://avatar_" + PlayerXuid;
   if(_loc4_.DynamicAvatar != null && _loc4_.DynamicAvatar != undefined)
   {
      _loc4_.DynamicAvatar.unloadMovie();
   }
   var _loc6_ = new MovieClipLoader();
   _loc6_.addListener(this);
   _loc6_.loadClip(_loc11_,_loc4_.DynamicAvatar);
   _loc4_.DynamicAvatar._visible = true;
   if(nTotalSoFar > 0)
   {
      if(m_nLocalItemsVisible > 0)
      {
         PersonalTitleText.Text.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUI_ItemDrop_ItemsHaveDroppedYou"),m_nLocalItemsVisible);
         PersonalTitleText._visible = true;
      }
      else
      {
         PersonalTitleText._visible = false;
      }
      TitleText._visible = false;
   }
   else
   {
      TitleText._visible = false;
      PersonalTitleText._visible = false;
   }
   item.ItemPanel.SetInfoForHudDropItem(strId,fauxItemId,PlayerXuid,dropReason);
   var _loc9_ = _global.CScaleformComponent_FriendsList.GetFriendName(PlayerXuid);
   item.NameText.Text.htmlText = _loc9_;
   item.storedTeam = nTeam;
   if(bIsLocalPlayerItem)
   {
      item.PlayerGlow._visible = true;
      item.ItemOutline._visible = true;
      item.NameText.PlayerOutline._visible = true;
   }
   else
   {
      item.PlayerGlow._visible = false;
      item.ItemOutline._visible = false;
      item.NameText.PlayerOutline._visible = false;
   }
   var _loc10_ = new Color(item.NameText.Text);
   _loc10_.setTransform(otherPlayerNameColor);
   if(display == "show")
   {
      item._visible = true;
      if(bShowQuick)
      {
         item.gotoAndPlay("ShowFast");
         trace(">>>>>>>---------------- SetItemData : (ShowFast) m_nExtraTileSlot = " + m_nExtraTileSlot);
      }
      else
      {
         item.gotoAndPlay("Show");
         trace(">>>>>>>------------------- SetItemData : (Show) m_nExtraTileSlot = " + m_nExtraTileSlot);
      }
   }
   else if(display == "hide")
   {
      item._visible = true;
      item.gotoAndPlay("Hide");
      item.PlayerGlow._visible = false;
      item.ItemOutline._visible = false;
      item.NameText.PlayerOutline._visible = false;
   }
   else if(display == "hideimmediate")
   {
      item._visible = false;
      item.PlayerGlow._visible = false;
      item.ItemOutline._visible = false;
      item.NameText.PlayerOutline._visible = false;
   }
   MoreItems._visible = m_nExtraTileSlot == -1 && nTotalSoFar > 5;
}
function onLoadInit(movieClip)
{
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
var m_nMaxLocalItemTiles = 0;
var m_nMaxVisibleItemTiles = 5;
var m_nExtraTileSlot = -1;
var avatarWidth = 24;
var avatarHeight = 24;
m_nItemDropIndex = 0;
m_nLocalItemsVisible = 0;
m_nLocalItemsStacked = 0;
var m_localPlayerXUID = "";
var localPlayerNameColor = new Object();
localPlayerNameColor = {ra:"0",rb:"230",ga:"0",gb:"201",ba:"0",bb:"39",aa:"255",ab:"0"};
var playerNameColor_CT = new Object();
playerNameColor_CT = {ra:"0",rb:"138",ga:"0",gb:"198",ba:"0",bb:"247",aa:"180",ab:"0"};
var playerNameColor_T = new Object();
playerNameColor_T = {ra:"0",rb:"255",ga:"0",gb:"220",ba:"0",bb:"136",aa:"180",ab:"0"};
var otherPlayerNameColor = new Object();
otherPlayerNameColor = {ra:"0",rb:"180",ga:"0",gb:"180",ba:"0",bb:"180",aa:"160",ab:"0"};
this.stop();
