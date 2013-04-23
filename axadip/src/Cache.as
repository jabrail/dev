/**
 * Created with IntelliJ IDEA.
 * User: ыфцацуауц
 * Date: 17.04.13
 * Time: 23:58
 * To change this template use File | Settings | File Templates.
 */
package {
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.primitives.Box;
import alternativa.engine3d.primitives.GeoSphere;

public class Cache {
    public var arrayPoints : Array = new Array();
    public var arrayBox: Array = new Array();
    public function Cache() {
    }
    public function createPoints() : void {
        for (var i: int=0; i<100; i++)
        {
        var sphere : GeoSphere = new GeoSphere(5, 5);
        sphere.setMaterialToAllSurfaces(new FillMaterial(0xFF2255));
            arrayPoints.push(sphere);
        }
    }
    public function getSphere():GeoSphere {
       if (arrayPoints.length!=0)
       {
           return arrayPoints.pop();
       }
        else
       {
        return null;
       }
    }
    public function setSphere(sphere : GeoSphere) : void {
        arrayPoints.push(sphere);
    }
    public function createBox() : void {
        for (var i : int =0; i<100; i++)
        {
            var box : Box = new Box(3,3,1,1,1,1,false,new FillMaterial(0xFF2255));
            arrayBox.push(box);
        }
    }
    public function getBox():Box {
        if (arrayBox.length!=0)
        {
            return arrayBox.pop();
        }
        else
        {
            return null;
        }
    }
    public function setBox(box : Box) : void {
        arrayPoints.push(box);
    }
}
}
