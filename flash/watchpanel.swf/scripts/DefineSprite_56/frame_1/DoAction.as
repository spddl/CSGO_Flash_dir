function MakeAccordianLayout(aAccordianNodeGraph, numXStartPos, numYStartPos, objAccordianParent)
{
   RemoveAccordianMenu(m_oldNumCatagories,objAccordianParent);
   m_oldNumCatagories = aAccordianNodeGraph.length;
   m_objOpenMenu = null;
   m_bIsAnimating = false;
   DisableClickBlocker(m_ObjInputBlocker);
   var _loc2_ = 0;
   while(_loc2_ < aAccordianNodeGraph.length)
   {
      var _loc5_ = aAccordianNodeGraph[_loc2_].btn;
      var _loc6_ = MakeContainerAndAttachBtn(objAccordianParent,_loc5_,numXStartPos,numYStartPos,_loc2_);
      var _loc10_ = _loc6_.Node;
      _loc10_.Bounds._alpha = 0;
      SetAccordianBtnData(_loc6_,aAccordianNodeGraph,0,_loc2_);
      if(aAccordianNodeGraph[_loc2_].submenu.length > 0)
      {
         var _loc11_ = MakeCatagoryMc(_loc6_);
         var _loc1_ = 0;
         while(_loc1_ < aAccordianNodeGraph[_loc2_].submenu.length)
         {
            _loc5_ = aAccordianNodeGraph[_loc2_].submenu[_loc1_].btn;
            _loc6_ = MakeContainerAndAttachBtn(_loc11_,_loc5_,0,_loc10_._height,_loc1_);
            var _loc7_ = _loc6_.Node;
            _loc7_.Bounds._alpha = 20;
            SetAccordianBtnData(_loc6_,aAccordianNodeGraph[_loc2_].submenu,1,_loc1_);
            if(aAccordianNodeGraph[_loc2_].submenu[_loc1_].submenu.length > 0)
            {
               var _loc9_ = MakeCatagoryMc(_loc6_);
               var _loc4_ = 0;
               while(_loc4_ < aAccordianNodeGraph[_loc2_].submenu[_loc1_].submenu.length)
               {
                  _loc5_ = aAccordianNodeGraph[_loc2_].submenu[_loc1_].submenu[_loc4_].btn;
                  _loc6_ = MakeContainerAndAttachBtn(_loc9_,_loc5_,0,_loc7_._height,_loc4_);
                  var _loc8_ = _loc6_.Node;
                  _loc8_.Bounds._alpha = 40;
                  SetAccordianBtnData(_loc6_,aAccordianNodeGraph[_loc2_].submenu[_loc1_].submenu,2,_loc4_);
                  _loc4_ = _loc4_ + 1;
               }
               AttachAndSetMask(_loc9_,_loc7_._height);
            }
            _loc1_ = _loc1_ + 1;
         }
         AttachAndSetMask(_loc11_,_loc10_._height);
      }
      _loc2_ = _loc2_ + 1;
   }
}
function ShowAccordianMenu(mcAccordianMenu, numEndPos)
{
   new Lib.Tween(mcAccordianMenu,"_x",mx.transitions.easing.Strong.easeOut,-25,0,0.5,true);
   new Lib.Tween(mcAccordianMenu,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
}
function AttachAndSetMask(objCatagory, posY)
{
   objCatagory.attachMovie("accordian-mask","mask",objCatagory.getNextHighestDepth(),{_x:0,_y:posY});
   objCatagory.mask._height = 0;
   objCatagory.setMask(objCatagory.mask);
}
function MakeCatagoryMc(objParent)
{
   objParent.createEmptyMovieClip("Catagory",objParent.getNextHighestDepth());
   var _loc1_ = objParent.Catagory;
   return _loc1_;
}
function MakeContainerAndAttachBtn(objCatagory, strBtnToAttach, posX, posY, numIndex)
{
   objCatagory.createEmptyMovieClip("Parent" + numIndex,objCatagory.getNextHighestDepth());
   var _loc1_ = objCatagory["Parent" + numIndex];
   _loc1_.attachMovie(strBtnToAttach,"Node",_loc1_.getNextHighestDepth());
   var _loc4_ = _loc1_.Node;
   _loc1_._x = posX;
   _loc1_._y = _loc1_._y + posY + _loc4_._height * numIndex;
   return _loc1_;
}
function RemoveAccordianMenu(numMovies, objBtnParent)
{
   clearTimeout(m_numTimerDelay);
   var _loc1_ = 0;
   while(_loc1_ < numMovies)
   {
      objBtnParent["Parent" + _loc1_].removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
}
function SetAccordianBtnData(objParent, aAccordianNodeGraph, numLvl, numIndex)
{
   var objNode = objParent.Node;
   objNode.Selected._visible = false;
   var objData = aAccordianNodeGraph[numIndex];
   objParent._numSubmenuCount = aAccordianNodeGraph[numIndex].submenu.length;
   objParent._numCount = aAccordianNodeGraph.length;
   objParent._numIndex = numIndex;
   objParent._numLvl = numLvl;
   objParent._bIsOpen = false;
   objParent._btnType = objData.btn;
   objParent._id = objData.id;
   SetUpBtns(objData.setup,objNode,objData);
   objNode.Action = function()
   {
      OnPressAccordianBtn(objNode,objData.action,objData.id);
   };
}
function OnPressAccordianBtn(objBtn, FunctionToCall, srtType)
{
   if(!objBtn.Selected._visible)
   {
      objBtn.Selected._visible = true;
      new Lib.Tween(objBtn.Selected,"_x",mx.transitions.easing.Strong.easeOut,-15,0,0.5,true);
      new Lib.Tween(objBtn.Selected,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
   }
   FunctionToCall(objBtn,srtType);
   AnimateAcoordianMenu(objBtn._parent);
}
function SetUpBtns(FunctionToCall, objBtn, objData)
{
   FunctionToCall(objBtn,objData);
}
function AnimateAcoordianMenu(objParent)
{
   trace("--------------------------objParent._numLvl-----------------------------" + objParent._numLvl);
   if(objParent._numLvl == 1 && objParent._numSubmenuCount == undefined && objParent._parent._parent._bIsOpen && m_objOpenMenu != objParent && m_objOpenMenu != objParent._parent._parent)
   {
      trace("--------------------------objParent._numLvl-----------------------------" + objParent._numLvl);
      trace("----------------------------------objParent-----------------------------" + objParent);
      trace("-----------------objParent._numSubmenuCount-----------------------------" + objParent._numSubmenuCount);
      trace("---------objParent._parent._parent._bIsOpen-----------------------------" + objParent._parent._parent._bIsOpen);
      trace("------------------------------m_objOpenMenu-----------------------------" + m_objOpenMenu);
      numPrevMoveDist = GetMoveDist(m_objOpenMenu);
      UpdateAccordianTree(m_objOpenMenu,true);
      AccordianCloseAnim(m_objOpenMenu,numPrevMoveDist,null,null,true);
      m_objOpenMenu = objParent;
      return undefined;
   }
   var _loc3_ = objParent.Catagory;
   if(_loc3_ == undefined || _loc3_ == null)
   {
      return undefined;
   }
   var _loc2_ = m_objOpenMenu;
   var numPrevMoveDist = 0;
   m_objOpenMenu = objParent;
   if(objParent._numLvl == 1)
   {
      if(_loc2_._bIsOpen && _loc2_ != objParent && _loc2_ != objParent._parent._parent && objParent._parent._parent._bIsOpen)
      {
         numPrevMoveDist = GetMoveDist(_loc2_);
         UpdateAccordianTree(_loc2_,true);
         AccordianCloseAnim(_loc2_,numPrevMoveDist,objParent,null,true);
      }
      else if(objParent._bIsOpen)
      {
         UpdateAccordianTree(objParent,true);
         AccordianCloseAnim(objParent,GetMoveDist(objParent),null);
      }
      else if(!objParent._bIsOpen)
      {
         UpdateAccordianTree(objParent,false);
         AccordianOpenAnim(objParent,GetMoveDist(objParent));
      }
   }
   else
   {
      if(_loc2_._numLvl == 1)
      {
         if(objParent == _loc2_._parent._parent && _loc2_._parent._parent._bIsOpen)
         {
            if(_loc2_._bIsOpen)
            {
               numPrevMoveDist = GetMoveDist(_loc2_);
               UpdateAccordianTree(_loc2_,true);
               AccordianCloseAnim(_loc2_,numPrevMoveDist,null,objParent);
            }
            else
            {
               AccordianCloseAnim(objParent,GetMoveDist(objParent),null);
            }
            return undefined;
         }
         if(!_loc2_._bIsOpen)
         {
            numPrevMoveDist = GetMoveDist(_loc2_._parent._parent);
            AccordianCloseAnim(_loc2_._parent._parent,numPrevMoveDist,objParent);
         }
         else
         {
            UpdateAccordianTree(_loc2_,true);
            var _loc4_ = AccordianCloseAnim(_loc2_,GetMoveDist(_loc2_),null,_loc2_._parent._parent);
            m_numTimerDelay = setTimeout(DelayedOpenAnim,600,objParent);
         }
         return undefined;
      }
      if(_loc2_._bIsOpen && _loc2_ != objParent)
      {
         numPrevMoveDist = GetMoveDist(_loc2_);
         AccordianCloseAnim(_loc2_,numPrevMoveDist,objParent);
      }
      else if(objParent._bIsOpen)
      {
         AccordianCloseAnim(objParent,GetMoveDist(objParent),null);
      }
      else if(!objParent._bIsOpen)
      {
         AccordianOpenAnim(objParent,GetMoveDist(objParent));
      }
   }
}
function DelayedOpenAnim(objParent)
{
   AccordianOpenAnim(objParent,GetMoveDist(objParent));
}
function AccordianOpenAnim(objParent, numMoveDist)
{
   EnableClickBlocker(m_ObjInputBlocker);
   m_bIsAnimating = true;
   var _loc6_ = objParent._parent;
   var _loc8_ = objParent.Catagory.mask;
   objParent._bIsOpen = true;
   var _loc2_ = objParent._numIndex + 1;
   while(_loc2_ < objParent._numCount)
   {
      var _loc1_ = _loc6_["Parent" + _loc2_];
      var _loc3_ = _loc1_._y + numMoveDist;
      var _loc5_ = new Lib.Tween(_loc1_,"_y",mx.transitions.easing.Strong.easeOut,_loc1_._y,_loc3_,0.5,true);
      _loc2_ = _loc2_ + 1;
   }
   var _loc9_ = _loc8_._height + numMoveDist;
   var _loc10_ = new Lib.Tween(_loc8_,"_height",mx.transitions.easing.Strong.easeOut,_loc8_._height,_loc9_,0.5,true);
   _loc10_.onMotionFinished = function()
   {
      DisableClickBlocker(m_ObjInputBlocker);
      m_bIsAnimating = false;
   };
}
function AccordianCloseAnim(objParent, numMoveDist, objToOpenAfter, objToCloseAfter, bUpdateTree)
{
   EnableClickBlocker(m_ObjInputBlocker);
   m_bIsAnimating = true;
   var _loc8_ = objParent._parent;
   var _loc10_ = objParent.Catagory.mask;
   var _loc7_ = false;
   var _loc2_ = 0;
   while(_loc2_ < objParent._numSubmenuCount)
   {
      var _loc5_ = objParent.Catagory["Parent" + _loc2_];
      if(_loc5_._bIsOpen == true)
      {
         _loc7_ = true;
      }
      _loc2_ = _loc2_ + 1;
   }
   objParent._bIsOpen = _loc7_;
   _loc2_ = objParent._numIndex + 1;
   while(_loc2_ < objParent._numCount)
   {
      var _loc1_ = _loc8_["Parent" + _loc2_];
      var _loc4_ = _loc1_._y - numMoveDist;
      if(bReset)
      {
         _loc4_ = 0;
      }
      var _loc6_ = new Lib.Tween(_loc1_,"_y",mx.transitions.easing.Strong.easeOut,_loc1_._y,_loc4_,0.25,true);
      _loc2_ = _loc2_ + 1;
   }
   var _loc11_ = _loc10_._height - numMoveDist;
   var _loc12_ = new Lib.Tween(_loc10_,"_height",mx.transitions.easing.Strong.easeOut,_loc10_._height,_loc11_,0.25,true);
   _loc12_.onMotionFinished = function()
   {
      if(objToOpenAfter != null && objToOpenAfter != undefined)
      {
         AccordianOpenAnim(objToOpenAfter,GetMoveDist(objToOpenAfter));
         if(bUpdateTree)
         {
            UpdateAccordianTree(objToOpenAfter,false);
         }
      }
      if(objToCloseAfter != null && objToCloseAfter != undefined)
      {
         AccordianCloseAnim(objToCloseAfter,GetMoveDist(objToCloseAfter));
         if(bUpdateTree)
         {
            UpdateAccordianTree(objToCloseAfter,true);
         }
      }
      if(objToOpenAfter == null && objToCloseAfter == null)
      {
         DisableClickBlocker(m_ObjInputBlocker);
         m_bIsAnimating = false;
      }
   };
}
function DeleteBtnAnim(objBtn)
{
   var _loc3_ = objBtn._parent;
   var _loc4_ = _loc3_._parent;
   new Lib.Tween(_loc3_,"_yscale",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
   var _loc2_ = _loc3_._numIndex + 1;
   while(_loc2_ < _loc3_._numCount)
   {
      var _loc1_ = _loc4_["Parent" + _loc2_];
      new Lib.Tween(_loc1_,"_y",mx.transitions.easing.Strong.easeOut,_loc1_._y,_loc1_._y - _loc1_._height,0.5,true);
      _loc2_ = _loc2_ + 1;
   }
}
function UpdateAccordianTree(objBtn, bClose)
{
   var _loc1_ = objBtn._parent._parent;
   if(_loc1_._bIsOpen)
   {
      if(bClose)
      {
         var _loc3_ = GetMoveDist(objBtn);
         AccordianCloseAnim(_loc1_,_loc3_,null);
      }
      else
      {
         _loc3_ = GetMoveDist(objBtn);
         AccordianOpenAnim(_loc1_,_loc3_,null);
      }
   }
}
function SetClickBlocker(ObjBlocker)
{
   m_ObjInputBlocker = ObjBlocker;
}
function EnableClickBlocker(ObjBlocker)
{
   ObjBlocker.onRollOver = function()
   {
   };
   ObjBlocker._visible = true;
}
function DisableClickBlocker(ObjBlocker)
{
   ObjBlocker._visible = false;
}
function GetMoveDist(objBtn)
{
   var _loc2_ = 0;
   var _loc1_ = 0;
   while(_loc1_ < objBtn._numSubmenuCount)
   {
      _loc2_ = _loc2_ + objBtn.Catagory["Parent" + _loc1_].Node._height;
      _loc1_ = _loc1_ + 1;
   }
   return _loc2_;
}
var m_objOpenMenu = null;
var m_ObjInputBlocker = null;
var m_numTimerDelay = 0;
var m_bIsAnimating = false;
var m_oldNumCatagories = 0;
