/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 07.03.13
 * Time: 7:36
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;

public class FormInpOut  extends Sprite{
    private var monthString : String = '';
    private var titleString : String = '';
    private var x_cor : Number = 0;
    private var y_cor : Number = 0;
    private var z_cor : Number = 0;
    public var monthStringInp : TextField = new TextField();
    public var titleStringInp : TextField = new TextField();
    public var x_corInp : TextField = new TextField();
    public var y_corInp : TextField = new TextField();
    public var z_corInp : TextField = new TextField();
    public var magnitudeInp : TextField = new TextField();
    public var crat : TextField = new TextField();

    public var sor_month_inp : TextField = new TextField();
    public var sor_month_inp_2 : TextField = new TextField();
    public var sor_min_h_inp : TextField = new TextField();
    public var sor_max_h_inp : TextField = new TextField();
    public var sor_max_mag_inp : TextField = new TextField();
    public var sor_min_mag_inp : TextField = new TextField();
    private var textColor: Number = 0xFFFFFF;
    private var borderColor: Number = 0xFFFFFF;

    public function FormInpOut() {
          monthStringInp.textColor = textColor;
          titleStringInp.textColor = textColor;
          x_corInp.textColor = textColor;
          y_corInp.textColor = textColor;
          z_corInp.textColor = textColor;
          magnitudeInp.textColor = textColor;
          crat.textColor = textColor;
          sor_month_inp.textColor = textColor;
          sor_min_h_inp.textColor = textColor;
          sor_max_h_inp.textColor = textColor;
          sor_max_mag_inp.textColor = textColor;
          sor_min_mag_inp.textColor = textColor;

    }
    public function addForm() : void {
        removeChilds();
        monthStringInp.type = TextFieldType.INPUT;
        titleStringInp.type = TextFieldType.INPUT;
        x_corInp.type =TextFieldType.INPUT;
        y_corInp.type = TextFieldType.INPUT;
        z_corInp.type = TextFieldType.INPUT;
        crat.type = TextFieldType.INPUT;
        magnitudeInp.type = TextFieldType.INPUT;
        var main : TextField = new TextField();
        main.text = 'Форма добавления события';
        main.width =300;
        main.x =150;
        main.y = 10;
        main.textColor = textColor;
        addChild(main);

        var labelText : TextField = new TextField();
        labelText.text = 'Дата';
        labelText.x =30;
        labelText.y = 30;
        labelText.textColor = textColor;
        monthStringInp.x = 300;
        monthStringInp.y = 30;
        monthStringInp.border = true;
        monthStringInp.height = 20;
        monthStringInp.borderColor = borderColor;
        addChild(labelText);
        addChild(monthStringInp);

        var labelText : TextField = new TextField();
        labelText.text = 'Описание';
        labelText.x = 30;
        labelText.y = 70;
        labelText.textColor = textColor;
        titleStringInp.x = 300;
        titleStringInp.y = 70;
        titleStringInp.border = true;
        titleStringInp.height = 20;
        titleStringInp.borderColor = borderColor;
        addChild(labelText);
        addChild(titleStringInp);

        var labelText : TextField = new TextField();
        labelText.text = 'Координата X';
        labelText.x = 30;
        labelText.y = 110;
        labelText.textColor = textColor;
        x_corInp.x = 300;
        x_corInp.y = 110;
        x_corInp.border = true;
        x_corInp.height = 20;
        x_corInp.borderColor = borderColor;
        addChild(labelText);
        addChild(x_corInp);

        var labelText : TextField = new TextField();
        labelText.text = 'Координата Y';
        labelText.x = 30;
        labelText.y = 150;
        labelText.textColor = textColor;
        y_corInp.x = 300;
        y_corInp.y = 150;
        y_corInp.border = true;
        y_corInp.height = 20;
        y_corInp.borderColor = borderColor;
        addChild(labelText);
        addChild(y_corInp);

        var labelText : TextField = new TextField();
        labelText.text = 'Координата Z';
        labelText.x = 30;
        labelText.y = 190;
        labelText.textColor = textColor;
        z_corInp.x = 300;
        z_corInp.y = 190;
        z_corInp.border = true;
        z_corInp.height = 20;
        z_corInp.borderColor = borderColor;
        addChild(labelText);
        addChild(z_corInp);

        var labelText : TextField = new TextField();
        labelText.text = 'Кратность';
        labelText.x = 30;
        labelText.y = 230;
        labelText.textColor = textColor;
        crat.x = 300;
        crat.y = 230;
        crat.border = true;
        crat.height = 20;
        crat.borderColor = borderColor;
        addChild(labelText);
        addChild(crat);

        var labelText : TextField = new TextField();
        labelText.text = 'Магнитуда';
        labelText.x = 30;
        labelText.y = 270;
        labelText.textColor = textColor;
        magnitudeInp.x = 300;
        magnitudeInp.y = 270;
        magnitudeInp.border = true;
        magnitudeInp.height = 20;
        magnitudeInp.borderColor = borderColor;
        addChild(labelText);
        addChild(magnitudeInp);

        var button : Sprite = new Sprite();
        button.graphics.beginFill(0xFF0000);
        button.graphics.drawRoundRect(0,0,300,30,3,3);
        button.x = 70;
        button.y = 310;
        var textAdd : TextField = new TextField();
        textAdd.text = 'Добавить';
        textAdd.x = 40+button.width/2;
        textAdd.y = 315;
        textAdd.height=20;
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRoundRect(0,0,300,30,3,3);
        hover.x = 70;
        hover.y = 310;
        addChild(button);
        addChild(textAdd);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, validate);


    }
    public function sortingForm_month() : void {
        removeChilds();
        sor_month_inp.type = TextFieldType.INPUT;
        sor_month_inp_2.type = TextFieldType.INPUT;

        var main : TextField = new TextField();
        main.text = 'Сортировка по Дате';
        main.x =150;
        main.y = 10;
        main.width = 300;
        main.textColor = textColor;
        addChild(main);
        var labelText : TextField = new TextField();
        labelText.text = 'От';
        labelText.x =30;
        labelText.y = 30;
        labelText.textColor = textColor;
        addChild(labelText);
        var labelText : TextField = new TextField();
        labelText.text = 'До';
        labelText.x =30;
        labelText.y = 75;
        labelText.textColor = textColor;
        sor_month_inp.x = 300;
        sor_month_inp.y = 30;
        sor_month_inp.border = true;
        sor_month_inp.height = 20;
        sor_month_inp.borderColor = borderColor;
        sor_month_inp_2.x = 300;
        sor_month_inp_2.y = 75;
        sor_month_inp_2.border = true;
        sor_month_inp_2.height = 20;
        sor_month_inp_2.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_month_inp);
        addChild(sor_month_inp_2);

        var button : Sprite = new Sprite();
        button.graphics.beginFill(0xFF0000);
        button.graphics.drawRoundRect(0,0,300,30,3,3);
        button.x = 70;
        button.y = 120;
        var textAdd : TextField = new TextField();
        textAdd.text = 'Сортировать';
        textAdd.x = 40+button.width/2;
        textAdd.y = 125;
        textAdd.height=20;
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRoundRect(0,0,300,30,3,3);
        hover.x = 70;
        hover.y = 120;
        addChild(button);
        addChild(textAdd);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, hover_clickHandler_month);
    }
    public function sortingForm_h() : void {
        removeChilds();
        sor_max_h_inp.type = TextFieldType.INPUT;
        sor_min_h_inp.type = TextFieldType.INPUT;
        var main : TextField = new TextField();
        main.text = 'Сортировка по глубине';
        main.x =150;
        main.y = 10;
        main.textColor = textColor;
        main.width = 300;
        addChild(main);
        var labelText : TextField = new TextField();
        labelText.text = 'Максимальная глубина';
        labelText.x =30;
        labelText.y = 30;
        labelText.width = 200;
        labelText.textColor = textColor;
        sor_max_h_inp.x = 300;
        sor_max_h_inp.y = 30;
        sor_max_h_inp.border = true;
        sor_max_h_inp.height = 20;
        sor_max_h_inp.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_max_h_inp);
        var labelText : TextField = new TextField();
        labelText.text = 'Минимальная глубина';
        labelText.x =30;
        labelText.y = 60;
        labelText.width = 200;
        labelText.textColor = textColor;
        sor_min_h_inp.x = 300;
        sor_min_h_inp.y = 60;
        sor_min_h_inp.border = true;
        sor_min_h_inp.height = 20;
        sor_min_h_inp.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_min_h_inp);
        var button : Sprite = new Sprite();
        button.graphics.beginFill(0xFF0000);
        button.graphics.drawRoundRect(0,0,300,30,3,3);
        button.x = 70;
        button.y = 90;
        var textAdd : TextField = new TextField();
        textAdd.text = 'Сортировать';
        textAdd.x = 40+button.width/2;
        textAdd.y = 95;
        textAdd.height=20;
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRoundRect(0,0,300,30,3,3);
        hover.x = 70;
        hover.y = 90;
        addChild(button);
        addChild(textAdd);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, hover_clickHandler_deep);
    }
    public function sortingForm_mag() : void {
        removeChilds();
        sor_max_mag_inp.type = TextFieldType.INPUT;
        sor_min_mag_inp.type = TextFieldType.INPUT;
        var main : TextField = new TextField();
        main.text = 'Сортировка по магнитуде';
        main.x =150;
        main.y = 10;
        main.width = 300;
        main.textColor = textColor;
        addChild(main);
        var labelText : TextField = new TextField();
        labelText.text = 'Максимальная магнитуда';
        labelText.x =30;
        labelText.y = 30;
        labelText.width = 200;
        labelText.textColor = textColor;
        sor_max_mag_inp.x = 300;
        sor_max_mag_inp.y = 30;
        sor_max_mag_inp.border = true;
        sor_max_mag_inp.height = 20;
        sor_max_mag_inp.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_max_mag_inp);
        var labelText : TextField = new TextField();
        labelText.text = 'Минимальная магнитуда';
        labelText.x =30;
        labelText.y = 60;
        labelText.width = 200;
        labelText.textColor = textColor;
        sor_min_mag_inp.x = 300;
        sor_min_mag_inp.y = 60;
        sor_min_mag_inp.border = true;
        sor_min_mag_inp.height = 20;
        sor_min_mag_inp.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_min_mag_inp);
        var button : Sprite = new Sprite();
        button.graphics.beginFill(0xFF0000);
        button.graphics.drawRoundRect(0,0,300,30,3,3);
        button.x = 70;
        button.y = 90;
        var textAdd : TextField = new TextField();
        textAdd.text = 'Сортировать';
        textAdd.x = 40+button.width/2;
        textAdd.y = 95;
        textAdd.height=20;
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRoundRect(0,0,300,30,3,3);
        hover.x = 70;
        hover.y = 90;
        addChild(button);
        addChild(textAdd);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, hover_clickHandler_magnitude);
    }

    public function addBase() : void {
        removeChilds();
        sor_max_mag_inp.type = TextFieldType.INPUT;
        sor_min_mag_inp.type = TextFieldType.INPUT;
        var main : TextField = new TextField();
        main.text = 'Добавить базу';
        main.x =150;
        main.y = 10;
        main.width = 300;
        main.textColor = textColor;
        addChild(main);
        var labelText : TextField = new TextField();
        labelText.text = 'Текст базы';
        labelText.x =30;
        labelText.y = 30;
        labelText.width = 200;
        labelText.textColor = textColor;
        sor_max_mag_inp.x = 300;
        sor_max_mag_inp.y = 30;
        sor_max_mag_inp.border = true;
        sor_max_mag_inp.height = 20;
        sor_max_mag_inp.borderColor = borderColor;
        addChild(labelText);
        addChild(sor_max_mag_inp);
        var button : Sprite = new Sprite();
        button.graphics.beginFill(0xFF0000);
        button.graphics.drawRoundRect(0,0,300,30,3,3);
        button.x = 70;
        button.y = 90;
        var textAdd : TextField = new TextField();
        textAdd.text = 'Добавить';
        textAdd.x = 40+button.width/2;
        textAdd.y = 95;
        textAdd.height=20;
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRoundRect(0,0,300,30,3,3);
        hover.x = 70;
        hover.y = 90;
        addChild(button);
        addChild(textAdd);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, hover_clickHandler_add_Base);
    }
    public function validate(e: MouseEvent) : Boolean {
        var bool : Boolean = true;
        if (monthStringInp.text=='') { bool = false;   monthStringInp.borderColor = 0xFF0000; } else { monthStringInp.borderColor = 0x000000; }
        if (titleStringInp.text=='') { bool = false;   titleStringInp.borderColor = 0xFF0000; } else { titleStringInp.borderColor = 0x000000; }
        if (x_corInp.text=='')  { bool = false; x_corInp.borderColor = 0xFF0000; }  else { x_corInp.borderColor = 0x000000; }
        if (y_corInp.text=='')  { bool = false; y_corInp.borderColor = 0xFF0000; }    else { y_corInp.borderColor = 0x000000; }
        if (z_corInp.text=='')  { bool = false; z_corInp.borderColor = 0xFF0000; } else { z_corInp.borderColor = 0x000000; }
        if (crat.text=='')  { bool = false; crat.borderColor = 0xFF0000; }   else { crat.borderColor = 0x000000; }
        if (magnitudeInp.text=='')  { bool = false; magnitudeInp.borderColor = 0xFF0000; }   else { magnitudeInp.borderColor = 0x000000; }
        if (bool) dispatchEvent(new Event(MyEvents.ADD_POINT));
        return bool;
    }
    private function removeChilds() : void {
                   removeChildren();

    }

    private function hover_clickHandler_magnitude(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.MAGNITUDE_SORT));
    }

    private function hover_clickHandler_deep(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.DEPP_SORT));
    }

    private function hover_clickHandler_month(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.MONTH_SORT));
    }

    private function hover_clickHandler_add_Base(event:MouseEvent):void {
        dispatchEvent(new Event(MyEvents.ADD_BASE));

    }
}
}
