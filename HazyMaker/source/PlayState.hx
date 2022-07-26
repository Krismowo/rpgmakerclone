package;

import flixel.FlxG;
import flixel.FlxState;

typedef Mapshiz = {
	var map:Array<Array<Int>>;
	var tilesheet:String;
}

class PlayState extends FlxState
{
	var scriptname:String = "";
	var script:Hscript;
	public function new(?scriptname:String = ""){
		super();
		if (scriptname == ""){
			scriptname = "Main";
		}
		this.scriptname = scriptname;
		script = new Hscript();
		script.setVar("add", add);
		script.setVar("switchState", switchState);
		script.loadscript("assets/data/scripts/" + scriptname + ".hx");
		script.runFunction("new");
	}
	
	override public function create():Void
	{
		super.create();
		script.runFunction("create");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		script.runFunction("update");
	}
	
	public function switchState(state:String){
		FlxG.switchState(new PlayState(state));
	}
}