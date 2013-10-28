package com.quiz
{
	import flash.text.*;
	
	class Texte extends TextField
	{
		var format:TextFormat;
		
		function Texte(x:Number, y:Number, w:Number, h:Number, taille:Number, police:String)
		{
			//initialisations de base
			setPosition(x,y);
			setTaille(w,h);
			this.textColor = 0xFF0000; 
			this.selectable = false;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.multiline = true;
			
			//définition du format
			format = new TextFormat();
			
			//Application du format au texte
			setFormatTexte(taille,police);
		}
		
		function setPosition(x:Number,y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		function setTaille(w:Number,h:Number):void
		{
			height  = h;
			width = w;
		}
		
		function setFormatTexte(t:Number,p:String)
		{
			format.size = t;
			format.font = p;
			this.setTextFormat(format);
			this.defaultTextFormat = format;
		}
		
		function setCouleur(c:uint)
		{
			textColor = c;
		}
		
		function setText(t:String)
		{
			this.text = t;
		}
	}
}