package;

import flixel.FlxState;
import flixel.addons.ui.FlxInputText;
import flixel.ui.FlxButton;
import sys.FileSystem;
import flixel.FlxG;

using StringTools;
class PlayState extends FlxState
{
	var projectInput:FlxInputText;
	var runprojectbtn:FlxButton;
	var loadprojectbtn:FlxButton;
	var makeprojectbtn:FlxButton;
	var project:String = "";
	
	override public function create():Void
	{
		super.create();
		projectInput = new FlxInputText(0, 0, 170);
		add(projectInput);
		runprojectbtn = new FlxButton(projectInput.width + 5, 0, "RUN", function(){
			if (FileSystem.exists("assets/projects/" + project + "/Game.exe")){
				trace("ran!");
				Sys.command("cd assets\\projects\\" + project + " && Game.exe && cd ..\\..\\..");
			}
		});
		//assets\runtime /E
		makeprojectbtn = new FlxButton(projectInput.width + 5, runprojectbtn.height  + 5, "MAKE", function(){
			if (!FileSystem.exists("assets/projects/" + projectInput.text.replace(" ", "") + "/") && projectInput.text.replace(" ", "") != ""){
				trace("dont exist");
				Sys.command("robocopy assets\\runtime assets\\projects\\" + projectInput.text.replace(" ", "") +  " /E");
				project = projectInput.text.replace(" ", "");
				projectInput.text = project;
			}
		});
		add(makeprojectbtn);
		add(runprojectbtn);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER){
			if (FileSystem.exists("assets/projects/" + projectInput.text.replace(" ", "") + "/Game.exe")){
				project = projectInput.text.replace(" ", "");
			}
		}
	}
}