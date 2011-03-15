package netflow;
import javafx.geometry.Point2D;
import javafx.scene.Node;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.transform.Affine;
import javafx.util.Math;

public class MyLine extends MyNode {
    public var node:Node;

    public var a:MyShape;
    public var b:MyShape;

    public function rebuild():Void {
        var u:Point2D = a.findBoundaryPoint(b.position, a.position);
        var v:Point2D = b.findBoundaryPoint(a.position, b.position);

        var l:Float = Math.sqrt(Tools.pointsLenSqr(u, v));


        var path =             Path {
                transforms: [
                    Affine {
                        mxx: (v.x-u.x)/l
                        mxy: (v.y-u.y)/l
                        myx: (v.y-u.y)/l
                        myy: -(v.x-u.x)/l
                        tx: u.x
                        ty: u.y
                    }
                ]
            elements: [
                MoveTo {
                    x: 0
                    y: 0
                }
                LineTo {
                    x: l
                    y: 0
                }
                LineTo {
                    x: l-10
                    y: 5
                }
                MoveTo {
                    x: l
                    y: 0
                }
                LineTo {
                    x: l-10
                    y: -5
                }

                MoveTo {
                    x: 0
                    y: 0
                }
                LineTo {
                    x: 10
                    y: -5
                }

                MoveTo {
                    x: 0
                    y: 0
                }
                LineTo {
                    x: 10
                    y: 5
                }
                ]
            }

        node.layoutX = path.boundsInParent.width/2 + path.boundsInParent.minX;
        node.layoutY = path.boundsInParent.height/2 + path.boundsInParent.minY;
        println("conn layout {node.layoutX} {node.layoutY} {path.boundsInLocal}");

        content = [
            path,
            node
        ]
    }

    init {
        rebuild();
    }
}
