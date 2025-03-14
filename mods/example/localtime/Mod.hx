package localtime;

import flash.events.Event;
import package_8.LocalCharacter;
import package_6.ItemDisplay;
import flash.display.MovieClip;
import package_6.Course;
import com.jiggmin.data.CommandHandler;
import flash.Lib;
import lobby.Lobby;
import com.jiggmin.data.PR2Socket;
import com.jiggmin.data.Settings;
import ui.LoginPageMenuButton;
import page.Page;
import levelEditor.LevelEditor;
import page.PageChangeEvent;
import api.Game;
import background.Map as BMap;

class LtGame extends package_6.Game {
    override function createLocalCharacter(args:Array<Dynamic>):Dynamic {
        var _loc2_ = args[0];
        var _loc3_ = args[1];
        var _loc4_ = args[2];
        var _loc5_ = args[3];
        var _loc6_ = args[4];
        var _loc7_ = args[5];
        var _loc8_ = args[6];
        var _loc9_ = args[7];
        var _loc10_ = args[8];
        var _loc11_ = args[9];
        var _loc12_ = args[10];
        var _loc13_ = args[11];
        var _loc14_ = args[12];
        var _loc15_ = args[13];
        var _loc16_ = args[14];
        var _loc17_ = args[15];
        var _loc18_:String = args[16];
        var char = new LtCharacter(_loc2_,this,blockBackground,miniMap.getDot(),itemDisplay,cast gravity,_loc3_,_loc4_,_loc5_,_loc10_,_loc11_,_loc12_,_loc13_,_loc18_);
        char.setColors(_loc6_,_loc14_,_loc7_,_loc15_,_loc8_,_loc16_,_loc9_,_loc17_);
        playerArray[_loc2_] = char;
        this.drawingInfo.method_138(Main.loggedInAs,_loc2_);
        var_9 = char;
        positionPlayersAtStart();
        return null;
    }
}

class LtCharacter extends LocalCharacter {
    var _frames:Int;

    public function new(tempId:Int, course:Course, map:BMap, mapDot:MovieClip, itemDisplay:ItemDisplay, gravity:Float, speed:Int=50, accel:Int=50, jump:Int=50, hat:Int=1, head:Int=1, body:Int=1, feet:Int=1, group:String="0") {
        super(tempId, course, map, mapDot, itemDisplay, gravity, speed, accel, jump, hat, head, body, feet, group);
    }

    override function go(p1:Event):Dynamic {
        super.go(p1);
        _frames++;
        return null;
    }
}

final class Mod extends modding.ModBase {
    public override function enable() {
        CommandHandler.commandHandler.defineCommand("startGame", onStartGame);
    }

    static function onStartGame(args:Array<Dynamic>) {
        Game.getPageHolder().changePage(new LtGame(args[0], Main.filledSlotCourseVersion));
    }
}