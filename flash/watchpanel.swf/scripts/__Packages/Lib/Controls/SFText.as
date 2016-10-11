class Lib.Controls.SFText extends MovieClip
{
   static var imA = "SFText";
   static var wasCollected = true;
   function SFText()
   {
      super();
   }
   function CollectTextBoxes()
   {
      if(this.CollectedTextBoxes == undefined)
      {
         this.SFText_TextBoxList = new Array();
         this.SFText_TextValue = "NoText";
         Lib.Controls.SFText.RecursiveCollectTextBoxes(this,this);
      }
   }
   function SetText(newtext)
   {
      var _loc3_ = this.SFText_TextBoxList.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this.SFText_TextBoxList[_loc2_].htmlText = newtext;
         _loc2_ = _loc2_ + 1;
      }
      this.SFText_String = newtext;
   }
   static function InitAsSFText(object)
   {
      var _loc3_ = typeof object;
      if(_loc3_ == "object" && object.type == "dynamic" && object.getTextFormat != undefined)
      {
         object.SetText = function(newText)
         {
            this.htmlText = newText;
         };
      }
      else
      {
         object.__proto__ = Lib.Controls.SFText.prototype;
         object.CollectTextBoxes();
      }
   }
   static function AddSFTextBehaviorToPrototype(proto)
   {
      proto.CollectTextBoxes = Lib.Controls.SFText.prototype.CollectTextBoxes;
      proto.SetText = Lib.Controls.SFText.prototype.SetText;
   }
   static function AddSFTextBehaviorToObject(object)
   {
      Lib.Controls.SFText.AddSFTextBehaviorToPrototype(object);
      object.CollectTextBoxes();
   }
   static function AddSFTextBehaviorToObjectWithChild(object, child)
   {
      Lib.Controls.SFText.AddSFTextBehaviorToPrototype(object);
      if(object.CollectedTextBoxes == undefined)
      {
         object.SFText_TextBoxList = new Array();
         object.SFText_TextValue = "NoText";
         Lib.Controls.SFText.RecursiveCollectTextBoxes(object,child);
      }
   }
   static function MarkAsNonCollectible(object)
   {
      object.CollectedTextBoxes = Lib.Controls.SFText.wasCollected;
   }
   static function RecursiveCollectTextBoxes(textObject, testee)
   {
      if(testee.CollectedTextBoxes != undefined)
      {
         return undefined;
      }
      testee.CollectedTextBoxes = Lib.Controls.SFText.wasCollected;
      for(var _loc7_ in testee)
      {
         var _loc1_ = testee[_loc7_];
         if(_loc1_.CollectedTextBoxes == undefined)
         {
            var _loc5_ = typeof _loc1_;
            if(_loc1_.SFText_TextBoxList != undefined)
            {
               var _loc3_ = _loc1_.SFText_TextBoxList.length;
               var _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  textObject.SFText_TextBoxList.push(_loc1_.SFText_TextBoxList[_loc2_]);
                  _loc2_ = _loc2_ + 1;
               }
            }
            else if(_loc5_ == "movieclip")
            {
               Lib.Controls.SFText.RecursiveCollectTextBoxes(textObject,_loc1_);
            }
            else if(_loc5_ == "object" && _loc1_.type == "dynamic" && _loc1_.getTextFormat != undefined)
            {
               textObject.SFText_TextBoxList.push(_loc1_);
            }
         }
      }
      delete testee.CollectedTextBoxes;
   }
}
