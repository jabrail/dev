/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 28.04.13
 * Time: 0:50
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Sprite;

import silin.gadgets.book.Book;
import silin.gadgets.book.PageContent;

[SWF(width="800", height="600",frameRate="60")]

public class TutorialView extends Sprite{
    [Embed(source = '/bookPages/1_317.jpg')]
    private var Page_1:Class;
    [Embed(source = '/bookPages/apparatnui-pedikur.jpg')]
    private var Page_2:Class;
    [Embed(source = '/bookPages/images (1).jpg')]
    private var Page_3:Class;
    [Embed(source = '/bookPages/images (2).jpg')]
    private var Page_4:Class;
    [Embed(source = '/bookPages/images.jpg')]
    private var Page_5:Class;

    private var book : Book = new Book(800,600)
    public function TutorialView() {
        var btm_1 : Bitmap = new Page_1();
        var btm_2 : Bitmap = new Page_2();
        var btm_3 : Bitmap = new Page_3();
        var btm_4 : Bitmap = new Page_4();
        var btm_5 : Bitmap = new Page_5();
        book.paper = new paperBmd(0, 0);

        book.dataProvider = [
            null,//нет листа, для имитации обложки
            new PageContent("fig1.swf"),
            new PageContent("fig2.swf"),
            new PageContent("fig3.swf"),
             new PageContent("fig4.swf"),
             new PageContent("fig5.swf"),
             new PageContent("fig6.swf"),
            new PageContent("fig7.swf"),
            new PageContent("bg.jpg") ,//картинка с диска, мувик, текст
            new PageContent()//пустая страница
        ];
        addChild(book);
    }
}
}
