package com.quiz
{
	import flash.events.Event; 
	
	import flash.display.*;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.events.ProgressEvent;
	import flash.text.TextField ;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import fl.controls.*;
	
	import com.quiz.Texte;
	
	public class QuizXML
	{
		var ville:Ville;
		var monument:Monument;
		var musee:Musee;
		var transport:Transport;
		
		var rbg1:RadioButtonGroup;
		var rb0:RadioButton;
		var rb1:RadioButton;
		var rb2:RadioButton;
		var rb3:RadioButton;
		var rb4:RadioButton;
		
		var mc_parent:MovieClip;
		
		//XML
		var fichier:URLLoader;
		var xml:XML;
		var xmlA:XML;
		var requette:URLRequest;
		var questionsVille:Array = new Array();
		var reponsesVille:Array = new Array();
		var choixVille:Array = new Array();
		var questionsMonument:Array = new Array();
		var reponsesMonument:Array = new Array();
		var choixMonument:Array = new Array();
		var questionsMusee:Array = new Array();
		var reponsesMusee:Array = new Array();
		var choixMusee:Array = new Array();
		var questionsTransport:Array = new Array();
		var reponsesTransport:Array = new Array();
		var choixTransport:Array = new Array();
		
		var questionsVille1:Array = new Array();
		var reponsesVille1:Array = new Array();
		var choixVille1:Array = new Array();
		
		//Textes questions
		var TexteQuestion:Texte;
		var TexteReponse0:Texte;
		var TexteReponse1:Texte;
		var TexteReponse2:Texte;
		var TexteReponse3:Texte;
		
		//bouton suivant
		var bouton:Bouton;
		var bilan:BilanBtn = new BilanBtn();
		
		//quelques variables
		var entierV:Number;
		var entierT:Number;
		var entierMu:Number;
		var entierMo:Number;
		var theme:String = " ";
		
		//Variables pour retour informatif
		var faux0:Faux;
		var faux1:Faux;
		var faux2:Faux;
		var faux3:Faux;
		var vrai0:Vrai;
		var vrai1:Vrai;
		var vrai2:Vrai;
		var vrai3:Vrai;
		
		//récupération de la réponse
		var reponse:Number = 4;
		
		//Booléens pour les boutons
		var villeB:Boolean;
		var transportB:Boolean;
		var monumentB:Boolean;
		var museeB:Boolean;
		
		var bol:Boolean;
		
		//variables pour compter les bonnes réponses par rubriques
		var ctrV:Number =0;
		var ctrMo:Number = 0;
		var ctrMu:Number = 0;
		var ctrT:Number = 0;
		
		//varivles Textes bilan
		var scoreV:Texte;
		var scoreMu:Texte;
		var scoreT:Texte;
		var scoreMo:Texte;
		
		//Appreciation Bilan
		var remarqueV:TextArea;
		var remarqueMu:TextArea;
		var remarqueMo:TextArea;
		var remarqueT:TextArea;
		
		//variable nombre de rubriques visitées
		var rubrique:Number;
		
		//graphique du bilan
		var bilanImage:BilanQCM;
		
		//var compteurs questions
		var cV:Number = 0;
		var cMo:Number = 0;
		var cMu:Number = 0;
		var cT:Number = 0;
		
		public function QuizXML(parent_m:MovieClip)
		{
			mc_parent = parent_m;
			chargementXML("../xml/questions.xml");
			initBtnRadio();
			initRetourInformatif();
			initBtnSuivant();
			initMenu();
			
		}
		
		function chargementXML(url:String)
		{
			//récupération des données
			fichier = new URLLoader();
			requette = new URLRequest(url);
			fichier.load(requette);
			fichier.addEventListener(Event.COMPLETE, xmlCharge);
		}
		
		function tri(a:int):Array
		{
			var tableau:Array = new Array();
			var b:int;
			tableau.push(b);
			for(var c:int=0;c<a;c++)
			{
				b = Math.random()*( 1 + a - 0 );
				while(verifTab(tableau,b))
				{
					b = Math.random()*( 1 + a - 0 );
				}
				tableau.push(b);
			}
			return tableau;
		}
		
		function verifTab(tab:Array,e:int):Boolean
		{
			//var i:int=0;
			var b:Boolean=false;
			for(var i:int=0;i<tab.length;i++)
			{
				if(e==tab[i]){b=true;}
			}
			return b;
		}
		
		function xmlCharge(e:Event):void
		{
			var fichier:URLLoader = e.target as URLLoader;
			if(fichier != null)
			{
				xml = new XML(fichier.data);
				//trace(xml.question[0].intitule["@reponse"]);
			}
			else
			{
				trace("loader is not a URLLoader!"); 
			}
			
			//trace(xml.question.(@theme=="ville"));
			
			//var s:String = "transport";
			var liste0:XMLList = xml.question.(@theme=="ville");
			var liste1:XMLList = xml.question.(@theme=="transport");
			var liste2:XMLList = xml.question.(@theme=="monument");
			var liste3:XMLList = xml.question.(@theme=="musee");
			
			trace(liste1.length());
			//Tableaux test
			var tab0:Array = new Array();
			var tab1:Array = new Array();
			var tab2:Array = new Array();
			var tab3:Array = new Array();
			
			//compteurs
			var i0:Array = new Array();
			i0 = tri(liste0.length()-1);
			var i00:int = 0;
			trace(i0);
			var i1:Array = new Array();
			i1 = tri(liste1.length()-1);
			var i11:int = 0;
			var i2:Array = new Array();
			i2 = tri(liste2.length()-1);
			var i22:int = 0;
			var i3:Array = new Array();
			i3 = tri(liste3.length()-1);
			var i33:int = 0;
			
			trace(i0);
			trace(i1);
			trace(i2);
			trace(i3);
			
			for each (var pop:XML in liste0)
			{
				reponsesVille.push(String(liste0[i0[i00]].intitule["@reponse"]));
				questionsVille.push(String(liste0[i0[i00]].intitule));
				tab0[i0[i00]] = new Array();
			
				var j00:int = 0;

				for each(var a:XML in pop.choix)
				{
					tab0[i0[i00]][j00] = a;
					j00++;
				}
				i00++;
			}
			
			for each (var pop1:XML in liste1)
			{
				reponsesTransport.push(String(liste1[i1[i11]].intitule["@reponse"]));
				questionsTransport.push(String(liste1[i1[i11]].intitule));
				tab1[i1[i11]] = new Array();
			
				var j11:Number = 0;

				for each(var a1:XML in pop1.choix)
				{
					tab1[i1[i11]][j11] = a1;
					j11++;
				}
				i11++;
			}
			
			for each (var pop2:XML in liste2)
			{
				reponsesMonument.push(String(liste2[i2[i22]].intitule["@reponse"]));
				questionsMonument.push(String(liste2[i2[i22]].intitule));
				tab2[i2[i22]] = new Array();
			
				var j22:Number = 0;

				for each(var a2:XML in pop2.choix)
				{
					tab2[i2[i22]][j22] = a2;
					j22++;
				}
				i22++;
			}
			
			for each (var pop3:XML in liste3)
			{
				reponsesMusee.push(String(liste3[i3[i33]].intitule["@reponse"]));
				questionsMusee.push(String(liste3[i3[i33]].intitule));
				tab3[i3[i33]] = new Array();
			
				var j33:Number = 0;

				for each(var a3:XML in pop3.choix)
				{
					tab3[i3[i33]][j33] = a3;
					j33++;
				}
				i33++;
			}
			choixVille = tab0;
			choixTransport = tab1;
			choixMonument = tab2;
			choixMusee = tab3;
			
			//trace(questionsVille[1]);
			//trace(choixVille[1]);
			//trace(reponsesVille[0]);
			//trace(choixTransport);
			//trace(choixMonument);
			//trace(choixMusee);
		}
		
		/*function initListe(r:Array,q:Array,c:Array):void
		{
			var liste:XMLList = xml.question.(@theme=="transport");
			var tab:Array = new Array();
			var i:Number = 0;
			for each (var pop:XML in liste)
			{
				r.push(String(liste[i].intitule["@reponse"]));
				q.push(String(liste[i].intitule));
				tab[i] = new Array();
				var j:Number = 0;
				for each(var a:XML in pop.choix)
				{
					tab[i][j] = a;
					j++;
				}
				i++
			}
			c = tab;
		}*/
		
		function initMenu()
		{
			rubrique = 0;
			ville = new Ville();
			villeB = false;
			mc_parent.addChild(ville);
			ville.x = 55;
			ville.y = 38;
			
			monument = new Monument();
			monumentB = false;
			mc_parent.addChild(monument);
			monument.x = ville.x + 100;
			monument.y = ville.y;
			
			musee = new Musee();
			museeB = false;
			mc_parent.addChild(musee);
			musee.x = monument.x + 100;
			musee.y = ville.y;
			
			transport = new Transport();
			transportB = false;
			mc_parent.addChild(transport);
			transport.x = musee.x + 100;
			transport.y = ville.y;
			
			ville.addEventListener( MouseEvent.CLICK, clicVille );
			monument.addEventListener( MouseEvent.CLICK, clicMonument );
			musee.addEventListener( MouseEvent.CLICK, clicMusee );
			transport.addEventListener( MouseEvent.CLICK, clicTransport );
		}
		
		function clicVille(pEvt:MouseEvent)
		{
			rubrique++;
			if(bilan.visible == true){bilan.visible = false; antiInitBilan();}
			cV=0;cT=0;cMo=0;cMu=0;
			ctrV = 0;
			bouton.visible=true;
			theme = "ville";
			entierV = 0;
			
			//efface les anciennes questions et sélectionne le bouton invisible
			erase();
			
			//réécrit les bonnes questions
			TexteQuestion.setText(questionsVille[entierV]);
			TexteReponse0.setText(choixVille[entierV][0]);
			TexteReponse1.setText(choixVille[entierV][1]);
			TexteReponse2.setText(choixVille[entierV][2]);
			TexteReponse3.setText(choixVille[entierV][3]);
			entierV++;
			
			//réiinitialisation des retours informatifs VRAI/FAUX
			initVF();
			enableBtn();
			
			//rend visible les boutons radio
			afficheRbtn();
			
			//rend le bouton inclicable pour la suite
			ville.y -= 5;
			ville.height += 10;
			ville.mouseEnabled = false;
			ville.mouseChildren = false;
			//bilan.visible = false;
			//reponse = 4;
			
		}
		
		function clicMusee(pEvt1:MouseEvent)
		{
			rubrique++;
			if(bilan.visible == true){bilan.visible = false; antiInitBilan();}
			cV=0;cT=0;cMo=0;cMu=0;
			bouton.visible=true;
			theme = "musee";
			entierMu = 0;
			
			//efface les anciennes questions et sélectionne le bouton invisible
			erase();
			
			//réécrit les bonnes questions
			TexteQuestion.setText(questionsMusee[entierMu]);
			TexteReponse0.setText(choixMusee[entierMu][0]);
			TexteReponse1.setText(choixMusee[entierMu][1]);
			TexteReponse2.setText(choixMusee[entierMu][2]);
			TexteReponse3.setText(choixMusee[entierMu][3]);
			entierMu++;
			
			//réiinitialisation des retours informatifs VRAI/FAUX
			initVF();
			
			enableBtn();
			
			//renvisible les boutons radio
			afficheRbtn();
			
			//rend le bouton inclicable pour la suite
			musee.y -= 5;
			musee.height += 10;
			musee.mouseEnabled = false;
			musee.mouseChildren = false;
			//bilan.visible = false;
			//reponse = 4;
		}
		
		function clicTransport(pEvt2:MouseEvent)
		{
			rubrique++;
			if(bilan.visible == true){bilan.visible = false; antiInitBilan();}
			cV=0;cT=0;cMo=0;cMu=0;
			ctrT = 0;
			bouton.visible=true;
			theme = "transport";
			entierT = 0;
			
			//efface les anciennes questions et sélectionne le bouton invisible
			erase();
			
			//réécrit les bonnes questions
			TexteQuestion.setText(questionsTransport[entierT]);
			TexteReponse0.setText(choixTransport[entierT][0]);
			TexteReponse1.setText(choixTransport[entierT][1]);
			TexteReponse2.setText(choixTransport[entierT][2]);
			TexteReponse3.setText(choixTransport[entierT][3]);
			entierT++;
			
			//réiinitialisation des retours informatifs VRAI/FAUX
			initVF();
			enableBtn();
			
			//renvisible les boutons radio
			afficheRbtn();
			
			//rend le bouton inclicable pour la suite
			transport.y -= 5;
			transport.height += 10;
			transport.mouseEnabled = false;
			transport.mouseChildren = false;
			//bilan.visible = false;
			//reponse = 4;
		}
		
		function clicMonument(pEvt3:MouseEvent)
		{
			rubrique++;
			if(bilan.visible == true){bilan.visible = false; antiInitBilan();}
			cV=0;cT=0;cMo=0;cMu=0;
			ctrMo = 0;
			bouton.visible=true;
			theme = "monument";
			entierMo = 0;
			
			//efface les anciennes questions et sélectionne le bouton invisible
			erase();
			
			//réécrit les bonnes questions
			TexteQuestion.setText(questionsMonument[entierMo]);
			TexteReponse0.setText(choixMonument[entierMo][0]);
			TexteReponse1.setText(choixMonument[entierMo][1]);
			TexteReponse2.setText(choixMonument[entierMo][2]);
			TexteReponse3.setText(choixMonument[entierMo][3]);
			entierMo++;
			
			//réiinitialisation des retours informatifs VRAI/FAUX
			initVF();
			enableBtn();
			
			//renvisible les boutons radio
			afficheRbtn();
			
			//rend le bouton inclicable pour la suite
			monument.y -= 5;
			monument.height += 10;
			monument.mouseEnabled = false;
			monument.mouseChildren = false;
			//bilan.visible = false;
			//reponse = 4;
		}
		
		function enableBtn()
		{
			rb0.enabled = true;
			rb1.enabled = true;
			rb2.enabled = true;
			rb3.enabled = true;
		}
		
		function afficheRbtn():void
		{
			rb0.visible = true;
			rb1.visible = true;
			rb2.visible = true;
			rb3.visible = true;
		}
		
		//initiatlisation des boutons radio
		function erase():void
		{
			TexteQuestion.setText(" ");
			TexteReponse0.setText(" ");
			TexteReponse1.setText(" ");
			TexteReponse2.setText(" ");
			TexteReponse3.setText(" ");
			
			//rb4.selected = false;
			diselectBtn();
			//reponse = 4;
			
		}
		
		function diselectBtn()
		{
			rb0.selected = false;
			rb1.selected = false;
			rb2.selected = false;
			rb3.selected = false;
			rb4.selected = true;
		}
		function initBtnRadio()
		{
			rbg1 = new RadioButtonGroup("rbg_reponse");

			rb0 = new RadioButton();
			rb1 = new RadioButton();
			rb2 = new RadioButton();
			rb3 = new RadioButton();
			rb3 = new RadioButton();
			rb4 = new RadioButton();
			
			TexteQuestion = new Texte(60, 90, 600, 400, 30, "Sylfaen");
			TexteQuestion.setCouleur(0x91283B); //#663366  663366
			TexteQuestion.setText("Bienvenue veuillez choisir une rubrique");
			
			TexteReponse0 = new Texte(140, 160, 600, 100, 25, "Sylfaen");
			TexteReponse0.setCouleur(0x663366); //#663366  663366
			TexteReponse0.setText(" ");
			
			TexteReponse1 = new Texte(140, 220, 600, 100, 25, "Sylfaen");
			TexteReponse1.setCouleur(0x663366); //#663366  663366
			TexteReponse1.setText(" ");
			
			TexteReponse2 = new Texte(140, 220+60, 600, 100, 25, "Sylfaen");
			TexteReponse2.setCouleur(0x663366); //#663366  663366
			TexteReponse2.setText(" ");
			
			TexteReponse3 = new Texte(140, 220+120, 600, 100, 25, "Sylfaen");
			TexteReponse3.setCouleur(0x663366); //#663366  663366
			TexteReponse3.setText(" ");
			
			
			
			rb0.group = rbg1;
			rb1.group = rbg1;
			rb2.group = rbg1;
			rb3.group = rbg1;
			rb4.group = rbg1;
			
			rb0.move(110,170);
			rb1.move(110,230);
			rb2.move(110,230+60);
			rb3.move(110,230+120);
			
			rb0.label = "  ";
			rb1.label = "  ";
			rb2.label = "  ";
			rb3.label = "  ";
			
			rb0.visible = false;
			rb1.visible = false;
			rb2.visible = false;
			rb3.visible = false;
			rb4.visible = false;
			rb4.selected = true;
			
			rb0.addEventListener(MouseEvent.CLICK, test);
			rb1.addEventListener(MouseEvent.CLICK, test);
			rb2.addEventListener(MouseEvent.CLICK, test);
			rb3.addEventListener(MouseEvent.CLICK, test);
			rb4.addEventListener(MouseEvent.CLICK, test);
			
			mc_parent.addChild(rb0);
			mc_parent.addChild(rb1);
			mc_parent.addChild(rb2);
			mc_parent.addChild(rb3);
			mc_parent.addChild(rb4);
			mc_parent.addChild(TexteQuestion);
			mc_parent.addChild(TexteReponse0);
			mc_parent.addChild(TexteReponse1);
			mc_parent.addChild(TexteReponse2);
			mc_parent.addChild(TexteReponse3);
		}
		
		function test(tEvt:MouseEvent)
		{
			if(rb0.selected == true)
			{
				reponse = 0;
				//if(rubrique==4){rubrique++;}
			}
			if(rb1.selected == true)
			{
				reponse = 1;
				//if(rubrique==4){rubrique++;}
			}
			if(rb2.selected == true)
			{
				reponse = 2;
				//if(rubrique==4){rubrique++;}
			}
			if(rb3.selected == true)
			{
				reponse = 3;
				//if(rubrique==4){rubrique++;}
			}
			
			disableBtn();
			ctrQuestion();
			
			verification();
			var d:Boolean = autorisation();
			if(d){initBilan();}
		}
		
		function autorisation():Boolean
		{
			var aV:Number = questionsVille.length;
			var aT:Number = questionsTransport.length;
			var aMo:Number = questionsMonument.length;
			var aMu:Number = questionsMusee.length;
			
			if(cV==aV || cT==aT || cMu==aMu || cMo==aMo)
			{return true;}
			else
			{return false;}
		}
		
		function ctrQuestion():void
		{
			if(theme == "ville"){cV++;}
			if(theme == "transport"){cT++;}
			if(theme == "musee"){cMu++;}
			if(theme == "monument"){cMo++;}
		}
		
		function disableBtn()
		{
			rb0.enabled = false;
			rb1.enabled = false;
			rb2.enabled = false;
			rb3.enabled = false;
		}
		
		function verification()
		{
			var tableau1:Array = new Array();
			tableau1.push(vrai0);
			tableau1.push(vrai1);
			tableau1.push(vrai2);
			tableau1.push(vrai3);
			
			var tableau2:Array = new Array();
			tableau2.push(faux0);
			tableau2.push(faux1);
			tableau2.push(faux2);
			tableau2.push(faux3);
			
			if(theme=="ville")
			{
				if(entierV==questionsVille.length){bouton.visible = false;}
				if(reponse==reponsesVille[entierV-1])
				{
					tableau1[reponse].visible =true;
					ctrV++;
					trace("votre score est de "+ctrV+"/"+questionsVille.length+" dans la rubrique ville");
				}
				else
				{
					tableau2[reponse].visible =true;
					tableau1[reponsesVille[entierV-1]].visible = true;
					trace("votre score est de "+ctrV+"/"+questionsVille.length+" dans la rubrique ville");
				}
			}
			
			if(theme=="transport")
			{
				if(entierT==questionsTransport.length){bouton.visible = false;}
				if(reponse==reponsesTransport[entierT-1])
				{
					tableau1[reponse].visible =true;
					ctrT++;
					trace("votre score est de "+ctrT+"/"+questionsTransport.length+" dans la rubrique transport");
				}
				else
				{
					tableau2[reponse].visible =true;
					tableau1[reponsesTransport[entierT-1]].visible = true;
					trace("votre score est de "+ctrT+"/"+questionsTransport.length+" dans la rubrique transport");
				}
			}
			
			if(theme=="musee")
			{
				if(entierMu==questionsMusee.length){bouton.visible = false;}
				if(reponse==reponsesMusee[entierMu-1])
				{
					tableau1[reponse].visible =true;
					ctrMu++;
					trace("votre score est de "+ctrMu+"/"+questionsMusee.length+" dans la rubrique Musee");
				}
				else
				{
					tableau2[reponse].visible =true;
					tableau1[reponsesMusee[entierMu-1]].visible = true;
					trace("votre score est de "+ctrMu+"/"+questionsMusee.length+" dans la rubrique Musee");
				}
			}
			
			if(theme=="monument")
			{
				if(entierMo==questionsMonument.length){bouton.visible = false;}
				if(reponse==reponsesMonument[entierMo-1])
				{
					tableau1[reponse].visible =true;
					ctrMo++;
					trace("votre score est de "+ctrMo+"/"+questionsMonument.length+" dans la rubrique Monument");
				}
				else
				{
					tableau2[reponse].visible =true;
					tableau1[reponsesMonument[entierMo-1]].visible = true;
					trace("votre score est de "+ctrMo+"/"+questionsMonument.length+" dans la rubrique Monument");
				}
			}
		}
		
		function initRetourInformatif():void
		{
			vrai0 = new Vrai();
			vrai0.x = 80;
			vrai0.y = 178;
			vrai0.width = 25;
			vrai0.height = 25;
			vrai0.visible = false;
			faux0 = new Faux();
			faux0.x = 80;
			faux0.y = 178;
			faux0.width = 25;
			faux0.height = 25;
			faux0.visible = false;
			mc_parent.addChild(vrai0);
			mc_parent.addChild(faux0);
			
			vrai1 = new Vrai();
			vrai1.x = 80;
			vrai1.y = 238;
			vrai1.width = 25;
			vrai1.height = 25;
			vrai1.visible = false;
			faux1 = new Faux();
			faux1.x = 80;
			faux1.y = 238;
			faux1.width = 25;
			faux1.height = 25;
			faux1.visible = false;
			mc_parent.addChild(vrai1);
			mc_parent.addChild(faux1);
			
			vrai2 = new Vrai();
			vrai2.x = 80;
			vrai2.y = 298;
			vrai2.width = 25;
			vrai2.height = 25;
			vrai2.visible = false;
			faux2 = new Faux();
			faux2.x = 80;
			faux2.y = 298;
			faux2.width = 25;
			faux2.height = 25;
			faux2.visible = false;
			mc_parent.addChild(vrai2);
			mc_parent.addChild(faux2);
			
			vrai3 = new Vrai();
			vrai3.x = 80;
			vrai3.y = 358;
			vrai3.width = 25;
			vrai3.height = 25;
			vrai3.visible = false;
			faux3 = new Faux();
			faux3.x = 80;
			faux3.y = 358;
			faux3.width = 25;
			faux3.height = 25;
			faux3.visible = false;
			mc_parent.addChild(vrai3);
			mc_parent.addChild(faux3);
		}
		
		//initialisation du bouton suivant
		function initBtnSuivant():void
		{
			bouton = new Bouton();
			mc_parent.addChild(bouton);
			bouton.x = 710;
			bouton.y = 530;
			bouton.height = 35;
			bouton.width = 45;
			
			bouton.addEventListener( MouseEvent.CLICK, clicSuivant );
		}
		
		function clicSuivant(bEvt:MouseEvent)
		{
			//vérification du choix de la rubrique et du nombre de questions
			if (entierV < questionsVille.length && theme=="ville")
			{
				//On verifie que l'utilisateur a bien sélectionner une réponse
				if(reponse != 4)
				{
				//affichage de la question suivante
				TexteQuestion.setText(questionsVille[entierV]);
				TexteReponse0.setText(choixVille[entierV][0]);
				TexteReponse1.setText(choixVille[entierV][1]);
				TexteReponse2.setText(choixVille[entierV][2]);
				TexteReponse3.setText(choixVille[entierV][3]);
				entierV++;
				initVF();//Mise à jour des retours informatifs
				initRien();//Mise à jour des boutons radio
				bol=false;
				}
				
			}
			
			if (entierMu < questionsMusee.length && theme=="musee")
			{
				if(reponse != 4)
				{
				TexteQuestion.setText(questionsMusee[entierMu]);
				TexteReponse0.setText(choixMusee[entierMu][0]);
				TexteReponse1.setText(choixMusee[entierMu][1]);
				TexteReponse2.setText(choixMusee[entierMu][2]);
				TexteReponse3.setText(choixMusee[entierMu][3]);
				entierMu++;
				initVF();
				initRien();
				bol=false;
				}
			}
			
			if (entierMo < questionsMonument.length && theme=="monument")
			{
				if(reponse != 4)
				{
				TexteQuestion.setText(questionsMonument[entierMo]);
				TexteReponse0.setText(choixMonument[entierMo][0]);
				TexteReponse1.setText(choixMonument[entierMo][1]);
				TexteReponse2.setText(choixMonument[entierMo][2]);
				TexteReponse3.setText(choixMonument[entierMo][3]);
				entierMo++;
				initVF();
				initRien();
				bol=false;
				}
			}
			
			if (entierT < questionsTransport.length && theme=="transport")
			{
				if(reponse != 4)
				{
				TexteQuestion.setText(questionsTransport[entierT]);
				TexteReponse0.setText(choixTransport[entierT][0]);
				TexteReponse1.setText(choixTransport[entierT][1]);
				TexteReponse2.setText(choixTransport[entierT][2]);
				TexteReponse3.setText(choixTransport[entierT][3]);
				entierT++;
				initVF();
				initRien();
				bol=false;
				}
			}
			
			
			initReponse();
			
			//trace(rb4.selected);
			//trace(reponse);
			
		}
		
		function initRien()
		{
			//On rend les boutons radio cliquable à nouveau
			rb0.enabled = true;
			rb1.enabled = true;
			rb2.enabled = true;
			rb3.enabled = true;
			
			//On selectione le bouton radio non visible pour libérer les autres
			rb0.selected= false;
			rb1.selected= false;
			rb2.selected= false;
			rb3.selected= false;
			rb4.selected= true;
		}
		
		function initReponse()
		{
			if(!bol)
			{
				reponse = 4;
			}
			else
			{
				reponse=5;
				bol=false;
			}
		}
		
		function initVF():void
		{
			vrai0.visible = false;
			vrai1.visible = false;
			vrai2.visible = false;
			vrai3.visible = false;
			
			faux0.visible = false;
			faux1.visible = false;
			faux2.visible = false;
			faux3.visible = false;
		}
		
		function antiInitBilan():void
		{
			TexteQuestion.visible = true;
			TexteReponse0.visible = true;
			TexteReponse1.visible = true;
			TexteReponse2.visible = true;
			TexteReponse3.visible = true;
			
			rb0.visible = true;
			rb1.visible = true;
			rb2.visible = true;
			rb3.visible = true;
		}
		
		function initBilan():void
		{
			bilan = new BilanBtn();
			bouton.visible =false;
			mc_parent.addChild(bilan);
			bilan.x = 400;
			bilan.y = 220.6;
			
			//ville.visible = false;
			//monument.visible = false;
			//musee.visible = false;
			//transport.visible = false;
			
			//TexteQuestion.visible = false;
			TexteQuestion.setText("Choisissez  une autre rubrique ou accedez directement au bilan");
			TexteReponse0.visible = false;
			TexteReponse1.visible = false;
			TexteReponse2.visible = false;
			TexteReponse3.visible = false;
			
			rb0.visible = false;
			rb1.visible = false;
			rb2.visible = false;
			rb3.visible = false;
			
			initVF();
			
			bilan.addEventListener( MouseEvent.CLICK, clicBilan );
			//bouton.height = 35;
			//bouton.width = 45;
		}
		
		function clicBilan(bEvt:MouseEvent)
		{
			TexteQuestion.visible = false;
			var s:String = new String();
			s="";
			
			ville.visible = false;
			monument.visible = false;
			musee.visible = false;
			transport.visible = false;
			
			bilan.visible = false;
			bilanImage = new BilanQCM();
			mc_parent.addChild(bilanImage);
			bilanImage.x = 52;
			bilanImage.y = 27.8;
			
			remarqueV = new TextArea();
			remarqueV.text = "";
			mc_parent.addChild(remarqueV);
			remarqueV.editable = false;
			remarqueV.x = 548.9;
			remarqueV.y = 228.9;
			remarqueV.width = 171.9;
			remarqueV.height = 44;
			
			remarqueT = new TextArea();
			remarqueT.text = "";
			mc_parent.addChild(remarqueT);
			remarqueT.editable = false;
			remarqueT.x = 548.9;
			remarqueT.y = 312;
			remarqueT.width = 171.9;
			remarqueT.height = 44;
			
			remarqueMu = new TextArea();
			remarqueMu.text = "";
			mc_parent.addChild(remarqueMu);
			remarqueMu.editable = false;
			remarqueMu.x = 548.9;
			remarqueMu.y = 391.6;
			remarqueMu.width = 171.9;
			remarqueMu.height = 44;
			
			remarqueMo = new TextArea();
			remarqueMo.text = "";
			mc_parent.addChild(remarqueMo);
			remarqueMo.editable = false;
			remarqueMo.x = 548.9;
			remarqueMo.y = 466.3;
			remarqueMo.width = 171.9;
			remarqueMo.height = 44;
			
			scoreV = new Texte(352.6, 234.7, 175.9, 36, 30, "Sylfaen");
			scoreV.setCouleur(0x000000); //#663366  663366
			mc_parent.addChild(scoreV);
			s=ctrV.toString()+"/"+questionsVille.length.toString();
			scoreV.setText(s);
			
			scoreT = new Texte(352.6, 310, 175.9, 36, 30, "Sylfaen");
			scoreT.setCouleur(0x000000); //#663366  663366
			mc_parent.addChild(scoreT);
			s=ctrT.toString()+"/"+questionsTransport.length.toString();
			scoreT.setText(s);
			
			scoreMu = new Texte(352.6, 390, 175.9, 36, 30, "Sylfaen");
			scoreMu.setCouleur(0x000000); //#663366  663366
			mc_parent.addChild(scoreMu);
			s=ctrMu.toString()+"/"+questionsMusee.length.toString();
			scoreMu.setText(s);
			
			scoreMo = new Texte(352.6, 470, 175.9, 36, 30, "Sylfaen");
			scoreMo.setCouleur(0x000000); //#663366  663366
			mc_parent.addChild(scoreMo);
			s=ctrMo.toString()+"/"+questionsMonument.length.toString();
			scoreMo.setText(s);
			
			remarqueV.text = appreciation(ctrV,questionsVille.length);
			remarqueT.text = appreciation(ctrT,questionsTransport.length);
			remarqueMo.text = appreciation(ctrMo,questionsMonument.length);
			remarqueMu.text = appreciation(ctrMu,questionsMusee.length);
		}
		
		function appreciation(a:Number,b:Number):String
		{
			var chaine:String = " "; 
			var temp:Number = b;
			var c:Number = (a*100)/temp;
			if(c < 50){
				chaine = "Ne vous découragez pas. Revisitez le mode apprentissage pour améliorer votre score";
			}
			else if(c <= 75){
				chaine =" vous vous y connaissez mais vous pouvez faire mieux. n'hésitez pas à revisiter le mode apprentissage";
			}
			else{
				chaine = "Très bon résultat. N'hésitez pas à revisiter souvent le mode apprentissage pour garder vos connaissances à jour";
			}
			return chaine;
		}
	}
}