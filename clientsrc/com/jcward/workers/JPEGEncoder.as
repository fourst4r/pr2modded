package com.jcward.workers
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class JPEGEncoder
   {
       
      
      public var ZigZag:Array;
      
      public var quality:Number;
      
      public var asyncOutstanding:Boolean = false;
      
      public var YTable:Array;
      
      public var UVTable:Array;
      
      public var fdtbl_Y:Array;
      
      public var fdtbl_UV:Array;
      
      public var YDC_HT:Array;
      
      public var UVDC_HT:Array;
      
      public var YAC_HT:Array;
      
      public var UVAC_HT:Array;
      
      public var std_dc_luminance_nrcodes:Array;
      
      public var std_dc_luminance_values:Array;
      
      public var std_ac_luminance_nrcodes:Array;
      
      public var std_ac_luminance_values:Array;
      
      public var std_dc_chrominance_nrcodes:Array;
      
      public var std_dc_chrominance_values:Array;
      
      public var std_ac_chrominance_nrcodes:Array;
      
      public var std_ac_chrominance_values:Array;
      
      public var bitcode:Array;
      
      public var category:Array;
      
      public var byteout:ByteArray;
      
      public var bytenew:int = 0;
      
      public var bytepos:int = 7;
      
      public var DU:Array;
      
      public var YDU:Array;
      
      public var UDU:Array;
      
      public var VDU:Array;
      
      public function JPEGEncoder(param1:Number = 50)
      {
         this.ZigZag = [0,1,5,6,14,15,27,28,2,4,7,13,16,26,29,42,3,8,12,17,25,30,41,43,9,11,18,24,31,40,44,53,10,19,23,32,39,45,52,54,20,22,33,38,46,51,55,60,21,34,37,47,50,56,59,61,35,36,48,49,57,58,62,63];
         this.YTable = new Array(64);
         this.UVTable = new Array(64);
         this.fdtbl_Y = new Array(64);
         this.fdtbl_UV = new Array(64);
         this.std_dc_luminance_nrcodes = [0,0,1,5,1,1,1,1,1,1,0,0,0,0,0,0,0];
         this.std_dc_luminance_values = [0,1,2,3,4,5,6,7,8,9,10,11];
         this.std_ac_luminance_nrcodes = [0,0,2,1,3,3,2,4,3,5,5,4,4,0,0,1,125];
         this.std_ac_luminance_values = [1,2,3,0,4,17,5,18,33,49,65,6,19,81,97,7,34,113,20,50,129,145,161,8,35,66,177,193,21,82,209,240,36,51,98,114,130,9,10,22,23,24,25,26,37,38,39,40,41,42,52,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,225,226,227,228,229,230,231,232,233,234,241,242,243,244,245,246,247,248,249,250];
         this.std_dc_chrominance_nrcodes = [0,0,3,1,1,1,1,1,1,1,1,1,0,0,0,0,0];
         this.std_dc_chrominance_values = [0,1,2,3,4,5,6,7,8,9,10,11];
         this.std_ac_chrominance_nrcodes = [0,0,2,1,2,4,4,3,4,7,5,4,4,0,1,2,119];
         this.std_ac_chrominance_values = [0,1,2,3,17,4,5,33,49,6,18,65,81,7,97,113,19,34,50,129,8,20,66,145,161,177,193,9,35,51,82,240,21,98,114,209,10,22,36,52,225,37,241,23,24,25,26,38,39,40,41,42,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,130,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,226,227,228,229,230,231,232,233,234,242,243,244,245,246,247,248,249,250];
         this.bitcode = new Array(65535);
         this.category = new Array(65535);
         this.DU = new Array(64);
         this.YDU = new Array(64);
         this.UDU = new Array(64);
         this.VDU = new Array(64);
         super();
         if(param1 <= 0)
         {
            param1 = 1;
         }
         if(param1 > 100)
         {
            param1 = 100;
         }
         this.quality = param1;
         var _loc2_:int = 0;
         if(param1 < 50)
         {
            _loc2_ = int(5000 / param1);
         }
         else
         {
            _loc2_ = int(200 - param1 * 2);
         }
         this.initHuffmanTbl();
         this.initCategoryNumber();
         this.initQuantTables(_loc2_);
      }
      
      public static function get supportsNativeEncode() : Boolean
      {
         var _loc1_:* = undefined;
         try
         {
            _loc1_ = getDefinitionByName("flash.display.JPEGEncoderOptions");
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function encodeAsync(param1:BitmapData, param2:Function, param3:ByteArray = null) : void
      {
         var DCY:Number = NaN;
         var DCU:Number = NaN;
         var DCV:Number = NaN;
         var xpos:int = 0;
         var ypos:int = 0;
         var image:BitmapData = param1;
         var callback:Function = param2;
         var outputByteArray:ByteArray = param3;
         if(this.asyncOutstanding)
         {
            throw new Error("Create a separate JPEGEncoder for multiple jobs");
         }
         this.asyncOutstanding = true;
         this.byteout = !!outputByteArray ? outputByteArray : new ByteArray();
         this.byteout.position = 0;
         this.byteout.length = 0;
         this.bytenew = 0;
         this.bytepos = 7;
         this.writeWord(65496);
         this.writeAPP0();
         this.writeDQT();
         this.writeSOF0(image.width,image.height);
         this.writeDHT();
         this.writeSOS();
         this.bytenew = 0;
         this.bytepos = 7;
         DCY = 0;
         DCU = 0;
         DCV = 0;
         xpos = 0;
         ypos = 0;
         AsyncScheduler.async(this,function(param1:int):Boolean
         {
            var _loc2_:BitString = null;
            while(ypos < image.height)
            {
               if(getTimer() > param1)
               {
                  return false;
               }
               while(xpos < image.width)
               {
                  if(getTimer() > param1)
                  {
                     return false;
                  }
                  RGB2YUV(image,xpos,ypos);
                  DCY = processDU(YDU,fdtbl_Y,DCY,YDC_HT,YAC_HT);
                  DCU = processDU(UDU,fdtbl_UV,DCU,UVDC_HT,UVAC_HT);
                  DCV = processDU(VDU,fdtbl_UV,DCV,UVDC_HT,UVAC_HT);
                  xpos += 8;
               }
               xpos = 0;
               ypos += 8;
            }
            if(bytepos >= 0)
            {
               _loc2_ = new BitString();
               _loc2_.len = bytepos + 1;
               _loc2_.val = (1 << bytepos + 1) - 1;
               writeBits(_loc2_);
            }
            writeWord(65497);
            callback(byteout);
            asyncOutstanding = false;
            return true;
         });
      }
      
      public function encode(param1:BitmapData) : ByteArray
      {
         var _loc2_:* = undefined;
         try
         {
            this.byteout = new ByteArray();
            _loc2_ = getDefinitionByName("flash.display.JPEGEncoderOptions");
            Object(param1).encode(param1.rect,new _loc2_(this.quality),this.byteout);
            return this.byteout;
         }
         catch(e:Error)
         {
         }
         return this.encodeNonNative(param1);
      }
      
      public function encodeNonNative(param1:BitmapData) : ByteArray
      {
         var _loc6_:int = 0;
         var _loc7_:BitString = null;
         this.byteout = new ByteArray();
         this.bytenew = 0;
         this.bytepos = 7;
         this.writeWord(65496);
         this.writeAPP0();
         this.writeDQT();
         this.writeSOF0(param1.width,param1.height);
         this.writeDHT();
         this.writeSOS();
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         this.bytenew = 0;
         this.bytepos = 7;
         var _loc5_:int = 0;
         while(_loc5_ < param1.height)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.width)
            {
               this.RGB2YUV(param1,_loc6_,_loc5_);
               _loc2_ = Number(this.processDU(this.YDU,this.fdtbl_Y,_loc2_,this.YDC_HT,this.YAC_HT));
               _loc3_ = Number(this.processDU(this.UDU,this.fdtbl_UV,_loc3_,this.UVDC_HT,this.UVAC_HT));
               _loc4_ = Number(this.processDU(this.VDU,this.fdtbl_UV,_loc4_,this.UVDC_HT,this.UVAC_HT));
               _loc6_ += 8;
            }
            _loc5_ += 8;
         }
         if(this.bytepos >= 0)
         {
            (_loc7_ = new BitString()).len = this.bytepos + 1;
            _loc7_.val = (1 << this.bytepos + 1) - 1;
            this.writeBits(_loc7_);
         }
         this.writeWord(65497);
         return this.byteout;
      }
      
      public function initQuantTables(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:Array = [16,11,10,16,24,40,51,61,12,12,14,19,26,58,60,55,14,13,16,24,40,57,69,56,14,17,22,29,51,87,80,62,18,22,37,56,68,109,103,77,24,35,55,64,81,104,113,92,49,64,78,87,103,121,120,101,72,92,95,98,112,100,103,99];
         _loc2_ = 0;
         while(_loc2_ < 64)
         {
            _loc3_ = Math.floor((_loc4_[_loc2_] * param1 + 50) / 100);
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            else if(_loc3_ > 255)
            {
               _loc3_ = 255;
            }
            this.YTable[this.ZigZag[_loc2_]] = _loc3_;
            _loc2_++;
         }
         var _loc5_:Array = [17,18,24,47,99,99,99,99,18,21,26,66,99,99,99,99,24,26,56,99,99,99,99,99,47,66,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99];
         _loc2_ = 0;
         while(_loc2_ < 64)
         {
            _loc3_ = Math.floor((_loc5_[_loc2_] * param1 + 50) / 100);
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            else if(_loc3_ > 255)
            {
               _loc3_ = 255;
            }
            this.UVTable[this.ZigZag[_loc2_]] = _loc3_;
            _loc2_++;
         }
         var _loc6_:Array = [1,1.387039845,1.306562965,1.175875602,1,0.785694958,0.5411961,0.275899379];
         _loc2_ = 0;
         var _loc7_:int = 0;
         while(_loc7_ < 8)
         {
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               this.fdtbl_Y[_loc2_] = 1 / (this.YTable[this.ZigZag[_loc2_]] * _loc6_[_loc7_] * _loc6_[_loc8_] * 8);
               this.fdtbl_UV[_loc2_] = 1 / (this.UVTable[this.ZigZag[_loc2_]] * _loc6_[_loc7_] * _loc6_[_loc8_] * 8);
               _loc2_++;
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      public function computeHuffmanTbl(param1:Array, param2:Array) : Array
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = new Array();
         var _loc6_:int = 1;
         while(_loc6_ <= 16)
         {
            _loc7_ = 1;
            while(_loc7_ <= param1[_loc6_])
            {
               _loc5_[param2[_loc4_]] = new BitString();
               _loc5_[param2[_loc4_]].val = _loc3_;
               _loc5_[param2[_loc4_]].len = _loc6_;
               _loc4_++;
               _loc3_++;
               _loc7_++;
            }
            _loc3_ *= 2;
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function initHuffmanTbl() : void
      {
         this.YDC_HT = this.computeHuffmanTbl(this.std_dc_luminance_nrcodes,this.std_dc_luminance_values);
         this.UVDC_HT = this.computeHuffmanTbl(this.std_dc_chrominance_nrcodes,this.std_dc_chrominance_values);
         this.YAC_HT = this.computeHuffmanTbl(this.std_ac_luminance_nrcodes,this.std_ac_luminance_values);
         this.UVAC_HT = this.computeHuffmanTbl(this.std_ac_chrominance_nrcodes,this.std_ac_chrominance_values);
      }
      
      public function initCategoryNumber() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = 1;
         var _loc2_:* = 2;
         var _loc4_:int = 1;
         while(_loc4_ <= 15)
         {
            _loc3_ = _loc1_;
            while(_loc3_ < _loc2_)
            {
               this.category[32767 + _loc3_] = _loc4_;
               this.bitcode[32767 + _loc3_] = new BitString();
               this.bitcode[32767 + _loc3_].len = _loc4_;
               this.bitcode[32767 + _loc3_].val = _loc3_;
               _loc3_++;
            }
            _loc3_ = -(_loc2_ - 1);
            while(_loc3_ <= -_loc1_)
            {
               this.category[32767 + _loc3_] = _loc4_;
               this.bitcode[32767 + _loc3_] = new BitString();
               this.bitcode[32767 + _loc3_].len = _loc4_;
               this.bitcode[32767 + _loc3_].val = _loc2_ - 1 + _loc3_;
               _loc3_++;
            }
            _loc1_ <<= 1;
            _loc2_ <<= 1;
            _loc4_++;
         }
      }
      
      public function writeBits(param1:BitString) : void
      {
         var _loc2_:int = param1.val;
         var _loc3_:int = param1.len - 1;
         while(_loc3_ >= 0)
         {
            if(_loc2_ & uint(1 << _loc3_))
            {
               this.bytenew |= uint(1 << this.bytepos);
            }
            _loc3_--;
            --this.bytepos;
            if(this.bytepos < 0)
            {
               if(this.bytenew == 255)
               {
                  this.writeByte(255);
                  this.writeByte(0);
               }
               else
               {
                  this.writeByte(this.bytenew);
               }
               this.bytepos = 7;
               this.bytenew = 0;
            }
         }
      }
      
      public function writeByte(param1:int) : void
      {
         this.byteout.writeByte(param1);
      }
      
      public function writeWord(param1:int) : void
      {
         this.writeByte(param1 >> 8 & 255);
         this.writeByte(param1 & 255);
      }
      
      public function fDCTQuant(param1:Array, param2:Array) : Array
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc22_ = 0;
         while(_loc22_ < 8)
         {
            _loc3_ = param1[_loc23_ + 0] + param1[_loc23_ + 7];
            _loc10_ = param1[_loc23_ + 0] - param1[_loc23_ + 7];
            _loc4_ = param1[_loc23_ + 1] + param1[_loc23_ + 6];
            _loc9_ = param1[_loc23_ + 1] - param1[_loc23_ + 6];
            _loc5_ = param1[_loc23_ + 2] + param1[_loc23_ + 5];
            _loc8_ = param1[_loc23_ + 2] - param1[_loc23_ + 5];
            _loc6_ = param1[_loc23_ + 3] + param1[_loc23_ + 4];
            _loc7_ = param1[_loc23_ + 3] - param1[_loc23_ + 4];
            _loc11_ = _loc3_ + _loc6_;
            _loc14_ = _loc3_ - _loc6_;
            _loc12_ = _loc4_ + _loc5_;
            _loc13_ = _loc4_ - _loc5_;
            param1[_loc23_ + 0] = _loc11_ + _loc12_;
            param1[_loc23_ + 4] = _loc11_ - _loc12_;
            _loc15_ = (_loc13_ + _loc14_) * 0.707106781;
            param1[_loc23_ + 2] = _loc14_ + _loc15_;
            param1[_loc23_ + 6] = _loc14_ - _loc15_;
            _loc11_ = _loc7_ + _loc8_;
            _loc12_ = _loc8_ + _loc9_;
            _loc13_ = _loc9_ + _loc10_;
            _loc19_ = (_loc11_ - _loc13_) * 0.382683433;
            _loc16_ = 0.5411961 * _loc11_ + _loc19_;
            _loc18_ = 1.306562965 * _loc13_ + _loc19_;
            _loc17_ = _loc12_ * 0.707106781;
            _loc20_ = _loc10_ + _loc17_;
            _loc21_ = _loc10_ - _loc17_;
            param1[_loc23_ + 5] = _loc21_ + _loc16_;
            param1[_loc23_ + 3] = _loc21_ - _loc16_;
            param1[_loc23_ + 1] = _loc20_ + _loc18_;
            param1[_loc23_ + 7] = _loc20_ - _loc18_;
            _loc23_ += 8;
            _loc22_++;
         }
         _loc23_ = 0;
         _loc22_ = 0;
         while(_loc22_ < 8)
         {
            _loc3_ = param1[_loc23_ + 0] + param1[_loc23_ + 56];
            _loc10_ = param1[_loc23_ + 0] - param1[_loc23_ + 56];
            _loc4_ = param1[_loc23_ + 8] + param1[_loc23_ + 48];
            _loc9_ = param1[_loc23_ + 8] - param1[_loc23_ + 48];
            _loc5_ = param1[_loc23_ + 16] + param1[_loc23_ + 40];
            _loc8_ = param1[_loc23_ + 16] - param1[_loc23_ + 40];
            _loc6_ = param1[_loc23_ + 24] + param1[_loc23_ + 32];
            _loc7_ = param1[_loc23_ + 24] - param1[_loc23_ + 32];
            _loc11_ = _loc3_ + _loc6_;
            _loc14_ = _loc3_ - _loc6_;
            _loc12_ = _loc4_ + _loc5_;
            _loc13_ = _loc4_ - _loc5_;
            param1[_loc23_ + 0] = _loc11_ + _loc12_;
            param1[_loc23_ + 32] = _loc11_ - _loc12_;
            _loc15_ = (_loc13_ + _loc14_) * 0.707106781;
            param1[_loc23_ + 16] = _loc14_ + _loc15_;
            param1[_loc23_ + 48] = _loc14_ - _loc15_;
            _loc11_ = _loc7_ + _loc8_;
            _loc12_ = _loc8_ + _loc9_;
            _loc13_ = _loc9_ + _loc10_;
            _loc19_ = (_loc11_ - _loc13_) * 0.382683433;
            _loc16_ = 0.5411961 * _loc11_ + _loc19_;
            _loc18_ = 1.306562965 * _loc13_ + _loc19_;
            _loc17_ = _loc12_ * 0.707106781;
            _loc20_ = _loc10_ + _loc17_;
            _loc21_ = _loc10_ - _loc17_;
            param1[_loc23_ + 40] = _loc21_ + _loc16_;
            param1[_loc23_ + 24] = _loc21_ - _loc16_;
            param1[_loc23_ + 8] = _loc20_ + _loc18_;
            param1[_loc23_ + 56] = _loc20_ - _loc18_;
            _loc23_++;
            _loc22_++;
         }
         _loc22_ = 0;
         while(_loc22_ < 64)
         {
            param1[_loc22_] = Math.round(param1[_loc22_] * param2[_loc22_]);
            _loc22_++;
         }
         return param1;
      }
      
      public function writeAPP0() : void
      {
         this.writeWord(65504);
         this.writeWord(16);
         this.writeByte(74);
         this.writeByte(70);
         this.writeByte(73);
         this.writeByte(70);
         this.writeByte(0);
         this.writeByte(1);
         this.writeByte(1);
         this.writeByte(0);
         this.writeWord(1);
         this.writeWord(1);
         this.writeByte(0);
         this.writeByte(0);
      }
      
      public function writeSOF0(param1:int, param2:int) : void
      {
         this.writeWord(65472);
         this.writeWord(17);
         this.writeByte(8);
         this.writeWord(param2);
         this.writeWord(param1);
         this.writeByte(3);
         this.writeByte(1);
         this.writeByte(17);
         this.writeByte(0);
         this.writeByte(2);
         this.writeByte(17);
         this.writeByte(1);
         this.writeByte(3);
         this.writeByte(17);
         this.writeByte(1);
      }
      
      public function writeDQT() : void
      {
         var _loc1_:int = 0;
         this.writeWord(65499);
         this.writeWord(132);
         this.writeByte(0);
         _loc1_ = 0;
         while(_loc1_ < 64)
         {
            this.writeByte(this.YTable[_loc1_]);
            _loc1_++;
         }
         this.writeByte(1);
         _loc1_ = 0;
         while(_loc1_ < 64)
         {
            this.writeByte(this.UVTable[_loc1_]);
            _loc1_++;
         }
      }
      
      public function writeDHT() : void
      {
         var _loc1_:int = 0;
         this.writeWord(65476);
         this.writeWord(418);
         this.writeByte(0);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            this.writeByte(this.std_dc_luminance_nrcodes[_loc1_ + 1]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= 11)
         {
            this.writeByte(this.std_dc_luminance_values[_loc1_]);
            _loc1_++;
         }
         this.writeByte(16);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            this.writeByte(this.std_ac_luminance_nrcodes[_loc1_ + 1]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= 161)
         {
            this.writeByte(this.std_ac_luminance_values[_loc1_]);
            _loc1_++;
         }
         this.writeByte(1);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            this.writeByte(this.std_dc_chrominance_nrcodes[_loc1_ + 1]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= 11)
         {
            this.writeByte(this.std_dc_chrominance_values[_loc1_]);
            _loc1_++;
         }
         this.writeByte(17);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            this.writeByte(this.std_ac_chrominance_nrcodes[_loc1_ + 1]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= 161)
         {
            this.writeByte(this.std_ac_chrominance_values[_loc1_]);
            _loc1_++;
         }
      }
      
      public function writeSOS() : void
      {
         this.writeWord(65498);
         this.writeWord(12);
         this.writeByte(3);
         this.writeByte(1);
         this.writeByte(0);
         this.writeByte(2);
         this.writeByte(17);
         this.writeByte(3);
         this.writeByte(17);
         this.writeByte(0);
         this.writeByte(63);
         this.writeByte(0);
      }
      
      public function processDU(param1:Array, param2:Array, param3:Number, param4:Array, param5:Array) : Number
      {
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:BitString = param5[0];
         var _loc7_:BitString = param5[240];
         var _loc9_:Array = this.fDCTQuant(param1,param2);
         _loc8_ = 0;
         while(_loc8_ < 64)
         {
            this.DU[this.ZigZag[_loc8_]] = _loc9_[_loc8_];
            _loc8_++;
         }
         var _loc10_:int = this.DU[0] - param3;
         param3 = Number(this.DU[0]);
         if(_loc10_ == 0)
         {
            this.writeBits(param4[0]);
         }
         else
         {
            this.writeBits(param4[this.category[32767 + _loc10_]]);
            this.writeBits(this.bitcode[32767 + _loc10_]);
         }
         var _loc11_:int = 63;
         while(_loc11_ > 0 && this.DU[_loc11_] == 0)
         {
            _loc11_--;
         }
         if(_loc11_ == 0)
         {
            this.writeBits(_loc6_);
            return param3;
         }
         _loc8_ = 1;
         while(_loc8_ <= _loc11_)
         {
            _loc12_ = _loc8_;
            while(this.DU[_loc8_] == 0 && _loc8_ <= _loc11_)
            {
               _loc8_++;
            }
            if((_loc13_ = _loc8_ - _loc12_) >= 16)
            {
               _loc14_ = 1;
               while(_loc14_ <= _loc13_ / 16)
               {
                  this.writeBits(_loc7_);
                  _loc14_++;
               }
               _loc13_ = int(_loc13_ & 15);
            }
            this.writeBits(param5[_loc13_ * 16 + this.category[32767 + this.DU[_loc8_]]]);
            this.writeBits(this.bitcode[32767 + this.DU[_loc8_]]);
            _loc8_++;
         }
         if(_loc11_ != 63)
         {
            this.writeBits(_loc6_);
         }
         return param3;
      }
      
      public function RGB2YUV(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < 8)
         {
            _loc6_ = 0;
            while(_loc6_ < 8)
            {
               _loc7_ = param1.getPixel32(param2 + _loc6_,param3 + _loc5_);
               _loc8_ = Number(_loc7_ >> 16 & 255);
               _loc9_ = Number(_loc7_ >> 8 & 255);
               _loc10_ = Number(_loc7_ & 255);
               this.YDU[_loc4_] = 0.299 * _loc8_ + 0.587 * _loc9_ + 0.114 * _loc10_ - 128;
               this.UDU[_loc4_] = -0.16874 * _loc8_ + -0.33126 * _loc9_ + 0.5 * _loc10_;
               this.VDU[_loc4_] = 0.5 * _loc8_ + -0.41869 * _loc9_ + -0.08131 * _loc10_;
               _loc4_++;
               _loc6_++;
            }
            _loc5_++;
         }
      }
   }
}

class BitString
{
    
   
   public var len:int = 0;
   
   public var val:int = 0;
   
   public function BitString()
   {
      super();
   }
}
