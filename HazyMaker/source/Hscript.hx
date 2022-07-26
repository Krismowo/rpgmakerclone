package;
import flixel.FlxG;
import hscript.Interp;
import hscript.Parser;
import openfl.media.Sound;
import sys.io.File;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;
import sys.FileSystem;
import openfl.display.BitmapData;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author Dazed
 */
class Hscript 
{
	var interp:Interp;
	var parser:Parser;
	public function new(){
		parser = new Parser();
		interp = new Interp();
		setVar("FlxG", FlxG);
		setVar("playMusic", playMusic);
		setVar("makeSprite", makeSprite);
		setVar("FlxText", FlxText);
		setVar("FlxTypedGroup", FlxTypedGroup);
		
	}
	
	public function makeSprite(SpriteName:String, ?SpritePath:String = ""){
		var sprite = new FlxSprite();
		if(FileSystem.exists(SpritePath)){
			var bitmap = BitmapData.fromFile(SpritePath);
			var flxthing:FlxGraphic = FlxGraphic.fromBitmapData(bitmap);
			sprite.loadGraphic(FlxG.bitmap.add(flxthing));
			setVar(SpriteName, sprite);
		}else{
			sprite.makeGraphic(50, 50);
			setVar(SpriteName, sprite);
		}
	}
	
	public function playMusic(songName:String, loop:Bool){
		FlxG.sound.playMusic(Sound.fromFile(songName), 1, loop);
	}
	
	public function getVar(varname:String){
		if(interp.variables.exists(varname)){
			return interp.variables.get(varname);
		}else{   
			return null;
		}
		return null;
	}
	
	public function setVar(varname:String, varr:Dynamic){
		interp.variables.set(varname, varr);
		return interp.variables[varname];
	}
	
	public function runFunction(funcname){
		var func = getVar(funcname);
		if (func != null){
			func();
			return true;
		}
		return false;
	}
	
	public function loadscript(script:String){
		interp.execute(parser.parseString(File.getContent(script)));
	}
}