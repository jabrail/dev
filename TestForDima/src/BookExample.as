package
{
	import com.bit101.components.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import silin.book.*;
	import silin.gadgets.Preloader;
import silin.gadgets.book.Book;
import silin.gadgets.book.BookEvent;
import silin.gadgets.book.PageContent;


/**
	 * пример для листалки
	 * @author silin
	 */
	public class BookExample extends Sprite
	{
		private var _book:Book;
		private var _tablo:Label;

		public function BookExample():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_book = new Book(200, 260);
			
			_book.x = 50;
			_book.y = 50;
			
			//битмап подолжки
			//_book.paper = new BitmapData(200, 260, false, 0xFFFFFF);
			_book.paper = new paperBmd(0, 0);
			
			//иконка загрузки
			_book.preloaderIcon = Preloader;
			
			//иконка для обозначения ошибки/невозможности загрузки
			_book.errorIcon = errorMc;
			

			//заготовки для контента страниц
			var g:MovieClip = new globe();
			g.x = 150;
			g.y = 80;

			var comment:TextField = new TextField();
			comment.autoSize = TextFieldAutoSize.CENTER;
			comment.x = 100;
			comment.y = 210;
			comment.text = "картинка с диска,\n мувик из библиотеки\n плюс собственнно этот текст";
			comment.setTextFormat(new TextFormat("_sans", 12, 0xEAD5FF, false, false));
			comment.selectable = false;
			comment.mouseEnabled = false;
			
			/*
			var test:Shape = new Shape();
			test.graphics.beginFill(0x8080FF,0.25);
			test.graphics.drawCircle(0, 0, 25);
			test.x = 100;
			test.y = 200;
			*/

			//создание(определение) страниц книжки
			//датапровайдеру передаем массив объектов PageContent, инициализирующих загрузку 
			//или создающих контент, если переданы готовые дисплейОбжекты
			_book.dataProvider = [
				null,//нет листа, для имитации обложки
				new PageContent("cover.png"),//урл картинки или флешки
				new PageContent("train.jpg"),
				new PageContent("waterfall.jpg"),
				new PageContent("fig1.swf"),
				new PageContent("fig2.swf"),
				/*new PageContent("fig3.swf"),
				new PageContent("fig4.swf"),
				new PageContent("fig5.swf"),
				new PageContent("fig6.swf"),*/
				new PageContent("fig7.swf"),
				new PageContent("bg.jpg", g, comment) ,//картинка с диска, мувик, текст
				new PageContent("furcation.swf"),
				new PageContent("candle.swf"),
				new PageContent("fake.jpg"),//несуществующая картинка
				new PageContent()//пустая страница
			];
			 
			
			createControls();
			addChild(_book);
			
			//слушаем событие смены страниц (здесь только ради теста)
			_book.addEventListener(BookEvent.CHANGE_PAGE, onPageChange);

		}
		
		
		
		//элемемнты управления
		private function createControls():void
		{
			
			_tablo = new Label(this, 50, 315, "0");
			
			for (var i:int = 0; i < _book.length; i+=2)
			{
				var but:PushButton = new PushButton(this, 80 + 20 * i, 320, i + "-" + (i + 1), onPageButClick);
				but.setSize(35, 20);
			}
			var lbl:Label = new Label(this, 50, 350, "режим перелистывания");
			var rb:RadioButton;
			rb = new RadioButton(this, 50, 370, Book.JUMP, true, onRadioClick);
			rb = new RadioButton(this, 120, 370, Book.LEAF, false, onRadioClick);

			var cb:CheckBox;
			cb = new CheckBox(this, 260, 360, "листать колесом", onModeButClick);
			cb.selected = _book.wheelLeaf;
			cb = new CheckBox(this, 260, 380, "листать мышью", onModeButClick);
			cb.selected = _book.mouseLeaf;
			cb = new CheckBox(this, 260, 400, "листать за контент", onModeButClick);
			cb.selected = _book.contentLeaf;

			var tempSlider:HUISlider = new HUISlider(this, 50, 390, "темп", onSliderChange);
			tempSlider.maximum = 10;
			tempSlider.value = _book.speed;
			
		}
		
		//обработчик смены страниц книжки
		private function onPageChange(e:BookEvent):void
		{
			_tablo.text = "#" + e.currentPage;
		}

		//обработчик радикнопок режима
		private function onRadioClick(event:Event):void
		{
			var rb:RadioButton = event.currentTarget as RadioButton;
			_book.mode = rb.label;
		}

		//обработчик слайдера скрости
		private function onSliderChange(event:Event):void
		{
			_book.speed = HUISlider(event.currentTarget).value;
		}

		//обработчик чекбоксов
		private function onModeButClick(event:Event):void
		{
			var cb:CheckBox = event.currentTarget as CheckBox;
			switch(cb.label)
			{
				case "режим перелистывания":
				{
					_book.mode = cb.selected ? Book.LEAF : Book.JUMP;
					break;
				}
				
				case "листать колесом": 
				{
					_book.wheelLeaf = cb.selected;
					break;
				}
				
				case "листать мышью": 
				{
					_book.mouseLeaf = cb.selected;
					break;
				}
				
				case "листать за контент": 
				{
					_book.contentLeaf = cb.selected;
					break;
				}
				
			}
		}

		//обработчик кнопок страниц
		private function onPageButClick(event:Event):void
		{
			var but:PushButton = event.currentTarget as PushButton;
			var label:String = but.label;
			var n:int = parseInt(label.substr(0, label.indexOf("-")));
			_book.gotoPage(n);

		}
		
	}

}

